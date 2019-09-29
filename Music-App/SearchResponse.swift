//
//  SearchResponse.swift
//  Music-App
//
//  Created by Michael Sidoruk on 30/09/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Decodable {
    var trackName: String
    var artistName: String
    var collectionName: String?
    var artworkUrl100: String?
}


