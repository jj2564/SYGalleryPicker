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
    
    open var defaultSelections: [PHAsset]?
    
    open var titleText: String?
    
    private lazy var imageRequestOptions: PHImageRequestOptions = {
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .exact
        options.isNetworkAccessAllowed = false
        return options
    }()
    
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
        vc.imageRequestOptions = self.imageRequestOptions
        vc.titleText = titleText
        
        return vc
    }()
    
    class func authorize( completion: @escaping (_ authorized: PHAuthorizationStatus) -> Void) {
        
        let status = photoStatus
        
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) -> Void in
                DispatchQueue.main.async {
                    self.authorize(completion: completion)
                }
            }
        default:
            completion(status)
        }
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return setting.statusBarStyle 
    }
    
    open override func loadView() {
        super.loadView()

        view.backgroundColor = .white
        navigationBar.isTranslucent = false
        
        if let tintColor = setting.tintColor {
            navigationBar.barTintColor = tintColor
        }

        setViewControllers([photosViewController], animated: false)
    }
    
    deinit {
        print("SYGalleryPickerViewController is deinit")
    }
}
