//
//  BikedayService.swift
//  Bikeday
//
//  Created by Anton Ilinykh on 27.01.2021.
//

import Foundation

protocol NetworkService {
    func fetch(url: URL, _ completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: NetworkService {
    func fetch(url: URL, _ completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.dataTask(with: url, completionHandler: completion).resume()
    }
}

class BikedayService: APIService {
    var service: NetworkService!
    
    init(service: NetworkService? = URLSession.shared) {
        self.service = service
    }
    
    func fetchFeed(_ completion: @escaping (FeedResult) -> Void) {
        let url = URL(string: "https://bikeday.me/api/feed")!
        service.fetch(url: url) { (data, resp, error) in
            completion(FeedResult(catching: { () -> [FeedItem] in
                try JSONDecoder().decode([FeedItem].self, from: data!)
            }))
        }
    }
}
