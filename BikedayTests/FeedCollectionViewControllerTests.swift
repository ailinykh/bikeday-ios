//
//  FeedCollectionViewControllerTests.swift
//  BikedayTests
//
//  Created by Anton Ilinykh on 28.01.2021.
//

import XCTest

class FeedCollectionViewControllerTests: XCTestCase {

    func makeItem(type: FeedItemType = .announcement, category: String = "Category", title: String = "Title") -> FeedItem {
        return FeedItem(type: type, category: category, title: title, backgroundImageURL: nil)
    }
    
    func test_FeedViewController_loadsFeed() {
        let items = [
            makeItem(type: .announcement),
            makeItem(type: .gallery),
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
