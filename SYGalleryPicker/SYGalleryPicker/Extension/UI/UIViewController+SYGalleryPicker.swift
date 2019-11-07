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
    @objc func sy_presentGalleryPickerController(_ imagePicker: SYGalleryPickerViewController, animated: Bool, completion: (() -> Void)?) {
        
        SYGalleryPickerViewController.authorize(fromViewController: self) { (authorized) in
            guard authorized == true else { return }
            
//            imagePicker.modalPresentationStyle = .fullScreen
            
            self.present(imagePicker, animated: animated, completion: completion)
        }
    }
}
