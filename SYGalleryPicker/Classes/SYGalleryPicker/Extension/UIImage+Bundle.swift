//
//  UIImage+Bundle.swift
//  SYGalleryPicker
//
//  Created by IrvingHuang on 2019/12/11.
//

import UIKit

extension UIImage {
   convenience init?(podAssetName: String) {
       let podBundle = Bundle(for: PhotosViewController.self)
      
       /// A given class within your Pod framework
       guard let url = podBundle.url(forResource: "SYGalleryPicker",
                                     withExtension: "bundle") else {
           return nil
                                       
       }

       self.init(named: podAssetName,
                 in: Bundle(url: url),
                 compatibleWith: nil)
   }
}
