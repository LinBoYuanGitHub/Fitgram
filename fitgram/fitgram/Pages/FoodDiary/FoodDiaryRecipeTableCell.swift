//
//  FoodDiaryRecipeListView.swift
//  fitgram
//
//  Created by boyuan lin on 5/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class FoodDiaryRecipeTableCell: UITableViewCell {
    public var foodNameLabel = UILabel()
    public var portionLabel = UILabel()
    public var calorieLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        sv(
            foodNameLabel,
            portionLabel,
            calorieLabel
        )
        foodNameLabel.top(5%)
        foodNameLabel.left(2%)
        portionLabel.bottom(5%)
        portionLabel.left(2%)
        calorieLabel.right(2%)
        calorieLabel.centerVertically()
        //ui style part
        foodNameLabel.font = UIFont(name: "PingFangSC-Regular", size: 12)
        foodNameLabel.textColor = .black
        portionLabel.font = UIFont(name: "PingFangSC-Regular", size: 12)
        portionLabel.textColor = .gray
        calorieLabel.font = UIFont(name: "PingFangSC-Light", size: 16)
        calorieLabel.textColor = .black
    }
}
