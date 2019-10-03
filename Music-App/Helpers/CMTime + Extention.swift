//
//  CMTime + Extention.swift
//  Music-App
//
//  Created by Michael Sidoruk on 03/10/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import AVKit

extension CMTime {
    
    func toDisplayString() -> String {
        guard !CMTimeGetSeconds(self).isNaN else { return "" }
        
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        let timeFormattedString = String(format: "%02d:%02d", minutes, seconds)
        return timeFormattedString
    }
    
}

