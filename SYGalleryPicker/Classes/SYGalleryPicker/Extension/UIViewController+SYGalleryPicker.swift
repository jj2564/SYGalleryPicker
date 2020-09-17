//
//  UIViewController+SYGalleryPicker.swift
//  SYGalleryPicker
//
//  Created by IrvingHuang on 2019/11/5.
//  Copyright © 2019 Sinyi Realty Inc. All rights reserved.
//

import UIKit
import Photos

var photoStatus: PHAuthorizationStatus {
    var status: PHAuthorizationStatus
    if #available(iOS 14, *) {
        let accessLevel: PHAccessLevel = .addOnly
        status = PHPhotoLibrary.authorizationStatus(for: accessLevel)
    } else {
        status = PHPhotoLibrary.authorizationStatus()
    }
    return status
}

public extension SYGalleryPickerViewController {

    /// syPresentGalleryPickerController
    /// - Parameters:
    ///   - viewController: You need to send current viewcontroller when you call this function.
    ///   - style: Select .ta or .im or .basic(default) if you need.
    ///   - customSetting: Need to confirm protocol `SYGalleryPickerSettings` for customize settings.
    ///   - requestOptions: Can pass the `PHImageRequestOptions` as you wish.
    ///   - animated: anitmated when present
    ///   - select: clourse when you `select` 1 photo.
    ///   - deselect: clourse when you `deselect` 1 photo.
    ///   - cancel: clourse when you  press `cancel button`
    ///   - finish: clourse when you  press `done button`
    ///   - photoSelectLimitReached: clourse when your selected photo reach the **pickLimitCount**
    ///   - authorizedDenied: clourse when last time user deny the auth.
    ///   - authorizedLimited: clourse when last time user select part of photos.
    ///   - completion: comletion handler
    func syPresentGalleryPickerController
        (_ viewController: UIViewController, style: SelectStyle = .basic, customSetting:SYGalleryPickerSettings? = nil , requestOptions: PHImageRequestOptions? = nil, animated: Bool,
         select: ((_ asset: PHAsset) -> Void)?,
         deselect: ((_ asset: PHAsset) -> Void)?,
         cancel: (([PHAsset]) -> Void)?,
         finish: (([PHAsset]) -> Void)?,
         photoSelectLimitReached: ((Int) -> Void)?,
         authorizedDenied:(() -> Void)?,
         authorizedLimited:(() -> Void)? = nil,
         completion: (() -> Void)? ) {
        
        SYGalleryPickerViewController.authorize() { authorized in
            
            if #available(iOS 14, *) {
                if authorized == .limited {
                    authorizedLimited?()
                } else if authorized != .authorized {
                    authorizedDenied?()
                    return
                }
            } else {
                if authorized != .authorized {
                    authorizedDenied?()
                    return
                }
            }
            
            if let customSetting = customSetting {
                self.setting = customSetting
            } else {
                switch style {
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
            self.photosViewController.style = style
            
            viewController.present(self, animated: animated, completion: completion)
        }
    }
}
