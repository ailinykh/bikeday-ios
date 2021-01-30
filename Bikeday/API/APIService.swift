//
//  APIService.swift
//  Bikeday
//
//  Created by Anton Ilinykh on 28.01.2021.
//

import Foundation

enum FeedItemType: String, Decodable {
    case announcement
    case promotion
    case gallery
    case timetable
    case unknown
    
    init?(rawValue: String) {
        switch rawValue {
        case "announcement":
            self = .announcement
        case "promotion":
            self = .promotion
        case "gallery":
            self = .gallery
        case "timetable":
            self = .timetable
        default:
            self = .unknown
        }
    }
}

struct FeedItem: Decodable {
    let type: FeedItemType
    let category: String
    let title: String
    let backgroundImageURL: URL?
}

typealias FeedResult = Swift.Result<[FeedItem], Error>

protocol APIService {
    func fetchFeed(_ completion: @escaping (FeedResult) -> Void)
}
