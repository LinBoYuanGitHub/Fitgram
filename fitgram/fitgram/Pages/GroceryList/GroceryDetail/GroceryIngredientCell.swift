//
//  GroceryIngredientCell.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 11/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class GroceryIngredientCell: UITableViewCell {
    public var checkBox = UIButton(frame: CGRect(x: 16, y: 26, width: 20, height: 20))
    public var ingredientNameLabel = UILabel(frame: CGRect(x: 46, y: 13, width: UIScreen.main.bounds.width - 46, height: 25))
    public var portionDescLabel = UILabel(frame: CGRect(x: 46, y: 41, width: UIScreen.main.bounds.width - 46, height: 25))
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        checkBox.setImage(UIImage(named: "checkbox_unselected"), for: .normal)
        checkBox.setImage(UIImage(named: "checkbox_selected_gray"), for: .selected)
        ingredientNameLabel.font = UIFont(name: "PingFangSC-Regular", size: 17)
        portionDescLabel.textColor = UIColor.gray
        self.addSubview(checkBox)
        self.addSubview(ingredientNameLabel)
        self.addSubview(portionDescLabel)
    }
}
