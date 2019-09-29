//
//  NetworkService.swift
//  Music-App
//
//  Created by Michael Sidoruk on 30/09/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit
import Alamofire

class NetworkService {
    
    func fetchTracks(searchText: String, completion: @escaping (SearchResponse?) -> ()) {
        
        guard let url = URL(string: "https://itunes.apple.com/search") else { return }
        
        let parameters = [
            "term": searchText,
            "limit": "10",
            "media": "music"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (response) in
            if let error = response.error {
                print("Error requesting data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = response.data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let objects = try decoder.decode(SearchResponse.self, from: data)
                completion(objects)
            } catch {
                print("Failed decoding JSON", error)
                completion(nil)
            }
        }
        
    }
    
}
