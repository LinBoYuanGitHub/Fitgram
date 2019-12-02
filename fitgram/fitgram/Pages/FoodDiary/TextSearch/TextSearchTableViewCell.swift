//
//  TextSearchTableViewCell.swift
//  fitgram
//
//  Created by boyuan lin on 8/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class TextSearchTableViewCell: UITableViewCell {
    public var foodImage = UIImageView(frame: CGRect(x: 0, y: 3, width: 64, height: 64))
    public var foodNameLabel = UILabel(frame: CGRect(x: 70, y: 12, width: 200, height: 20))
    public var foodDescLabel = UILabel(frame: CGRect(x: 70, y: 32, width: 200, height: 20))
    public var calorieValueLabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.width - 100, y: 12, width: 66, height: 20))
    public var calorieUnitLabel = UILabel(frame: CGRect(x:  UIScreen.main.bounds.width - 100, y: 32, width: 66, height: 20))
    
    
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        foodImage.backgroundColor = .lightGray
        foodNameLabel.textColor = .black
        foodNameLabel.font = UIFont(name: "PingFangSC-Medium", size: 16)
        foodDescLabel.textColor = .black
        foodDescLabel.font = UIFont(name: "PingFangSC-Regular", size: 14)
        calorieUnitLabel.textColor = .black
        calorieUnitLabel.font = UIFont(name: "PingFangSC-Regular", size: 16)
        calorieUnitLabel.textAlignment = .right
        calorieValueLabel.textColor = .black
        calorieValueLabel.font = UIFont(name: "PingFangSC-Medium", size: 16)
        calorieValueLabel.textAlignment = .right
        addSubview(foodImage)
        addSubview(foodNameLabel)
        addSubview(foodDescLabel)
        addSubview(calorieValueLabel)
        addSubview(calorieUnitLabel)
    }
    
    
    
    
    
    
}
