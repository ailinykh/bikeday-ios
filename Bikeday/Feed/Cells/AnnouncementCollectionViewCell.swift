//
//  AnnouncementCollectionViewCell.swift
//  Bikeday
//
//  Created by Anton Ilinykh on 28.01.2021.
//

import UIKit

class AnnouncementCollectionViewCell: FeedItemCollectionViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func set(item: FeedItem) {
        super.set(item: item)
        categoryLabel.text = item.category
        titleLabel.text = item.title
//        descriptionLabel.text = item.description
        
        guard let url = item.backgroundImageURL else { return }
        backgroundImageView.load(from: url)
    }
}

extension UIImageView {
    func load(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            }
        }
    }
}
