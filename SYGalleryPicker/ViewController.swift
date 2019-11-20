//
//  ViewController.swift
//  SYGalleryPicker
//
//  Created by IrvingHuang on 2019/11/5.
//  Copyright © 2019 Sinyi Realty Inc. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {
    
    var photos:[PHAsset] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func TA(_ sender: Any) {
        
        let vc = SYGalleryPickerViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.titleText = "環境照片"
        sy_presentGalleryPickerController(vc, setting: .TA ,animated: true,
        select: { asset in
            print(asset.description)
        }, deselect: { asset in
            print(asset.description)
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

