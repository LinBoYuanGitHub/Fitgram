//
//  RestaurantDetailView.swift
//  fitgram
//
//  Created by boyuan lin on 9/1/20.
//  Copyright © 2020 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class RestaurantDetailView: UIView{
    public var restaurantNameLabel = UILabel()
    public var ratingStarView = UIView()
    public var locationContainer = UIView()
    
    public var topLine = UIView()
    public var bottomLine = UIView()
    
    public var locationIcon = UIImageView()
    public var arrowImage = UIImageView()
    public var addressLabel = UILabel()
    
    public var menuCollectionView = UICollectionView(frame: CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 150), collectionViewLayout: UICollectionViewFlowLayout())
    
    convenience init() {
        self.init(frame: .zero)
        self.backgroundColor = .white
        sv(
            restaurantNameLabel,
            ratingStarView,
            locationContainer.sv(
                topLine,
                locationIcon,
                arrowImage,
                addressLabel,
                bottomLine
            ),
            menuCollectionView
        )
        layout(
            20,
            |-16-restaurantNameLabel-16-|,
            5,
            |-16-ratingStarView-16-| ~ 20,
            15,
            |-16-locationContainer-16-|,
            10,
            |-8-menuCollectionView-8-|,
            0
        )
        layout(
            0,
            |-0-topLine-0-| ~ 1,
            10,
            |-0-locationIcon-10-addressLabel-arrowImage-0-|,
            10,
            |-0-bottomLine-0-| ~ 1,
            0
        )
        restaurantNameLabel.font = UIFont(name: "PingFangSC-Medium", size: 17)
        topLine.backgroundColor = .lightGray
        bottomLine.backgroundColor = .lightGray
        topLine.alpha = 0.5
        bottomLine.alpha = 0.5
        //location layout
        locationIcon.width(17)
        locationIcon.height(20)
        locationIcon.centerVertically()
        locationIcon.image = UIImage(named: "locationIcon_gray")
        addressLabel.font = UIFont(name: "PingFangSC-Light", size: 13)
        addressLabel.centerVertically()
        arrowImage.image = UIImage(named: "rightArrow_black")
        arrowImage.width(8)
        arrowImage.height(13)
        arrowImage.centerVertically()
        menuCollectionView.register(MenuCell.self, forCellWithReuseIdentifier: "MenuCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let width = (UIScreen.main.bounds.width - 30) / 2
        layout.itemSize = CGSize(width: width, height: 305)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 10
        menuCollectionView.collectionViewLayout = layout
        menuCollectionView.backgroundColor = .white
        menuCollectionView.showsVerticalScrollIndicator = false
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    public func setRatingStar(rating: Int) {
        for index in 0...4 {
            var starView:UIImageView? = nil
            if index <= rating-1{
                starView = UIImageView(image: UIImage(named: "starFilled_yellow"))
            } else {
                starView = UIImageView(image: UIImage(named: "starStroke_yellow"))
            }
            starView!.frame = CGRect(x: index * 20, y: 5, width: 15, height: 15)
            ratingStarView.addSubview(starView!)
        }
    }
}
