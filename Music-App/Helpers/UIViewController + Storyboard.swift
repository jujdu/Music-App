//
//  UIViewController + Storyboard.swift
//  Music-App
//
//  Created by Michael Sidoruk on 30/09/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class func loadFromStoryboard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        } else {
            fatalError("Error: No initial view controller in \(name) storyboard")
        }
    }
    
}

