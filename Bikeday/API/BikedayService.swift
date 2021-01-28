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
    
    func fetchFeed(_ completion: @escaping ([FeedItem]?, Error?) -> Void) {
        let url = URL(string: "https://bikeday.me/api/feed")!
        service.fetch(url: url) { (data, resp, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let object = try JSONDecoder().decode([FeedItem].self, from: data)
                completion(object, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
}
