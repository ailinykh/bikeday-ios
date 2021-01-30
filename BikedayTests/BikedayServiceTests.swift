//
//  BikedayServiceTests.swift
//  BikedayTests
//
//  Created by Anton Ilinykh on 27.01.2021.
//

import XCTest
@testable import Bikeday

class BikedayServiceTests: XCTestCase {

    func test_BikedayService_FetchesFeedItems() {
        let service = NetworkServiceMock() {_, completion in
            let data = """
            [
            {"type": "announcement", "category": "1", "title": "1"},
            {"type": "promotion", "category": "2", "title": "2"},
            {"type": "gallery", "category": "3", "title": "3"},
            {"type": "timetable", "category": "4", "title": "4"}
            ]
            """.data(using: .utf8)
            completion(data, nil, nil)
        }
        
        let sut = BikedayService(service: service)
        let exp = expectation(description: "Waits for feed to loading")
        
        sut.fetchFeed() { items, error in
            XCTAssertNil(error)
            XCTAssertNotNil(items)
            XCTAssertEqual(items?.count, 4)
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 0.1)
    }
    
    func test_BikedayService_HandlesUnknownFeedItemType() {
        let service = NetworkServiceMock() {_, completion in
            let data = """
            [
            {"type": "announcement", "category": "1", "title": "1"},
            {"type": "something new", "category": "2", "title": "2"}
            ]
            """.data(using: .utf8)
            completion(data, nil, nil)
        }
        
        let sut = BikedayService(service: service)
        let exp = expectation(description: "Waits for feed to loading")
        
        sut.fetchFeed() { items, error in
            XCTAssertNil(error)
            XCTAssertNotNil(items)
            XCTAssertEqual(items?.count, 2)
            XCTAssertEqual(items?.last?.type, .unknown)
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 0.1)
    }
}

typealias FetchCompletion = (Data?, URLResponse?, Error?) -> ()

class NetworkServiceMock: NetworkService {
    var fetchMock: ((URL, FetchCompletion) -> ())!
    
    init(fetchMock: ((URL, FetchCompletion) -> ())? = {_,_ in}) {
        self.fetchMock = fetchMock
    }
    
    func fetch(url: URL, _ completion: @escaping FetchCompletion) {
        DispatchQueue.global().async { [weak self] in
            self?.fetchMock(url, completion)
        }
    }
}
