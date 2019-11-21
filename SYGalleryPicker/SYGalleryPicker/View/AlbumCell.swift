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
        albumTitleLabel.font = UIFont.systemFont(ofSize: 20)
        contentView.addSubview(albumTitleLabel)
        
        albumCountLabel.translatesAutoresizingMaskIntoConstraints = false
        albumCountLabel.font = UIFont.systemFont(ofSize: 15)
        albumCountLabel.textColor = .gray_808080
        contentView.addSubview(albumCountLabel)
        
        let views = ["image": albumImageView, "title": albumTitleLabel, "count": albumCountLabel]
        
        let metrics = ["side": 10, "gap": 10, "size": 80]
        
        var constraints: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(side)-[image(==size)]-(gap)-[title]-(side)-|",options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-(side)-[image]-(gap)-[count]-(side)-|",options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(side)-[image(==size)]-(side)-|", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(29)-[title(==20)]-(2)-[count(==20)]-(29)-|", options: [], metrics: metrics, views: views)
        NSLayoutConstraint.activate(
            constraints
        )

        albumImageView.backgroundColor = .clear
        albumTitleLabel.backgroundColor = .clear
        albumCountLabel.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
