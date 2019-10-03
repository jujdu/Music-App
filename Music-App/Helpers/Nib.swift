//
//  Nib.swift
//  Music-App
//
//  Created by Michael Sidoruk on 04/10/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

extension UIView {
    
    class func loadFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
}
