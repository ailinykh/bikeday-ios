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
            {"type": "1", "category": "1", "title": "1"},
            {"type": "2", "category": "2", "title": "2"},
            {"type": "3", "category": "3", "title": "3"},
            {"type": "4", "category": "4", "title": "4"}
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
