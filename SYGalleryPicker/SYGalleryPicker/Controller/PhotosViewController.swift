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
    lazy var albumTitleView: UIButton = {
        let btn = UIButton(type: .custom)

        if let titleText = self.titleText {
            btn.titleLabel?.font = .boldSystemFont(ofSize: 17)
            btn.setTitle(titleText, for: .normal)
        } else {
            btn.titleLabel?.font = .systemFont(ofSize: 15.0)
        }
        
        return btn
    }()
    
    var titleText: String?
    private var doneBarButtonTitle: String = "確認"
    private var cancelBarButtonTitle: String = "取消"
    
    lazy var albumViewController: AlbumTableViewController = {
        let vc = AlbumTableViewController()
        vc.tableView.dataSource = self
        vc.tableView.delegate = self
        
        return vc
    }()
    
    private var imageCache: NSCache<AnyObject, UIImage>
    /// 所有fetchResult
    private var fetchResults:[PHFetchResult<PHAssetCollection>]
    /// 要顯示的照片
    private var photos:PHFetchResult<PHAsset> = PHFetchResult<PHAsset>()
    /// 已選取的照片
    var selectedPhotos:[PHAsset] = []
    
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
        
        imageCache = NSCache()
        settings = currentSettings
        self.fetchResults = fetchResults
        
        let flowLayout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: flowLayout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("initWithCoder not implemented")
    }
    
    deinit {
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            imageManager.stopCachingImagesForAllAssets()
        }
        imageCache.removeAllObjects()
    }

    override func loadView() {
        
        super.loadView()
        
        collectionView?.backgroundColor = settings.backgroundColor
        collectionView?.allowsMultipleSelection = true
        collectionView?.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.cellIdentifier)
        
        cancelBarButtonTitle = settings.cancelButtonText
        doneBarButtonTitle = settings.confirmButtonText
        
        cancelBarButton? = UIBarButtonItem(title: cancelBarButtonTitle, style: .plain, target: self, action: #selector(cancelButtonPressed(_:)))
        
        doneBarButton? = UIBarButtonItem(title: doneBarButtonTitle, style: .plain, target: self, action: #selector(doneButtonPressed(_:)))
        
        if let _ = titleText {} else {
            albumTitleView.addTarget(self, action: #selector(albumButtonPressed(_:)), for: .touchUpInside)
        }
        
        navigationItem.leftBarButtonItem = cancelBarButton
        navigationItem.rightBarButtonItem = doneBarButton
        navigationItem.titleView = albumTitleView
        
        if let tintTextColor = settings.tintTextColor {
            cancelBarButton?.tintColor = tintTextColor
            doneBarButton?.tintColor = tintTextColor
            albumTitleView.setTitleColor(tintTextColor, for: .normal)
        } else {
            albumTitleView.setTitleColor(albumTitleView.tintColor, for: .normal)
        }
        
        updateCollectionLayout()
        updateDoneButton()

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
    
    // MARK: Update Method
    func updateDoneButton() {
        let count  = selectedPhotos.count
        if count > 0 {
            doneBarButton?.title = "\(doneBarButtonTitle)(\(count))"
        } else {
            doneBarButton?.title = "\(doneBarButtonTitle)"
        }
        
        doneBarButton?.isEnabled = count > 0
    }
    
    private func updateTitle(_ album: PHAssetCollection) {

        if let _ = titleText { return }
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
        UIView.setAnimationsEnabled(false)
        
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.cellIdentifier, for: indexPath) as! PhotoCell
        photoCell.accessibilityIdentifier = "photo_cell_\(indexPath.item)"
//        photoCell.isAccessibilityElement = true
        
        let asset = photos[indexPath.row]
        
        if photoCell.tag != 0 {
            imageManager.cancelImageRequest(PHImageRequestID(Int32(photoCell.tag)))
        }
        
        if let c_image = imageCache.object(forKey: asset) {
            photoCell.imageView.image = c_image
        } else {
            photoCell.tag = Int(imageManager.requestImage(for: asset, targetSize: photoThumbnailSize, contentMode: imageContentMode, options: imageRequestOptions) { [weak self] (image, _) in
                
                guard let self = self else { return }
                guard let image = image else { return }
                
                self.imageCache.setObject(image, forKey: asset)
                photoCell.imageView.image = image
            })
        }
        
        photoCell.settings = self.settings
        
        if self.selectedPhotos.contains(asset) {
            if let index = self.selectedPhotos.firstIndex(of: asset) {
                photoCell.selectString = "\(index+1)"
            }
            photoCell.isCheck = true
        } else {
            photoCell.isCheck = false
        }
        
//        photoCell.isAccessibilityElement = true
//        photoCell.accessibilityTraits = UIAccessibilityTraits.button
        UIView.setAnimationsEnabled(true)
        
        return photoCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {

        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell else { return false }
//        guard let asset = cell.asset else { return false }
        let asset = photos[indexPath.row]
        
        if cell.isCheck {
            guard let index = selectedPhotos.firstIndex(of: asset) else {
                return false
            }
            selectedPhotos.remove(at: index)
            deselectionClosure?(asset)
            let selectedIndexPaths = selectedPhotos.enumerated().compactMap({ (photoIndex,imageAsset) -> IndexPath? in
                //數字比較大的不用reload
                if index > photoIndex { return nil }
                let sectionIndex = photos.index(of: imageAsset)
                guard sectionIndex != NSNotFound else { return nil }
                return IndexPath(item: sectionIndex, section: 0)
            })
                        
            UIView.performWithoutAnimation {
                collectionView.reloadItems(at: selectedIndexPaths)
            }
            
            
        } else if selectedPhotos.count >= settings.maxPickNumber {
            selectLimitReachedClosure?(selectedPhotos.count)
            return false
        } else {
            selectedPhotos.append(asset)
            selectionClosure?(asset)
            cell.selectString = "\(selectedPhotos.count)"
        }
        cell.isCheck = !cell.isCheck
        updateDoneButton()
        
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
        
        cell.tag = Int( imageManager.requestImage(for: firstAsset, targetSize: imageSize, contentMode: imageContentMode, options: self.imageRequestOptions) { (image, _ ) in
            if let image = image {
                cell.albumImageView.image = image
            }
        })
        
        cell.albumCountLabel.text = "\(result.count)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = fetchResults[indexPath.section][indexPath.row]
        initWithAlbum(album)
        collectionView.reloadData()
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
