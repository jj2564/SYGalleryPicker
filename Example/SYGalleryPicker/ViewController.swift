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

    @IBAction func TA(_ sender: Any) {
        let vc = SYGalleryPickerViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.titleText = "環境照片"
        sy_presentGalleryPickerController(vc, setting: .TA ,animated: true,
        select: { asset in
            print("select")
        }, deselect: { asset in
            print("deselect")
        }, cancel: { assets in
            print("Cancel")
        }, finish: { assets in
            print("Confirm")
            self.photos = assets
        }, selectLimitReached: { count in
            print("Limit reach")
        }, completion: nil)
    }
    
    @IBAction func IM(_ sender: Any) {
        let vc = SYGalleryPickerViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.defaultSelections = photos
        sy_presentGalleryPickerController(vc, setting: .IM ,animated: true,
        select: { asset in
            print(asset.description)
        }, deselect: { asset in
            print(asset.description)
        }, cancel: { assets in
            print("Cancel")
        }, finish: { assets in
            print("Confirm")
        }, selectLimitReached: { count in
            print("Limit reach")
        }, completion: nil)
        
    }
    
    @IBAction func `default`(_ sender: Any) {
        let vc = SYGalleryPickerViewController()
        vc.modalPresentationStyle = .fullScreen

        sy_presentGalleryPickerController(vc, animated: true,
        select: { asset in
            print(asset.description)
        }, deselect: { asset in
            print(asset.description)
        }, cancel: { assets in
            print("Cancel")
        }, finish: { assets in
            print("Confirm")
        }, selectLimitReached: { count in
            print("Limit reach")
        }, completion: nil)
    }
}

