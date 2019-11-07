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

    /// 相簿資料夾
    private var albumFolders: [AlbumFolder] = []
    /// 照片(PHAsset)
    private var albumPhotos: [AlbumPhoto] = []
    /// 紀錄已點選的照片
    private var markPhotos: [AlbumPhoto] = []

    // MARK: Button actions
    @objc func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
//        cancelClosure?(assetStore.assets)
    }
    
    @objc func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
//        finishClosure?(assetStore.assets)
    }
    
    required init(fetchResults: [PHFetchResult<PHAssetCollection>],settings currentSettings: SYGalleryPickerSettings) {
        
        settings = currentSettings
        
        let flowLayout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: flowLayout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("b0rk: initWithCoder not implemented")
    }

    override func loadView() {
        super.loadView()
        
        collectionView?.backgroundColor = settings.backgroundColor
        collectionView?.allowsMultipleSelection = true
        
        cancelBarButton? = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(PhotosViewController.cancelButtonPressed(_:)))
        doneBarButton? = UIBarButtonItem(title: "確認", style: .plain, target: self, action: #selector(PhotosViewController.doneButtonPressed(_:)))
        
        navigationItem.leftBarButtonItem = cancelBarButton
        navigationItem.rightBarButtonItem = doneBarButton
        
        updateCollectionLayout()
    }

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
        
        collectionView.setCollectionViewLayout(flowLayout, animated: true);
        collectionView.layoutIfNeeded()
    }
}


// MARK: UIImagePickerControllerDelegate
extension PhotosViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath)
    
        // Configure the cell
    
        return cell
    }
}
