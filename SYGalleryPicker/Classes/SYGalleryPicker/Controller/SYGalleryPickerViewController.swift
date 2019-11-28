//
//  SYGalleryPickerViewController.swift
//  SYGalleryPicker
//
//  Created by IrvingHuang on 2019/11/4.
//  Copyright © 2019 Sinyi Realty Inc. All rights reserved.
//

import UIKit
import Photos

open class SYGalleryPickerViewController: UINavigationController {
    
    open var setting: SYGalleryPickerSettings = defaultSetting()
    
    open var doneButton: UIBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)

    open var cancelButton: UIBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    
    open var imageRequestOptions: PHImageRequestOptions?
    
    open var defaultSelections: [PHAsset]?
    
    open var titleText: String?
    
    open lazy var fetchResults: [PHFetchResult] = { () -> [PHFetchResult<PHAssetCollection>] in
        let fetchOptions = PHFetchOptions()

        // Camera roll fetch result
        let cameraRollResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: fetchOptions)
        // Albums fetch result
        let albumResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        
        return [cameraRollResult, albumResult]
    }()
    
    lazy var photosViewController: PhotosViewController = {
        
        let vc = PhotosViewController(fetchResults: self.fetchResults,settings: setting)
        if let selections = defaultSelections {
            vc.selectedPhotos = selections
        }
        vc.doneBarButton = self.doneButton
        vc.cancelBarButton = self.cancelButton
        
        if self.imageRequestOptions == nil {
            imageRequestOptions = PHImageRequestOptions()
            imageRequestOptions?.deliveryMode = .highQualityFormat
            imageRequestOptions?.resizeMode = .exact
            imageRequestOptions?.isNetworkAccessAllowed = false
        }
        
        vc.imageRequestOptions = self.imageRequestOptions
        vc.titleText = titleText
        
        return vc
    }()
    
    class func authorize(_ status: PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus(), completion: @escaping (_ authorized: Bool) -> Void) {
        switch status {
        case .authorized:
            completion(true)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) -> Void in
                DispatchQueue.main.async {
                    self.authorize(status, completion: completion)
                }
            }
        default:
            completion(false)
        }
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func loadView() {
        super.loadView()

        view.backgroundColor = .white
        navigationBar.isTranslucent = true
        
        if let tintColor = setting.tintColor {
            navigationBar.barTintColor = tintColor
        }
        // Make sure we really are authorized
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            setViewControllers([photosViewController], animated: false)
        }
    }
    

}
