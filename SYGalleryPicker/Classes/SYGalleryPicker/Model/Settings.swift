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
    /// status bar style
    var statusBarStyle: UIStatusBarStyle { get }
    /// select limit count in picker
    var pickLimitCount: Int { get }
    /// count per row in picker
    var countInRow: (_ verticalSize: UIUserInterfaceSizeClass, _ horizontalSize: UIUserInterfaceSizeClass) -> Int { get }
    /// use a title text instead of album select
    var titleText: Bool { get }
    /// text with cancel button
    var cancelButtonText: String { get }
    /// text with confirm button
    var confirmButtonText: String { get }
    
    // MARK: Picker Style
    /// color of navigation bar
    var tintColor: UIColor? { get }
    /// color of navigation title
    var tintTextColor: UIColor? { get }
    /// background color of picker
    var backgroundColor: UIColor { get }
    
    // MARK: Selected style
    /// select mark and select border color
    var pickedColor: UIColor { get }
    /// select mark location of the cell
    var pickedMarkLocation: selectLocation { get }
    /// use count on select view
    var isPickedWithCount: Bool { get }
    /// show select border ot not
    var isPickWithBorder: Bool { get }
    
}

public extension SYGalleryPickerSettings {
    
    var statusBarStyle: UIStatusBarStyle { .default }
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
open class TASetting: SYGalleryPickerSettings {

    public var statusBarStyle: UIStatusBarStyle = .lightContent
    public var pickLimitCount: Int = 20
    public var titleText: Bool = true
    public var cancelButtonText: String = "取消"
    public var confirmButtonText: String = "確認"

    public var tintColor: UIColor? = .green_8BC34A
    public var tintTextColor: UIColor? = .white

    public var pickedColor: UIColor = .green_8BC34A
    public var pickedMarkLocation: selectLocation = .rightTop
    
    public init() {}
}

// MARK: - IM
final class IMSetting: SYGalleryPickerSettings {

    var pickLimitCount: Int = 10
    var cancelButtonText: String = "取消"
    var confirmButtonText: String = "傳送"
    var tintTextColor: UIColor? = .gray_464646
    var pickedColor: UIColor = .green_008800
    var isPickedWithCount: Bool = false
    var isPickWithBorder: Bool = false
}

// MARK: - Basic
final class defaultSetting: SYGalleryPickerSettings {
}
