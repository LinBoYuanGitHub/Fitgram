//
//  FoodDiaryDetailViewCell.swift
//  fitgram
//
//  Created by boyuan lin on 12/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class FoodDiaryDetailViewCell: UITableViewCell {
    public var foodNameLabel = UILabel()
    public var foodFavButton = UIButton()
    public var foodDelButton = UIButton()
    public var calorieLabel = UILabel()
    public var weightLabel = UILabel()
    public var amountInputField = UITextField()
    public var unitInputField = UITextField()
    public var shadowCover = UIView(frame: CGRect(x: 16, y: 8, width: UIScreen.main.bounds.width - 32, height: 180))
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        sv(
            foodNameLabel,
            foodFavButton,
            foodDelButton,
            calorieLabel,
            weightLabel,
            amountInputField,
            unitInputField
        )
        layout(
            2,
            |-24-foodNameLabel.width(20%)-10-foodFavButton.width(10%)-2-foodDelButton.width(10%)-24-| ~ 60,
            8,
            |-24-calorieLabel-weightLabel-24-| ~ 25,
            5,
            |-24-amountInputField-unitInputField-24-| ~ 50,
            8
        )
        shadowCover.layer.shadowOffset = CGSize(width: 0, height: 0) //no shadow direction
        shadowCover.layer.cornerRadius = 10
        shadowCover.layer.shadowColor = UIColor.black.cgColor
        shadowCover.layer.shadowOpacity = 0.2
        shadowCover.layer.shadowRadius = 10
        shadowCover.backgroundColor = UIColor.white
        foodNameLabel.font = UIFont(name: "PingFangSC-Semibold", size: 18)
        foodNameLabel.textColor = UIColor(red: 53/255, green: 53/255, blue: 53/255, alpha: 1.0)
        foodNameLabel.numberOfLines = 2
        foodFavButton.setTitle("", for: .normal)
        foodFavButton.setImage(UIImage(named: "favButton_gray"), for: .normal)
        foodDelButton.setImage(UIImage(named: "delBin_gray"), for: .normal)
        calorieLabel.font = UIFont(name: "PingFangSC-Regular", size: 14)
        weightLabel.font = UIFont(name: "PingFangSC-Regular", size: 14)
        weightLabel.textColor = .lightGray
        amountInputField.width(20%)
        unitInputField.width(60%)
        unitInputField.textAlignment = .right
        self.addSubview(shadowCover)
        self.sendSubviewToBack(shadowCover)
    }
}
