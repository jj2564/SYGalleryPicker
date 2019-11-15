//
//  AlbumTableViewController.swift
//  SYGalleryPicker
//
//  Created by IrvingHuang on 2019/11/14.
//  Copyright © 2019 Sinyi Realty Inc. All rights reserved.
//

import UIKit

class AlbumTableViewController: UITableViewController {

    init() {
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modalPresentationStyle = .popover
        
        var width:CGFloat = 320
        var height:CGFloat = 300
        if let window = UIApplication.shared.keyWindow {
            width = window.frame.size.width

            if #available(iOS 11.0, *) {
                let topPadding = window.safeAreaInsets.top
                let bottomPadding = window.safeAreaInsets.bottom
                
                height = window.frame.size.height - (bottomPadding + topPadding)
            }
        }
        preferredContentSize = CGSize(width: width, height: height)
        
        /// 模糊背景
        let visualEffectView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: UIBlurEffect(style: .light)))
        visualEffectView.frame = tableView.bounds
        visualEffectView.autoresizingMask = [.flexibleWidth , .flexibleHeight]
        tableView.backgroundView = visualEffectView
        tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        
        tableView.register(AlbumCell.self, forCellReuseIdentifier: AlbumCell.cellIdentifier)
    }
}
