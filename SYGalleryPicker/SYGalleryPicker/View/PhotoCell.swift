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
    let selectBorder: UIView = UIView(frame: .zero)

    weak var asset: PHAsset?
    
    var settings: SYGalleryPickerSettings = defaultSetting() {
        didSet {
            setSelectViewConstrant()
            updateSettings()
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
            updateSelectText()
        }
    }
    
    /// 是否點選到
    var isCheck: Bool = false {
        didSet {
            
            let hasChanged = isCheck != oldValue
            if UIView.areAnimationsEnabled && hasChanged {
                UIView.animate(withDuration: TimeInterval(0.1), animations: { () -> Void in
                    self.updateAlpha(self.isCheck)
                    self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                    }, completion: { (finished: Bool) -> Void in
                        UIView.animate(withDuration: TimeInterval(0.1), animations: { () -> Void in
                            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                            }, completion: nil)
                })
            } else {
                updateAlpha(isCheck)
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
        selectView.font = .systemFont(ofSize: 14)
        updateSelectText()
        selectView.textColor = .white
        selectView.textAlignment = .center
        selectView.isHidden = true
        contentView.addSubview(selectView)
        
        selectBorder.translatesAutoresizingMaskIntoConstraints = false
        selectBorder.backgroundColor = .clear
        selectBorder.isHidden = true
        contentView.addSubview(selectBorder)
        
        updateSettings()
        
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
            selectBorder.topAnchor.constraint(equalTo: contentView.topAnchor),
            selectBorder.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            selectBorder.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            selectBorder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    private func updateSelectText() {
        selectView.text = selectText
    }
    
    private func updateSettings() {
        selectView.layer.backgroundColor = settings.pickColor.cgColor
        
        if settings.pickWithBorder {
            selectBorder.layer.borderWidth = 2
            selectBorder.layer.borderColor = settings.pickColor.cgColor
        }
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
    
    private func updateAlpha(_ selected: Bool) {
        if selected {
            selectBorder.isHidden = false
            selectView.isHidden = false
            opacityView.alpha = 0.3
        } else {
            selectBorder.isHidden = true
            selectView.isHidden = true
            opacityView.alpha = 0
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
}
