//
//  Settings.swift
//  SYGalleryPicker
//
//  Created by IrvingHuang on 2019/11/5.
//  Copyright © 2019 Sinyi Realty Inc. All rights reserved.
//

import UIKit

public enum selectLocation {
    case leftTop
    case rightTop
    case leftBottom
    case rightBottom
}

public protocol SYGalleryPickerSettings {

    /// 選取數量
    var maxPickNumber: Int { get set }
    /// 呈現照片欄位
    var countInRow: (_ verticalSize: UIUserInterfaceSizeClass, _ horizontalSize: UIUserInterfaceSizeClass) -> Int { get set }
    /// 標題顏色
    var tintColor: UIColor { get set }
    /// 選取顏色
    var pickColor: UIColor { get set }
    /// 背景顏色
    var backgroundColor: UIColor { get set }
    /// 選取顯示數字還是打勾
    var selectWithCount: Bool { get set }
    /// 選取的標示所屬的位置
    var selectMarkLocation: selectLocation { get set }
    
}

final class TASetting: SYGalleryPickerSettings {
    
    var maxPickNumber: Int = 20
    var countInRow: (_ verticalSize: UIUserInterfaceSizeClass, _ horizontalSize: UIUserInterfaceSizeClass) -> Int = {(verticalSize: UIUserInterfaceSizeClass, horizontalSize: UIUserInterfaceSizeClass) -> Int in
        switch (verticalSize, horizontalSize) {
        case (.regular, .compact): // iPhone portrait
            return 4
        case (.compact, .regular): // iPhone landscape
            return 6
        case (.compact, .compact): // iPhone 5 6 landscape
            return 6
        case (.regular, .regular): // iPad portrait/landscape
            return 8
        default:
            return 4
        }
    }
    var tintColor: UIColor = .white
    var pickColor: UIColor = UIColor(0xffc107)
    var backgroundColor: UIColor = .white
    var selectWithCount: Bool = true
    var selectMarkLocation: selectLocation = .rightTop
    
}

final class IMSetting: SYGalleryPickerSettings {
    var maxPickNumber: Int = 10
    var countInRow: (_ verticalSize: UIUserInterfaceSizeClass, _ horizontalSize: UIUserInterfaceSizeClass) -> Int = {(verticalSize: UIUserInterfaceSizeClass, horizontalSize: UIUserInterfaceSizeClass) -> Int in
        switch (verticalSize, horizontalSize) {
        case (.regular, .compact): // iPhone portrait
            return 4
        case (.compact, .regular): // iPhone landscape
            return 6
        case (.compact, .compact): // iPhone 5 6 landscape
            return 6
        case (.regular, .regular): // iPad portrait/landscape
            return 8
        default:
            return 4
        }
    }
    var tintColor: UIColor = UIColor(0x4a4a4a)
    var pickColor: UIColor = .clear
    var backgroundColor: UIColor = .white
    var selectWithCount: Bool = false
    var selectMarkLocation: selectLocation = .rightBottom
    
}

class defaultSetting: SYGalleryPickerSettings {
    var maxPickNumber: Int = 10
    var countInRow: (_ verticalSize: UIUserInterfaceSizeClass, _ horizontalSize: UIUserInterfaceSizeClass) -> Int = {(verticalSize: UIUserInterfaceSizeClass, horizontalSize: UIUserInterfaceSizeClass) -> Int in
        switch (verticalSize, horizontalSize) {
        case (.regular, .compact): // iPhone portrait
            return 4
        case (.compact, .regular): // iPhone landscape
            return 6
        case (.compact, .compact): // iPhone 5 6 landscape
            return 6
        case (.regular, .regular): // iPad portrait/landscape
            return 8
        default:
            return 4
        }
    }
    var tintColor: UIColor = .black
    var pickColor: UIColor = .blue_00008B
    var backgroundColor: UIColor = .white
    var selectWithCount: Bool = true
    var selectMarkLocation: selectLocation = .leftTop
    
}
