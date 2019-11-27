//
//  UIViewController+SYGalleryPicker.swift
//  SYGalleryPicker
//
//  Created by IrvingHuang on 2019/11/5.
//  Copyright © 2019 Sinyi Realty Inc. All rights reserved.
//

import UIKit
import Photos

public extension SYGalleryPickerViewController {
    
    enum SelectStyle {
        case ta //TopAgent
        case im //
        case basic
    }
    
    
    func syPresentGalleryPickerController
        (_ viewController: UIViewController, setting: SelectStyle = .basic, customSetting:SYGalleryPickerSettings? = nil , requestOptions: PHImageRequestOptions? = nil, animated: Bool,
         select: ((_ asset: PHAsset) -> Void)?,
         deselect: ((_ asset: PHAsset) -> Void)?,
         cancel: (([PHAsset]) -> Void)?,
         finish: (([PHAsset]) -> Void)?,
         photoSelectLimitReached: ((Int) -> Void)?,
         authorizedDenied:(() -> Void)?,
         completion: (() -> Void)? ) {
        
        SYGalleryPickerViewController.authorize() { (authorized) in
            guard authorized == true else {
                authorizedDenied?()
                return
            }
            
            if let customSetting = customSetting {
                self.setting = customSetting
            } else {
                switch setting {
                case .basic:
                    self.setting = defaultSetting()
                case .im:
                    self.setting = IMSetting()
                case .ta:
                    self.setting = TASetting()
                }
            }
            
            self.photosViewController.selectionClosure = select
            self.photosViewController.deselectionClosure = deselect
            self.photosViewController.cancelClosure = cancel
            self.photosViewController.finishClosure = finish
            self.photosViewController.selectLimitReachedClosure = photoSelectLimitReached
            
            viewController.present(self, animated: animated, completion: completion)
        }
    }
}
