//
//  UIColorExtension.swift
//  SYGalleryPicker
//
//  Created by IrvingHuang on 2019/11/4.
//  Copyright © 2019 Sinyi Realty Inc. All rights reserved.
// 

import UIKit

extension UIColor {
    
    /// UIColor init
    ///
    /// - Parameter hex: 0x000000 to 0xffffff
    convenience init (_ hex: Int) {
        self.init(hex, alpha: 1.0)
    }
    
    /// UIColor init
    ///
    /// - Parameters:
    ///   - hex: 0x000000 to 0xffffff
    ///   - alpha: range from 0.0 to 1.0
    convenience init (_ hex: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat((hex >> 16) & 0xFF) / 255.0,
                  green:CGFloat((hex >> 8) & 0xFF) / 255.0,
                  blue: CGFloat(hex & 0xFF) / 255.0,
                  alpha: alpha)
    }

    ///```
    ///hex：#8BC34A ; rgb：(139, 195, 74)
    ///```
    class var green_8BC34A: UIColor {
        get { return UIColor(0x8BC34A) }
    }
    
    ///```
    ///hex：#008800 ; rgb：(0, 136, 0)
    ///```
    class var green_008800: UIColor {
        get { return UIColor(0x008800) }
    }
    
    ///```
    ///hex：#808080 ; rgb：(128, 128, 128)
    ///```
    class var gray_808080: UIColor {
        get { return UIColor(0x808080) }
    }
    
    ///```
    ///hex：#464646 ; rgb：(70, 70, 70)
    ///```
    class var gray_464646: UIColor {
        get { return UIColor(0x464646) }
    }

    ///```
    ///hex：#007AFF ; rgb：(0, 122, 255)
    ///```
    class var blue_007AFF: UIColor {
        get { return UIColor(0x007AFF) }
    }

    
}
