//
//  LikeCollectionViewCell.swift
//  fitgram
//
//  Created by boyuan lin on 12/1/20.
//  Copyright © 2020 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class LikeCollectionViewCell: UICollectionViewCell{
    
    public var foodImageView = UIImageView()
    public var filterView = UIView()
    public var calorieLabel = UILabel()
    public var foodNameLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sv(
            foodImageView.sv(
                filterView.sv(
                    calorieLabel,
                    foodNameLabel
                )
            )
        )
        layout(
            |-0-foodImageView-0-| ~ 120
        )
        layout(
            |-0-filterView-0-| ~ 120
        )
        layout(
            5,
            |-16-calorieLabel-|,
            5,
            |-16-foodNameLabel-32-|
        )
        foodImageView.layer.cornerRadius = 4
        foodImageView.layer.masksToBounds = true
        filterView.layer.cornerRadius = 5
        filterView.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 0.3)
        calorieLabel.font = UIFont(name: "PingFangSC-Medium", size: 11)
        calorieLabel.textColor = .white
        foodNameLabel.font = UIFont(name: "PingFangSC-Medium", size: 14)
        foodNameLabel.textColor = .white
        foodNameLabel.numberOfLines = 0
    }
}
