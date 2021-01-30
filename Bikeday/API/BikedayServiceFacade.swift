//
//  APIServiceOnMainQueueDispatcher.swift
//  Bikeday
//
//  Created by Anton Ilinykh on 28.01.2021.
//

import Foundation

class APIServiceOnMainQueueDispatcher: APIService {
    var service: BikedayService!
    
    init(service: BikedayService) {
        self.service = service
    }
    
    func fetchFeed(_ completion: @escaping (FeedResult) -> Void) {
        service.fetchFeed() { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
