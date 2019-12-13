//
//  AlbumTableView.swift
//  Pods-SYGalleryPicker_Example
//
//  Created by IrvingHuang on 2019/12/11.
//

import UIKit

class AlbumTableView: UITableView {

    init(frame: CGRect) {
        super.init(frame: frame, style: .plain)
        
        translatesAutoresizingMaskIntoConstraints = false
        /// 模糊背景
        let visualEffectView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: UIBlurEffect(style: .light)))
        visualEffectView.frame = bounds
        visualEffectView.autoresizingMask = [.flexibleWidth , .flexibleHeight]

        backgroundView = visualEffectView
        backgroundColor = .clear
        rowHeight = UITableView.automaticDimension
        separatorStyle = .none

        sectionHeaderHeight = 0.0
        sectionFooterHeight = 0.0
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        register(AlbumCell.self, forCellReuseIdentifier: AlbumCell.cellIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
