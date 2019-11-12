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
    func sy_presentGalleryPickerController
        (_ imagePicker: SYGalleryPickerViewController, setting: SinyiProject = .basic,  requestOptions: PHImageRequestOptions? = nil, animated: Bool,
         select: ((_ asset: PHAsset) -> Void)?,
         deselect: ((_ asset: PHAsset) -> Void)?,
         cancel: (([PHAsset]) -> Void)?,
         finish: (([PHAsset]) -> Void)?,
         completion: (() -> Void)?,
         selectLimitReached: ((Int) -> Void)? = nil) {
        
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
            
            imagePicker.photosViewController.selectionClosure = select
            imagePicker.photosViewController.deselectionClosure = deselect
            imagePicker.photosViewController.cancelClosure = cancel
            imagePicker.photosViewController.finishClosure = finish
            imagePicker.photosViewController.selectLimitReachedClosure = selectLimitReached
            
            self.present(imagePicker, animated: animated, completion: completion)
        }
    }
}
