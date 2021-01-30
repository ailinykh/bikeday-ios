//
//  FeedItemCollectionViewCell.swift
//  Bikeday
//
//  Created by Anton Ilinykh on 28.01.2021.
//

import UIKit

class FeedItemCollectionViewCell: UICollectionViewCell {
    private(set) var item: FeedItem?
    
    func set(item: FeedItem) {
        self.item = item
    }
}
