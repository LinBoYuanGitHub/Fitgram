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
    public var verticleImgage = UIImageView()
    public var shadowCover = UIView(frame: CGRect(x: 16, y: 8, width: UIScreen.main.bounds.width - 32, height: 180))
    public var portionContainer = UIView()
    
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
            portionContainer.sv(
                amountInputField,
                verticleImgage,
                unitInputField
            )
        )
        layout(
            8,
            |-36-foodNameLabel.width(60%)-10-foodFavButton.width(10%)-2-foodDelButton.width(10%)-36-| ~ 60,
            8,
            |-36-calorieLabel-weightLabel-36-| ~ 25,
            5,
            |-36-portionContainer-36-| ~ 50
        )
        layout(
            |-36-amountInputField-verticleImgage-unitInputField-36-| ~ 50
        )
        portionContainer.layer.borderColor = UIColor.lightGray.cgColor
        portionContainer.layer.borderWidth = 1
        portionContainer.layer.cornerRadius = 20
        portionContainer.layer.masksToBounds = true
        verticleImgage.width(1)
        verticleImgage.height(50)
        verticleImgage.contentMode = .scaleToFill
        verticleImgage.image = UIImage(named: "verticle_line")
        shadowCover.layer.shadowOffset = CGSize(width: 0, height: 0) //no shadow direction
        shadowCover.layer.cornerRadius = 10
        shadowCover.layer.shadowColor = UIColor.black.cgColor
        shadowCover.layer.shadowOpacity = 0.2
        shadowCover.layer.shadowRadius = 10
        shadowCover.backgroundColor = UIColor.white
        foodNameLabel.font = UIFont(name: "PingFangSC-Semibold", size: 18)
        foodNameLabel.textAlignment = .left
        foodNameLabel.textColor = UIColor(red: 53/255, green: 53/255, blue: 53/255, alpha: 1.0)
        foodNameLabel.numberOfLines = 2
        foodFavButton.setTitle("", for: .normal)
        foodFavButton.setImage(UIImage(named: "favButton_gray"), for: .normal)
        foodDelButton.setImage(UIImage(named: "delBin_gray"), for: .normal)
        calorieLabel.font = UIFont(name: "PingFangSC-Regular", size: 14)
        weightLabel.font = UIFont(name: "PingFangSC-Regular", size: 14)
        weightLabel.textColor = .lightGray
        amountInputField.width(25%)
        amountInputField.keyboardType = .decimalPad
        unitInputField.width(55%)
        unitInputField.textAlignment = .right
        self.addSubview(shadowCover)
        self.sendSubviewToBack(shadowCover)
    }
    
    
}
