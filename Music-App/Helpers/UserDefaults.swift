//
//  UserDefaults.swift
//  Music-App
//
//  Created by Michael Sidoruk on 05/10/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    static let favoriteTrackKey = "favoriteTrackKey"
    
    func savedTracks() -> [SearchViewModel.Cell] {
        let defaults = UserDefaults.standard
        
        guard let savedTrack = defaults.object(forKey: UserDefaults.favoriteTrackKey) as? Data else { return [] }
        guard let decodedTracks = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedTrack) as? [SearchViewModel.Cell] else { return [] }
        return decodedTracks
    }
    
}
