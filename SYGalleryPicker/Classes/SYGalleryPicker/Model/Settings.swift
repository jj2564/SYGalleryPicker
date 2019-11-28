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

// MARK: - Protocol
public protocol SYGalleryPickerSettings {

    // MARK: Enviorment
    /// 選取數量
    var pickLimitCount: Int { get }
    /// 呈現照片欄位
    var countInRow: (_ verticalSize: UIUserInterfaceSizeClass, _ horizontalSize: UIUserInterfaceSizeClass) -> Int { get }
    /// 是否帶入標題文字取代選取相簿
    var titleText: Bool { get }
    /// 取消按鈕的文字
    var cancelButtonText: String { get }
    /// 確認按鈕的文字
    var confirmButtonText: String { get }
    
    // MARK: Picker Style
    /// 標題顏色
    var tintColor: UIColor? { get }
    /// 標題字的顏色
    var tintTextColor: UIColor? { get }
    /// 背景顏色
    var backgroundColor: UIColor { get }
    
    // MARK: Selected style
    /// 選取顏色
    var pickedColor: UIColor { get }
    /// 選取的標示所屬的位置
    var pickedMarkLocation: selectLocation { get }
    /// 選取顯示數字還是打勾
    var isPickedWithCount: Bool { get }
    /// 是否顯示選取外框
    var isPickWithBorder: Bool { get }
}

public extension SYGalleryPickerSettings {
    
    var pickLimitCount: Int { 99 }
    var countInRow: (_ verticalSize: UIUserInterfaceSizeClass, _ horizontalSize: UIUserInterfaceSizeClass) -> Int {
        {(verticalSize: UIUserInterfaceSizeClass, horizontalSize: UIUserInterfaceSizeClass) -> Int in
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
    }
    var titleText: Bool { false }
    var cancelButtonText: String { "Cancel" }
    var confirmButtonText: String { "Confirm" }
    
    var tintColor: UIColor? { nil }
    var tintTextColor: UIColor? { nil }
    var backgroundColor: UIColor { .white }
    
    var pickedColor: UIColor { .blue_007AFF }
    var pickedMarkLocation: selectLocation { .rightBottom }
    var isPickedWithCount: Bool { true }
    var isPickWithBorder: Bool { true }
}

// MARK: - TA
final class TASetting: SYGalleryPickerSettings {

    var pickLimitCount: Int = 20
    var titleText: Bool = true
    var cancelButtonText: String = "取消"
    var confirmButtonText: String = "確認"
    
    var tintColor: UIColor? = .green_8BC34A
    var tintTextColor: UIColor? = .white
    
    var pickedColor: UIColor = .green_8BC34A
    var pickedMarkLocation: selectLocation = .rightTop
}

// MARK: - IM
final class IMSetting: SYGalleryPickerSettings {

    var pickLimitCount: Int = 10
    var cancelButtonText: String = "取消"
    var confirmButtonText: String = "傳送"
    var pickedColor: UIColor = .green_008800
    var isPickedWithCount: Bool = false
    var isPickWithBorder: Bool = false
}

// MARK: - Basic
final class defaultSetting: SYGalleryPickerSettings {
}
