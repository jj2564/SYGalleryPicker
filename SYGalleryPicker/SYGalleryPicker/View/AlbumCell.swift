//
//  AlbumCell.swift
//  SYGalleryPicker
//
//  Created by IrvingHuang on 2019/11/14.
//  Copyright © 2019 Sinyi Realty Inc. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {

    static let cellIdentifier = "albumCell"
    
    let albumImageView: UIImageView = UIImageView(frame: .zero)
    let albumTitleLabel: UILabel = UILabel(frame: .zero)
    let albumCountLabel: UILabel = UILabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        selectionStyle = .none
        
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(albumImageView)
        
        albumTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(albumTitleLabel)
        
        albumCountLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(albumCountLabel)
        
        let views = ["image": albumImageView, "title": albumTitleLabel, "count": albumCountLabel]
        
        let metrics = ["side": 10, "gap": 10]
        
        var constraints: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "H|-(side)-[image(==80)]-(gap)-[title]-(side)-|",options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H|-(side)-[image]-(gap)-[count]-(side)-|",options: [], metrics: metrics, views: views)
        NSLayoutConstraint.activate(
            constraints
        )
        albumImageView.heightAnchor.constraint(equalTo: albumImageView.widthAnchor, multiplier: 1.0).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
