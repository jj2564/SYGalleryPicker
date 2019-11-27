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
    var maxPickNumber: Int { get }
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
    var pickColor: UIColor { get }
    /// 選取的標示所屬的位置
    var selectMarkLocation: selectLocation { get }
    /// 選取顯示數字還是打勾
    var selectWithCount: Bool { get }
    /// 是否顯示選取外框
    var pickWithBorder: Bool { get }
}

extension SYGalleryPickerSettings {
    
    var maxPickNumber: Int { 99 }
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
    
    var pickColor: UIColor { .blue_00008B }
    var selectMarkLocation: selectLocation { .rightBottom }
    var selectWithCount: Bool { true }
    var pickWithBorder: Bool { false }
}

// MARK: - TA
final class TASetting: SYGalleryPickerSettings {

    var maxPickNumber: Int = 20
    var titleText: Bool = true
    var cancelButtonText: String = "取消"
    var confirmButtonText: String = "確認"
    
    var tintColor: UIColor? = .green_8BC34A
    var tintTextColor: UIColor? = .white
    
    var pickColor: UIColor = .green_8BC34A
    var selectMarkLocation: selectLocation = .rightTop
    var pickWithBorder: Bool = true
}

// MARK: - IM
final class IMSetting: SYGalleryPickerSettings {

    var maxPickNumber: Int = 10
    var cancelButtonText: String = "取消"
    var confirmButtonText: String = "確認"
    var pickColor: UIColor = .green_008800
    var selectWithCount: Bool = false
}

// MARK: - default
final class defaultSetting: SYGalleryPickerSettings {
}
