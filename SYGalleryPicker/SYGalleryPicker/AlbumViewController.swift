//
//  AlbumViewController.swift
//  SYGalleryPicker
//
//  Created by IrvingHuang on 2019/11/4.
//  Copyright © 2019 Sinyi Realty Inc. All rights reserved.
//

import UIKit
import Photos

//protocol SYGalleryPickerViewControllerDelegate: NSObjectProtocol {
//    func albumDidSelected(_ viewController: SYGalleryPickerViewController,  photos: [AlbumPhoto])
//    func albumDidSelectedOver(_ viewController: SYGalleryPickerViewController, to count: Int)
//}

open class SYGalleryPickerViewController: UINavigationController {
    
    open var setting: SYGalleryPickerSettings = defaultSetting()
    
    open var doneButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)

    open var cancelButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
    
    open lazy var fetchResults: [PHFetchResult] = { () -> [PHFetchResult<PHAssetCollection>] in
        let fetchOptions = PHFetchOptions()

        // Albums fetch result
        let albumResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        
        return [albumResult]
    }()
    
    lazy var photosViewController: PhotosViewController = {
//        var selections: [PHAsset] = []
//        defaultSelections?.enumerateObjects({ (asset, idx, stop) in
//            selections.append(asset)
//        })
//
//        let assetStore = AssetStore(assets: selections)
        let vc = PhotosViewController(settings: setting)
        
        vc.doneBarButton = self.doneButton
        vc.cancelBarButton = self.cancelButton
//        vc.albumTitleView = self.albumTitleView
        
        return vc
    }()
    
    class func authorize(_ status: PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus(), fromViewController: UIViewController, completion: @escaping (_ authorized: Bool) -> Void) {
        switch status {
        case .authorized:
            completion(true)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) -> Void in
                DispatchQueue.main.async {
                    self.authorize(status, fromViewController: fromViewController, completion: completion)
                }
            }
        default: ()
            DispatchQueue.main.async {
                completion(false)
            }
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
        
        // TODO: Settings
        view.backgroundColor = UIColor.white
        
        // Make sure we really are authorized
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            setViewControllers([photosViewController], animated: false)
        }
    }
    

}
