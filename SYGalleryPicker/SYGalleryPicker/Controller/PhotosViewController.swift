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
    var selectionClosure: ((_ asset: PHAsset) -> Void)?
    var deselectionClosure: ((_ asset: PHAsset) -> Void)?
    var cancelClosure: ((_ assets: [PHAsset]) -> Void)?
    var finishClosure: ((_ assets: [PHAsset]) -> Void)?
    var selectLimitReachedClosure: ((_ selectionLimit: Int) -> Void)?
    
    let settings: SYGalleryPickerSettings
    
    var doneBarButton: UIBarButtonItem?
    var cancelBarButton: UIBarButtonItem?
    
    var albumTitleView: UIButton = {
        let btn = UIButton(type: .custom)
        
        btn.setTitleColor(btn.tintColor, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15.0)
        
        return btn
    }()
    
    lazy var albumViewController: AlbumTableViewController = {
        let vc = AlbumTableViewController()
        vc.tableView.dataSource = self
        vc.tableView.delegate = self
        
        return vc
    }()
    
    /// 所有fetchResult
    private var fetchResults:[PHFetchResult<PHAssetCollection>]
    /// 要顯示的照片
    private var photos:PHFetchResult<PHAsset> = PHFetchResult<PHAsset>()
    /// 已選取的照片
    private var selectedPhotos:[PHAsset] = []
    
    private(set) var photoThumbnailSize: CGSize = .zero
    
    var imageRequestOptions: PHImageRequestOptions?
    private let imageManager = PHCachingImageManager()
    private let imageContentMode: PHImageContentMode = .aspectFill

    // MARK: Button actions
    @objc func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        cancelClosure?(selectedPhotos)
    }
    
    @objc func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        finishClosure?(selectedPhotos)
    }
    
    @objc func albumButtonPressed(_ sender: UIButton) {
        guard let popVC = albumViewController.popoverPresentationController else {
            return
        }

        popVC.permittedArrowDirections = .up
        popVC.sourceView = sender
        let senderRect = sender.convert(sender.frame, from: sender.superview)
        let sourceRect = CGRect(x: senderRect.origin.x, y: senderRect.origin.y + (sender.frame.size.height / 2), width: senderRect.size.width, height: senderRect.size.height)
        popVC.sourceRect = sourceRect
        popVC.delegate = self
        present(albumViewController, animated: true, completion: nil)
    }
    
    // MARK: - init cycle
    required init(fetchResults: [PHFetchResult<PHAssetCollection>],settings currentSettings: SYGalleryPickerSettings) {
        
        settings = currentSettings
        self.fetchResults = fetchResults
        
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
        
        cancelBarButton? = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(cancelButtonPressed(_:)))
        doneBarButton? = UIBarButtonItem(title: "確認", style: .plain, target: self, action: #selector(doneButtonPressed(_:)))
        albumTitleView.addTarget(self, action: #selector(albumButtonPressed(_:)), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = cancelBarButton
        navigationItem.rightBarButtonItem = doneBarButton
        navigationItem.titleView = albumTitleView
        
        updateCollectionLayout()

        if let album = fetchResults.first?.firstObject {
            initWithAlbum(album)
            collectionView.reloadData()
        }
    }

    private func initWithAlbum(_ album: PHAssetCollection) {
        
        let options = PHFetchOptions()
        options.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        updateTitle(album)
        
        let assets = PHAsset.fetchAssets(in: album, options: options)
        photos = assets
    }
    
    private func updateTitle(_ album: PHAssetCollection) {
        
        guard var title = album.localizedTitle else { return }
        
        title += "  ↓"
        
        albumTitleView.setTitle(title, for: .normal)
        albumTitleView.sizeToFit()
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

        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.cellIdentifier, for: indexPath) as! PhotoCell
        photoCell.accessibilityIdentifier = "photo_cell_\(indexPath.item)"
    
        if photoCell.tag != 0 {
            imageManager.cancelImageRequest(PHImageRequestID(Int32(photoCell.tag)))
        }
        
        let asset = photos[indexPath.row]
        photoCell.tag = Int(imageManager.requestImage(for: asset, targetSize: photoThumbnailSize, contentMode: imageContentMode, options: imageRequestOptions) { [weak self] (result, _) in
            
            guard let self = self else { return }
            guard let result = result else { return }
            
            if self.selectedPhotos.contains(asset) {
                photoCell.isCheck = true
            } else {
                photoCell.isCheck = false
            }
            
            photoCell.asset = asset
            photoCell.imageView.image = result
            photoCell.settings = self.settings
        })
        
        return photoCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell else { return false }
        guard let asset = cell.asset else { return false }
        
        if cell.isCheck {
            guard let index = selectedPhotos.firstIndex(of: asset) else { return false }
            selectedPhotos.remove(at: index)
            deselectionClosure?(asset)
        } else if selectedPhotos.count >= settings.maxPickNumber {
            selectLimitReachedClosure?(selectedPhotos.count)
            return false
        } else {
            selectedPhotos.append(asset)
            selectionClosure?(asset)
        }
        cell.isCheck = !cell.isCheck
        
        return false
    }
}

// MARK: UITableViewDelegate
extension PhotosViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResults.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchResults[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumCell.cellIdentifier, for: indexPath) as! AlbumCell
        let cachingManager = PHCachingImageManager.default() as? PHCachingImageManager
        cachingManager?.allowsCachingHighQualityImages = false

        
//        if let albums = fetchResults.first {
             
            let album = fetchResults[indexPath.section][indexPath.row]
            cell.albumTitleLabel.text = album.localizedTitle
            
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [
                NSSortDescriptor(key: "creationDate", ascending: false)
            ]
            fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)

            let scale = UIScreen.main.scale
            let imageSize = CGSize(width: 80 * scale, height: 80 * scale)
            let result = PHAsset.fetchAssets(in: album, options: fetchOptions)
            
            guard let firstAsset = result.firstObject else { return cell }
            
            imageManager.requestImage(for: firstAsset, targetSize: imageSize, contentMode: imageContentMode,
                                      options: self.imageRequestOptions, resultHandler: { (image, info) in
                                        if let image = image {
                                            cell.albumImageView.image = image
                                        }
            })
            
            cell.albumCountLabel.text = "\(result.count)"
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Update photos data source
        
//        if let albums = fetchResults.first {
            let album = fetchResults[indexPath.section][indexPath.row]
            initWithAlbum(album)
            collectionView.reloadData()
//        }
        
        albumViewController.dismiss(animated: true, completion: nil)
    }
}


// MARK: UIPopoverPresentationControllerDelegate
extension PhotosViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
}
