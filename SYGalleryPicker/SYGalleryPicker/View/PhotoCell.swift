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
    let selectView: UILabel = UILabel(frame: .zero)

    weak var asset: PHAsset?
    
    var settings: SYGalleryPickerSettings = defaultSetting() {
        didSet {
            setSelectViewConstrant()
        }
    }
    
    var selectText: String {
        get {
            if settings.selectWithCount {
                return selectString
            } else {
                return selectSymbol
            }
        }
    }
    
    var selectSymbol: String = "✓"
    var selectString: String = "0" {
        didSet {
            
        }
    }
    
    /// 是否點選到
    var isCheck: Bool = false {
        didSet {
            if self.isCheck {
                selectView.isHidden = false
                opacityView.alpha = 0.3
            } else {
                selectView.isHidden = true
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
        
        let size:CGFloat = 20
        selectView.translatesAutoresizingMaskIntoConstraints = false
        selectView.layer.cornerRadius = size * 0.5
        selectView.layer.borderWidth = 1
        selectView.layer.borderColor = UIColor.white.cgColor
        selectView.layer.backgroundColor = UIColor.green_008800.cgColor
        selectView.text = selectText
        selectView.textColor = .white
        selectView.textAlignment = .center
        selectView.isHidden = true
        contentView.addSubview(selectView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            opacityView.topAnchor.constraint(equalTo: contentView.topAnchor),
            opacityView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            opacityView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            opacityView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            selectView.heightAnchor.constraint(equalToConstant: size),
            selectView.widthAnchor.constraint(equalToConstant: size),
            
        ])
    }
    
    private func setSelectViewConstrant() {
        var selectMarginLimit1: NSLayoutConstraint
        var selectMarginLimit2: NSLayoutConstraint
        
        let distance: CGFloat = 8
        
        switch settings.selectMarkLocation {
        case .leftTop:
            selectMarginLimit1 = selectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: distance)
            selectMarginLimit2 = selectView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: distance)
        case .rightTop:
            selectMarginLimit1 = selectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -distance)
            selectMarginLimit2 = selectView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: distance)
        case .leftBottom:
            selectMarginLimit1 = selectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: distance)
            selectMarginLimit2 = selectView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -distance)
        case .rightBottom:
            selectMarginLimit1 = selectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -distance)
            selectMarginLimit2 = selectView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -distance)
        }
        
        NSLayoutConstraint.activate([
            selectMarginLimit1,
            selectMarginLimit2
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
