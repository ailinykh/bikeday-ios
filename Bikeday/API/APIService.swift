//
//  APIService.swift
//  Bikeday
//
//  Created by Anton Ilinykh on 28.01.2021.
//

import Foundation

struct FeedItem: Decodable {
    let type: String
    let category: String
    let title: String
}

protocol APIService {
    func fetchFeed(_ completion: @escaping ([FeedItem]?, Error?) -> Void)
}
