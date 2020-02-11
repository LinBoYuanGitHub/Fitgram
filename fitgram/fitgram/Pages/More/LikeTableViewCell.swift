//
//  LikeTableViewCell.swift
//  fitgram
//
//  Created by boyuan lin on 19/1/20.
//  Copyright © 2020 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class LikeTableViewCell:UITableViewCell {
    public var restaurantImageView = UIImageView()
    public var infoShadow = UIView()
    public var restaurantNameLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
    }
       
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        sv(
            restaurantImageView.sv(
                infoShadow.sv(
                    restaurantNameLabel
                )
            )
        )
        layout(
            0,
            |-0-restaurantImageView-0-| ~ 200,
            0
        )
        layout(
            |-0-infoShadow-0-| ~ 50,
            0
        )
        layout(
            10,
            |-32-restaurantNameLabel-32-|
        )
        restaurantImageView.width(UIScreen.main.bounds.width)
        restaurantImageView.height(200)
        restaurantImageView.contentMode = .scaleAspectFit
        infoShadow.width(UIScreen.main.bounds.width)
        infoShadow.height(50)
        infoShadow.backgroundColor = .black
        infoShadow.alpha = 0.75
        restaurantNameLabel.font = UIFont(name: "PingFangSC-Medium", size: 17)
        restaurantNameLabel.textColor = .white
    }
}
