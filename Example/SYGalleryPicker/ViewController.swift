//
//  ViewController.swift
//  SYGalleryPicker
//
//  Created by jj2564 on 11/22/2019.
//  Copyright (c) 2019 jj2564. All rights reserved.
//

import UIKit
import Photos
import SYGalleryPicker

class ViewController: UIViewController {

    var photos:[PHAsset] = []

    @IBAction func taModeClicked(_ sender: Any) {
        
        let cusSetting = TASetting()
        
        let vc = SYGalleryPickerViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.titleText = "環境照片"
        vc.syPresentGalleryPickerController(self, customSetting: cusSetting ,animated: true,
        select: { asset in
            print("select")
        }, deselect: { asset in
            print("deselect")
        }, cancel: { assets in
            print("Cancel")
        }, finish: { assets in
            print("Confirm")
            self.photos = assets
        }, photoSelectLimitReached: { count in
            print("Limit reach")
        }, authorizedDenied: nil, completion: nil)
    }
    
    @IBAction func imModeClicked(_ sender: Any) {
        let vc = SYGalleryPickerViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.defaultSelections = photos
        vc.syPresentGalleryPickerController(self, style: .im ,animated: true,
        select: { asset in
            print(asset.description)
        }, deselect: { asset in
            print(asset.description)
        }, cancel: { assets in
            print("Cancel")
        }, finish: { assets in
            print("Confirm")
        }, photoSelectLimitReached: { count in
            print("Limit reach")
        }, authorizedDenied: nil, completion: nil)
        
    }
    
    @IBAction func basicClicked(_ sender: Any) {
        
        let vc = SYGalleryPickerViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.syPresentGalleryPickerController(self, animated: true,
        select: { asset in
            print(asset.description)
        }, deselect: { asset in
            print(asset.description)
        }, cancel: { assets in
            print("Cancel")
        }, finish: { assets in
            print("Confirm")
        }, photoSelectLimitReached: { count in
            print("Limit reach")
        }, authorizedDenied: nil, completion: nil)
    }
}

