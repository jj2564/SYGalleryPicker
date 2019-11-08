//
//  PhotoCell.swift
//  SYGalleryPicker
//
//  Created by IrvingHuang on 2019/11/6.
//  Copyright © 2019 Sinyi Realty Inc. All rights reserved.
//

import UIKit
import Photos

class PhotoCell: UICollectionViewCell {
    static let cellIdentifier = "photoCellIdentifier"
    
    let opacityView: UIView = UIView(frame: .zero)
    let imageView: UIImageView = UIImageView(frame: .zero)

    weak var asset: PHAsset?
    var settings: SYGalleryPickerSettings = defaultSetting()
    
    /// 是否點選到
    var isCheck: Bool = false {
        didSet {
            if self.isCheck {
                opacityView.alpha = 0.3
            } else {
                opacityView.alpha = 0
            }
        }
    }
    
    var pickColor: UIColor {
        get {
            return settings.pickColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        opacityView.translatesAutoresizingMaskIntoConstraints = false
        opacityView.backgroundColor = .black
        opacityView.alpha = 0
        contentView.addSubview(opacityView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            opacityView.topAnchor.constraint(equalTo: contentView.topAnchor),
            opacityView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            opacityView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            opacityView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
}
