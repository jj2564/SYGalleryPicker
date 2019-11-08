//
//  PhotosViewController.swift
//  SYGalleryPicker
//
//  Created by IrvingHuang on 2019/11/6.
//  Copyright © 2019 Sinyi Realty Inc. All rights reserved.
//

import UIKit
import Photos

class PhotosViewController: UICollectionViewController {
    
    let settings: SYGalleryPickerSettings
    
    var doneBarButton: UIBarButtonItem?
    var cancelBarButton: UIBarButtonItem?
//    var albumTitleView: UIButton?
    
    /// 所有fetchResult
    private var fetchResults:[PHFetchResult<PHAssetCollection>]
    /// 要顯示的照片
    private var photos:PHFetchResult<PHAsset> = PHFetchResult<PHAsset>()
    /// 已選取的照片
    private var selectedPhotos:[PHAsset] = []
    
    
    private(set) var photoThumbnailSize: CGSize = .zero
    
    private let imageRequestOptions: PHImageRequestOptions
    private let imageManager = PHCachingImageManager()
    private let imageContentMode: PHImageContentMode = .aspectFill

    // MARK: Button actions
    @objc func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
//        cancelClosure?(assetStore.assets)
    }
    
    @objc func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
//        finishClosure?(assetStore.assets)
    }
    
    // MARK: - init cycle
    required init(fetchResults: [PHFetchResult<PHAssetCollection>],settings currentSettings: SYGalleryPickerSettings) {
        
        settings = currentSettings
        self.fetchResults = fetchResults
        imageRequestOptions = PHImageRequestOptions()
        imageRequestOptions.deliveryMode = .highQualityFormat
        imageRequestOptions.resizeMode = .exact
        imageRequestOptions.isNetworkAccessAllowed = false
        
        let flowLayout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: flowLayout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("initWithCoder not implemented")
    }

    override func loadView() {
        super.loadView()
        
        collectionView?.backgroundColor = settings.backgroundColor
        collectionView?.allowsMultipleSelection = true
        
        collectionView?.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.cellIdentifier)
        
        cancelBarButton? = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(PhotosViewController.cancelButtonPressed(_:)))
        doneBarButton? = UIBarButtonItem(title: "確認", style: .plain, target: self, action: #selector(PhotosViewController.doneButtonPressed(_:)))
        
        navigationItem.leftBarButtonItem = cancelBarButton
        navigationItem.rightBarButtonItem = doneBarButton
        
        updateCollectionLayout()

        if let album = fetchResults.first?.firstObject {
            initWithCameraRoll(album)
            collectionView.reloadData()
        }

    }

    private func initWithCameraRoll(_ roll: PHAssetCollection) {
        let options = PHFetchOptions()
        options.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let assets = PHAsset.fetchAssets(in: roll, options: options)
        
        photos = assets
    }
    
    // MARK: 調整螢幕比例
    private func updateCollectionLayout() {
        
        let flowLayout = UICollectionViewFlowLayout()
        let spacing = CGFloat(1.5)
        let span = settings.countInRow(traitCollection.verticalSizeClass, traitCollection.horizontalSizeClass)
        let total = CGFloat(span - 1) * spacing
        let width = (UIScreen.main.bounds.width - total) / CGFloat(span)
        let height = width
        let itemSize = CGSize(width: width, height: height)
        flowLayout.minimumInteritemSpacing = spacing
        flowLayout.minimumLineSpacing = spacing
        flowLayout.itemSize = itemSize
        
        let scale: CGFloat = (UIScreen.main.scale)*width
        photoThumbnailSize = CGSize(width: scale, height: scale)
        
        collectionView.setCollectionViewLayout(flowLayout, animated: true);
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if collectionViewLayout is UICollectionViewFlowLayout {
            updateCollectionLayout()
        }
    }
}


// MARK: - UIImagePickerControllerDelegate
extension PhotosViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.cellIdentifier, for: indexPath) as! PhotoCell
        photoCell.accessibilityIdentifier = "photo_cell_\(indexPath.item)"
    
        if photoCell.tag != 0 {
            imageManager.cancelImageRequest(PHImageRequestID(Int32(photoCell.tag)))
        }
        
        let asset = photos[indexPath.row]
        // Request image
        photoCell.tag = Int(imageManager.requestImage(for: asset, targetSize: photoThumbnailSize, contentMode: imageContentMode, options: imageRequestOptions) { (result, _) in
            
            guard let result = result else { return }
            photoCell.asset = asset
            photoCell.imageView.image = result
            photoCell.settings = self.settings
        })
    
        return photoCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell else { return false }
//        let asset = cell.asset
        cell.isCheck = !cell.isCheck
        
        return false
    }
}
