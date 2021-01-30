//
//  FeedCollectionViewController.swift
//  Bikeday
//
//  Created by Anton Ilinykh on 28.01.2021.
//

import UIKit

class FeedCollectionViewController: UICollectionViewController {

    var service: APIService!
    var items: [FeedItem] = []
    
    convenience init(service: APIService) {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
        self.service = service
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        collectionView.register(AnnouncementCollectionViewCell.self, forCellWithReuseIdentifier: FeedItemType.announcement.rawValue)
        collectionView.register(UINib(nibName: "AnnouncementCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: FeedItemType.announcement.rawValue)
        collectionView.register(PromotionCollectionViewCell.self, forCellWithReuseIdentifier: FeedItemType.promotion.rawValue)
        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: FeedItemType.gallery.rawValue)
        collectionView.register(TimetableCollectionViewCell.self, forCellWithReuseIdentifier: FeedItemType.timetable.rawValue)
        collectionView.backgroundColor = .systemBackground
        
        service.fetchFeed() { [weak self] result in
            switch result {
            case .failure:
                return
            case .success(let items):
                self?.items = items
                self?.collectionView.reloadData()
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.type.rawValue, for: indexPath) as! FeedItemCollectionViewCell
    
        // Configure the cell
        cell.contentView.backgroundColor = .secondarySystemBackground
        cell.set(item: item)
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}


extension FeedCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 60
        let height = width * 1.22
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 45
    }
}
