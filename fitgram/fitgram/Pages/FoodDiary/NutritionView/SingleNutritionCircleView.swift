//
//  SingleNutritionCircleView.swift
//  fitgram
//
//  Created by boyuan lin on 4/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class SingleNutritionCell: UICollectionViewCell{
    let percentageLabel = UILabel()
    let nutriTextLabel = UILabel()
    let containerView = UIView()
    let statsLabel = UILabel()
    
    private let circleSize = CGSize(width: 66, height: 66)
    private var viewWidth = 66
    private var viewHeight = 20
   
    
    private let circle_color = UIColor(red: 254/255, green: 189/255, blue: 46/255, alpha: 1)
    private let text_color = UIColor(red: 53/255, green: 53/255, blue: 53/255, alpha: 1)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        containerView.layer.cornerRadius = CGFloat(viewWidth/2)
        containerView.layer.borderColor = self.circle_color.cgColor
        containerView.layer.borderWidth = 1.0
        containerView.clipsToBounds = true
        statsLabel.textColor = self.text_color
        statsLabel.textAlignment = .center
        statsLabel.font = UIFont(name: "PingFangSC-Light", size: 10)
//        containerView.addSubview(percentageLabel)
//        containerView.addSubview(nutriTextLabel)
        percentageLabel.textColor = self.text_color
        percentageLabel.font = UIFont(name: "PingFangSC-Medium", size: 16)
        percentageLabel.textAlignment = .center
        percentageLabel.width(50)
        percentageLabel.height(20)
        nutriTextLabel.textColor = self.text_color
        nutriTextLabel.font = UIFont(name: "PingFangSC-Regular", size: 10)
        nutriTextLabel.textAlignment = .center
        nutriTextLabel.width(50)
        nutriTextLabel.height(16)
        sv(
            containerView.sv(percentageLabel,nutriTextLabel),
            statsLabel
        )
        layout(
            8,
            |-9-containerView-9-|,
            5,
            |-0-statsLabel-0-|,
            12
        )
        layout(
            15,
            |-8-percentageLabel-8-|,
            |-8-nutriTextLabel-8-|,
            15
        )
    }
    
    
    
    
}
