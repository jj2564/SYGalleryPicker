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
    
    var style: SelectStyle = .basic {
        didSet { updateTextColor() }
    }
    
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
        albumTitleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        contentView.addSubview(albumTitleLabel)
        
        albumCountLabel.translatesAutoresizingMaskIntoConstraints = false
        albumCountLabel.font = UIFont.systemFont(ofSize: 13)
        albumCountLabel.textColor = .gray_5A5A5A
        contentView.addSubview(albumCountLabel)
        

        let lineView = UIView(frame: .zero)
        lineView.backgroundColor = .gray_F2F2F2
        lineView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(lineView)
        
        let views = ["image": albumImageView, "title": albumTitleLabel, "count": albumCountLabel, "line": lineView]
        
        let metrics = ["side": 10, "gap": 10, "size": 50]
        
        var constraints: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(side)-[image(==size)]-(gap)-[title]-(side)-|",options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-(side)-[image]-(gap)-[count]-(side)-|",options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[line]-(0)-|",options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(side)-[image(==size)]-(side)-|", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(8)-[title(==24)]", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[count(==18)]-(8)-|", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[line(==1)]-(0)-|", options: [], metrics: metrics, views: views)
        NSLayoutConstraint.activate(
            constraints
        )

        albumImageView.backgroundColor = .clear
        albumTitleLabel.backgroundColor = .clear
        albumCountLabel.backgroundColor = .clear
    }
    
    private func updateTextColor() {
        if style == .ta {
            albumTitleLabel.textColor = .green_008800
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
