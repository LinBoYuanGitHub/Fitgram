//
//  RestaurantCell.swift
//  fitgram
//
//  Created by boyuan lin on 9/1/20.
//  Copyright © 2020 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class RestaurantCell: UITableViewCell {
    public var restaurantImageView = UIImageView()
    public var infoShadow = UIView()
    public var restaurantNameLabel = UILabel()
    public var ratingStarView = UIView()
    
    public var addressContainer = UIView()
    public var addressIcon = UIImageView()
    public var addressLabel = UILabel()
    
    public var distanceLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        sv(
            restaurantImageView.sv(
                infoShadow.sv(
                    restaurantNameLabel,
                    ratingStarView,
                    addressContainer.sv(
                        addressIcon,
                        addressLabel,
                        distanceLabel
                    )
                )
            )
        )
        layout(
            |-0-restaurantImageView-0-|
        )
        layout(
            |-0-infoShadow-0-|,
            0
        )
        layout(
            10,
            |-32-restaurantNameLabel-32-|,
            5,
            |-32-ratingStarView-32-| ~ 20,
            5,
            |-32-addressContainer-32-|
        )
        layout(
            |-0-addressIcon-10-addressLabel-distanceLabel-0-|
        )
        restaurantImageView.width(UIScreen.main.bounds.width)
        restaurantImageView.height(250)
        infoShadow.width(UIScreen.main.bounds.width)
        infoShadow.height(100)
        infoShadow.backgroundColor = .black
        infoShadow.alpha = 0.75
        restaurantNameLabel.font = UIFont(name: "PingFangSC-Medium", size: 17)
        restaurantNameLabel.textColor = .white
        addressLabel.font = UIFont(name: "PingFangSC-Light", size: 11)
        addressLabel.textColor = .white
        distanceLabel.font = UIFont(name: "PingFangSC-Light", size: 11)
        distanceLabel.textColor = .white
        addressIcon.image = UIImage(named: "locationIcon_yellow")
        addressIcon.width(15)
        addressIcon.height(15)
    }
    
    public func setRatingStar(rating: Int) {
        for index in 0...4 {
            var starView:UIImageView? = nil
            if index <= rating-1{
                starView = UIImageView(image: UIImage(named: "starFilled_yellow"))
            } else {
                starView = UIImageView(image: UIImage(named: "starStroke_yellow"))
            }
            starView!.frame = CGRect(x: index * 20, y: 0, width: 15, height: 15)
            ratingStarView.addSubview(starView!)
        }
    }
}
