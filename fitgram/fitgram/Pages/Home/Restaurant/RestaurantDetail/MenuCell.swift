//
//  menuCell.swift
//  fitgram
//
//  Created by boyuan lin on 14/1/20.
//  Copyright © 2020 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class MenuCell: UICollectionViewCell {
    public var cellFrameView = UIView()
    
    public var menuImageView = UIImageView()
    public var menuNameLabel = UILabel()
//    public var menuPriceLabel = UILabel()
    public var menuCalorieLabel = UILabel()
    public var likeBtn = UIButton()
    public var checkBtn = UIButton()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sv(
            cellFrameView.sv(
                menuImageView,
                menuNameLabel,
                menuCalorieLabel,
                likeBtn,
                checkBtn
            )
        )
        layout(
            0,
            |-0-cellFrameView-0-|,
            0
        )
        layout(
            0,
            |-0-menuImageView-0-|,
            10,
            |-10-menuNameLabel-|,
            10,
            |-8-menuCalorieLabel-|,
            10,
            |-12-likeBtn-checkBtn-8-|,
            5
        )
        menuNameLabel.font = UIFont(name: "PingFangSC-Regular", size: 17)
//        menuPriceLabel.font = UIFont(name: "PingFangSC-Regular", size: 13)
//        menuPriceLabel.textColor = .lightGray
        menuCalorieLabel.font = UIFont(name: "PingFangSC-Regular", size: 13)
        menuCalorieLabel.textColor = .lightGray
        likeBtn.setImage(UIImage(named: "restaurant_heartIcon_gray"), for: .normal)
        likeBtn.setImage(UIImage(named: "restaurant_heartIcon_red"), for: .selected)
        likeBtn.setTitleColor(.black, for: .normal)
        likeBtn.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 13)
        likeBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
        likeBtn.contentHorizontalAlignment = .left
        checkBtn.setImage(UIImage(named: "plusIcon_yellow"), for: .normal)
        checkBtn.setTitle("打卡", for: .normal)
        checkBtn.setTitleColor(.black, for: .normal)
        checkBtn.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 13)
        checkBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
        cellFrameView.layer.cornerRadius = 5
        cellFrameView.layer.borderColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1).cgColor
        cellFrameView.layer.borderWidth = 1
        cellFrameView.layer.masksToBounds = true
    }
}
