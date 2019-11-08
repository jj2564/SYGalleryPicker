//
//  UIViewController+SYGalleryPicker.swift
//  SYGalleryPicker
//
//  Created by IrvingHuang on 2019/11/5.
//  Copyright © 2019 Sinyi Realty Inc. All rights reserved.
//

import UIKit
import Photos

public extension UIViewController {
    func sy_presentGalleryPickerController(_ imagePicker: SYGalleryPickerViewController, setting: SinyiProject = .basic, animated: Bool, completion: (() -> Void)?) {
        
        SYGalleryPickerViewController.authorize(fromViewController: self) { (authorized) in
            guard authorized == true else { return }

            switch setting {
            case .basic:
                imagePicker.setting = defaultSetting()
            case .IM:
                imagePicker.setting = IMSetting()
            case .TA:
                imagePicker.setting = TASetting()
            }
            
            self.present(imagePicker, animated: animated, completion: completion)
        }
    }
}
