//
//  GroceryTableCell.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 11/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class GroceryTableCell: UITableViewCell {
    public var checkBox = UIButton()
    public var dishImage = UIImageView()
    public var dishLabel = UILabel()
    public var arrowImage = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        dishImage.contentMode = .scaleAspectFill
        dishImage.layer.cornerRadius = 10
        dishImage.layer.masksToBounds = true
        dishImage.width(90)
        dishImage.height(90)
        dishLabel.width(168)
        dishLabel.textColor = .black
        dishLabel.font = UIFont(name: "PingFangSC-Regular", size: 17)
        arrowImage.image = UIImage(named: "rightArrow_black")
        arrowImage.width(8)
        arrowImage.height(13)
        //checkbox setting
        checkBox.width(50)
        checkBox.height(50)
        checkBox.setImage(UIImage(named: "checkbox_selected_yellow"), for: .selected)
        checkBox.setImage(UIImage(named: "checkbox_unselected"), for: .normal)
        sv(
            checkBox,
            dishImage,
            dishLabel,
            arrowImage
        )
        layout(
            |-10-checkBox-10-dishImage-10-dishLabel-13-arrowImage-16-|
        )
    }
    
    
    
}
