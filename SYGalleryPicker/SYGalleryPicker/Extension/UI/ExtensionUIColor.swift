//
//  ExtensionUIColor.swift
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
    ///hex：#DCEDC8 ; rgb：(220, 237, 200)
    ///```
    class var green_DCEDC8: UIColor {
        get { return UIColor(0xDCEDC8) }
    }
    
    ///```
    ///hex：#66982D ; rgb：(102, 152, 45)
    ///```
    class var green_66982D: UIColor {
        get { return UIColor(0x66982D) }
    }
    
    ///```
    ///hex：#B8D29B ; rgb：(184, 210, 155)
    ///```
    class var green_B8D29B: UIColor {
        get { return UIColor(0xB8D29B) }
    }
    
    ///```
    ///hex：#B6D293 ; rgb：(182, 210, 147)
    ///```
    class var green_B6D293: UIColor {
        get { return UIColor(0xB6D293) }
    }
    
    ///```
    ///hex：#008800 ; rgb：(0, 136, 0)
    ///```
    class var green_008800: UIColor {
        get { return UIColor(0x008800) }
    }
    
    ///```
    ///hex：#94B856 ; rgb：(148, 184, 86)
    ///```
    class var green_94B856: UIColor {
        get { return UIColor(0x94B856) }
    }
    
    
    
    
    ///```
    ///hex：#E44D32 ; rgb：(228, 77, 50)
    ///```
    class var red_E44D32: UIColor {
        get { return UIColor(0xE44D32) }
    }
    
    ///```
    ///hex：#C1272D ; rgb：(193, 39, 45)
    ///```
    class var red_C1272D: UIColor {
        get { return UIColor(0xC1272D) }
    }
    
    ///```
    ///hex：#ED2626 ; rgb：(237, 38, 38)
    ///```
    class var red_ED2626: UIColor {
        get { return UIColor(0xED2626) }
    }
    
    ///```
    ///hex：#CC0000 ; rgb：(204, 0, 0)
    ///```
    class var red_CC0000: UIColor {
        get { return UIColor(0xCC0000) }
    }
    
    ///```
    ///hex：#F71800 ; rgb：(247, 24, 0)
    ///```
    class var red_F71800: UIColor {
        get { return UIColor(0xF71800) }
    }
    
    ///```
    ///hex：#DD502B ; rgb：(221, 80, 43)
    ///```
    class var red_DD502B: UIColor {
        get { return UIColor(0xDD502B) }
    }
    
    ///```
    ///hex：#FF2000 ; rgb(255, 32, 0)
    ///```
    class var red_FF2000: UIColor {
        get { return UIColor(0xFF2000) }
    }
    
    
    
    ///```
    ///hex：#F2F2F2 ; rgb：(242, 242, 242)
    ///```
    class var gray_F2F2F2: UIColor {
        get { return UIColor(0xF2F2F2) }
    }
    
    ///```
    ///hex：#E5E5E5 ; rgb：(229, 229, 229)
    ///```
    class var gray_E5E5E5: UIColor {
        get { return UIColor(0xE5E5E5) }
    }
    
    ///```
    ///hex：#E5E5EA ; rgb：(229, 229, 234)
    ///```
    class var gray_E5E5EA: UIColor {
        get { return UIColor(0xE5E5EA) }
    }

    ///```
    ///hex：#E4E4E4 ; rgb：(228, 228, 228)
    ///```
    class var gray_E4E4E4: UIColor {
        get { return UIColor(0xE4E4E4) }
    }
    
    ///```
    ///hex：#D7D7D7 ; rgb：(215, 215, 215)
    ///```
    class var gray_D7D7D7: UIColor {
        get { return UIColor(0xD7D7D7) }
    }
    
    ///```
    ///hex：#DCDCDC ; rgb：(220, 220, 220)
    ///```
    class var gray_DCDCDC: UIColor {
        get { return UIColor(0xDCDCDC) }
    }
    
    ///```
    ///hex：#CACACA ; rgb：(202, 202, 202)
    ///```
    class var gray_CACACA: UIColor {
        get { return UIColor(0xCACACA) }
    }
    
    ///```
    ///hex：#C7C7CC ; rgb：(199, 199, 204)
    ///```
    class var gray_C7C7CC: UIColor {
        get { return UIColor(0xC7C7CC) }
    }
    
    ///```
    ///hex：#BBBBBB ; rgb：(187, 187, 187)
    ///```
    class var gray_BBBBBB: UIColor {
        get { return UIColor(0xBBBBBB) }
    }
    
    ///```
    ///hex：#999999 ; rgb：(153, 153, 153)
    ///```
    class var gray_999999: UIColor {
        get { return UIColor(0x999999) }
    }
    
    ///```
    ///hex：#979797 ; rgb：(151, 151, 151)
    ///```
    class var gray_979797: UIColor {
        get { return UIColor(0x979797) }
    }
    
    ///```
    ///hex：#818181 ; rgb：(129, 129, 129)
    ///```
    class var gray_818181: UIColor {
        get { return UIColor(0x818181) }
    }

    ///```
    ///hex：#808080 ; rgb：(128, 128, 128)
    ///```
    class var gray_808080: UIColor {
        get { return UIColor(0x808080) }
    }
    
    ///```
    ///hex：#666666 ; rgb：(102, 102, 102)
    ///```
    class var gray_666666: UIColor {
        get { return UIColor(0x666666) }
    }
    
    ///```
    ///hex：#54545407 ; rgba：(84, 84, 84, 178)
    ///```
    class var gray_54545407: UIColor {
        get { return UIColor(0x545454, alpha: 0.7) }
    }
    
    ///```
    ///hex：#5A5A5A ; rgb：(90, 90, 90)
    ///```
    class var gray_5A5A5A: UIColor {
        get { return UIColor(0x5A5A5A) }
    }
    
    ///```
    ///hex：#464646 ; rgb：(70, 70, 70)
    ///```
    class var gray_464646: UIColor {
        get { return UIColor(0x464646) }
    }
    
    ///```
    ///hex：#444444 ; rgb：(68, 68, 68)
    ///```
    class var gray_444444: UIColor {
        get { return UIColor(0x444444) }
    }
    
    ///```
    ///hex：#353535 ; rgb：(53, 53, 53)
    ///```
    class var gray_353535: UIColor {
        get { return UIColor(0x353535) }
    }
    
    ///```
    ///hex：#282828 ; rgb：(40, 40, 40)
    ///```
    class var gray_282828: UIColor {
        get { return UIColor(0x282828) }
    }
    
    ///```
    ///hex：#171717 ; rgb(23, 23, 23)
    ///```
    class var gray_171717: UIColor {
        get { return UIColor(0x171717) }
    }
    
    ///```
    ///hex：#101010 ; rgb：(16, 16, 16)
    ///```
    class var gray_101010: UIColor {
        get { return UIColor(0x101010) }
    }
    
    ///```
    ///hex：#E3E3E3 ; rgb：(227, 227, 227)
    ///```
    class var gray_E3E3E3: UIColor {
        get { return UIColor(0xE3E3E3) }
    }
    
    ///```
    ///hex：#E8E8E8 ; rgb：(232, 232, 232)
    ///```
    class var gray_E8E8E8: UIColor {
        get { return UIColor(0xE8E8E8) }
    }
    
    ///```
    ///hex：#D1D1D1 ; rgb：(209, 209, 209)
    ///```
    class var gray_D1D1D1: UIColor {
        get { return UIColor(0xD1D1D1) }
    }
    
    ///```
    ///hex：#CDCDCD ; rgb：(205, 205, 205)
    ///```
    class var gray_CDCDCD: UIColor {
        get { return UIColor(0xCDCDCD) }
    }
    
    ///```
    ///hex：#5C5C5C ; rgb：(92, 92, 92)
    ///```
    class var gray_5C5C5C: UIColor {
        get { return UIColor(0x5C5C5C) }
    }
    
    ///```
    ///hex：#B2B2B2 ; rgb：(178, 178, 178)
    ///```
    class var gray_B2B2B2: UIColor {
        get { return UIColor(0xB2B2B2) }
    }
    
    ///```
    ///hex：#EEEEEE ; rgb：(238, 238, 238)
    ///```
    class var gray_EEEEEE: UIColor {
        get { return UIColor(0xEEEEEE) }
    }
    
    
    
    
    ///```
    ///hex：#FF8800 ; rgb：(255, 136, 0)
    ///```
    class var orange_FF8800: UIColor {
        get { return UIColor(0xFF8800) }
    }
    
    
    
    
    ///```
    ///hex：#00008B ; rgb：(0, 0, 139)
    ///```
    class var blue_00008B: UIColor {
        get { return UIColor(0x00008B) }
    }
    
    ///```
    ///hex：#00FFFF ; rgb：(0, 255, 255)
    ///```
    class var blue_00FFFF: UIColor {
        get { return UIColor(0x00FFFF) }
    }
    
    ///```
    ///hex：#40B5F2 ; rgb：(64, 181, 242)
    ///```
    class var blue_40B5F2: UIColor {
        get { return UIColor(0x40B5F2) }
    }
    
    
    
    ///```
    ///hex：#CC00CC ; rgb：(204, 0, 204)
    ///```
    class var purple_CC00CC: UIColor {
        get { return UIColor(0xCC00CC) }
    }
    
}
