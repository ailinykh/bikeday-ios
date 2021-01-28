//
//  FeedCollectionViewControllerTests.swift
//  BikedayTests
//
//  Created by Anton Ilinykh on 28.01.2021.
//

import XCTest

class FeedCollectionViewControllerTests: XCTestCase {

    func test_FeedViewController_loadsFeed() {
        let items = [
            FeedItem(type: "1", category: "1", title: "1"),
            FeedItem(type: "2", category: "2", title: "2")
        ]
        let service = BikedayServiceMock(items: items)
        let sut = FeedCollectionViewController(service: service)
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.collectionView(sut.collectionView, numberOfItemsInSection: 0), 2)
    }

}

class BikedayServiceMock: BikedayService {
    var items: [FeedItem]?
    
    init(items: [FeedItem]?) {
        self.items = items
    }
    
    override func fetchFeed(_ completion: @escaping ([FeedItem]?, Error?) -> ()) {
            completion(items, nil)
    }
}
