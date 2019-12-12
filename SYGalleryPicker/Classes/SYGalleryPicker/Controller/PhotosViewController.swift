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
    
    var style: SelectStyle?
    let settings: SYGalleryPickerSettings
    
    var selectionClosure: ((_ asset: PHAsset) -> Void)?
    var deselectionClosure: ((_ asset: PHAsset) -> Void)?
    var cancelClosure: ((_ assets: [PHAsset]) -> Void)?
    var finishClosure: ((_ assets: [PHAsset]) -> Void)?
    var selectLimitReachedClosure: ((_ selectionLimit: Int) -> Void)?
    
    var doneBarButton: UIBarButtonItem?
    var cancelBarButton: UIBarButtonItem?
    
    lazy var albumTitleView: UIButton = {
        
        var btn = UIButton(type: .custom)
        
        if let tintColor = settings.tintTextColor {
            btn.tintColor = tintColor
        }
        btn.setTitleColor(btn.tintColor, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 17)
        
        if let titleText = self.titleText {
            btn.setTitle(titleText, for: .normal)
            return btn
        }
        
        if let image = UIImage(podAssetName: "down") {
            let newImage = image.withRenderingMode(.alwaysTemplate)
            
            btn.semanticContentAttribute = .forceRightToLeft
            btn.imageView?.contentMode = .scaleAspectFit
            
            let titleImageGap: CGFloat = 6.0
            btn.titleEdgeInsets = UIEdgeInsets(top: 5.0, left: -titleImageGap, bottom: 5.0, right: titleImageGap)
            btn.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: titleImageGap, bottom: 5.0, right: 10.0)
            btn.setImage(newImage, for: .normal)
        }
        return btn
    }()
    
    var titleText: String?
    private var doneBarButtonTitle: String = "確認"
    
    
    private var isAlbumOpen = false
    private var albumTableView: AlbumTableView = AlbumTableView(frame: .zero)
    var albumOpenConstraint:NSLayoutConstraint = NSLayoutConstraint()
    
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
        cancelClosure?(selectedPhotos)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func doneButtonPressed(_ sender: UIBarButtonItem) {
        finishClosure?(selectedPhotos)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func albumButtonPressed(_ sender: UIButton) {
        isAlbumOpen = !isAlbumOpen
        rotateTitleImage()
        
        let frame = view.frame
        if isAlbumOpen {
            albumOpenConstraint.constant = frame.size.height
        } else {
            albumOpenConstraint.constant = 0
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            // 不知道為什麼有35的偏移
            self.albumTableView.setContentOffset(CGPoint(x: 0, y: 35), animated: false)
        })
    }
    
    private func rotateTitleImage() {
        let angle = isAlbumOpen ? (CGFloat.pi / 1) : 0
        albumTitleView.imageView?.transform = CGAffineTransform.identity.rotated(by: angle)
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
        
//        edgesForExtendedLayout = []
        
        collectionView?.backgroundColor = settings.backgroundColor
        collectionView?.allowsMultipleSelection = true
        collectionView?.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.cellIdentifier)
        
        var cancelImageName = "close"
        if style == .ta {
            cancelImageName = "back"
        }
        if let closeImage = UIImage(podAssetName: cancelImageName) {
            cancelBarButton?.image = closeImage
            //this is for my own special require.
            if style == .ta {
                cancelBarButton?.imageInsets = UIEdgeInsets(top: 4.0, left: -18.0, bottom: -4.0, right: 18.0)
            }
        } else {
            cancelBarButton?.title = "Cancel"
        }
        cancelBarButton?.target = self
        cancelBarButton?.action = #selector(cancelButtonPressed(_:))

        doneBarButtonTitle = settings.confirmButtonText
        doneBarButton?.target = self
        doneBarButton?.action = #selector(doneButtonPressed(_:))
        doneBarButton?.title = doneBarButtonTitle
        
        if let _ = titleText {} else {
            albumTitleView.addTarget(self, action: #selector(albumButtonPressed(_:)), for: .touchUpInside)
        }
        
        navigationItem.leftBarButtonItem = cancelBarButton
        navigationItem.rightBarButtonItem = doneBarButton
        navigationItem.titleView = albumTitleView
        
        if let tintTextColor = settings.tintTextColor {
            cancelBarButton?.tintColor = tintTextColor
            doneBarButton?.tintColor = tintTextColor
        }
        
        updateCollectionLayout()
        updateDoneButton()

        if let album = fetchResults.first?.firstObject {
            initWithAlbum(album)
            collectionView.reloadData()
        }
        
        albumTableView.translatesAutoresizingMaskIntoConstraints = false
        albumTableView.backgroundColor = settings.backgroundColor
        albumTableView.delegate = self
        albumTableView.dataSource = self
        view.addSubview(albumTableView)
        
        let views = ["tableView": albumTableView, "view": view! ]
        var constraints: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[tableView]-(0)-|",options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[tableView(==view)]", options: [], metrics: nil, views: views)
        NSLayoutConstraint.activate(
            constraints
        )
        
        if #available(iOS 11.0, *) {
            albumOpenConstraint = albumTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        } else {
            albumOpenConstraint = albumTableView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        }
        albumOpenConstraint.isActive = true
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
        guard let title = album.localizedTitle else { return }
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
            
            
        } else if selectedPhotos.count >= settings.pickLimitCount {
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
        cell.style = style ?? .basic
//        let cachingManager = PHCachingImageManager.default() as? PHCachingImageManager
//        cachingManager?.allowsCachingHighQualityImages = false

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
        albumButtonPressed(albumTitleView)
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
