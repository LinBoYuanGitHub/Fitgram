//
//  SingleNutritionCircleView.swift
//  fitgram
//
//  Created by boyuan lin on 4/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class SingleNutritionCell: UICollectionViewCell{
    let percentageLabel = UILabel()
    let nutriTextLabel = UILabel()
    let containerView = UIView()
    let statsLabel = UILabel()
    
    private let circleSize = CGSize(width: 66, height: 66)
    private var viewHeight = 100
    private var viewWidth = 66
    
    private let circle_color = UIColor(red: 254/255, green: 189/255, blue: 46/255, alpha: 1)
    private let text_color = UIColor(red: 53/255, green: 53/255, blue: 53/255, alpha: 53/255)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        containerView.layer.cornerRadius = 0.5 * containerView.bounds.width
        containerView.layer.borderColor = self.circle_color.cgColor
        containerView.layer.borderWidth = 1.0
        containerView.frame.size = circleSize
        statsLabel.textColor = self.text_color
        statsLabel.font = UIFont(name: "PingFangSC-Light", size: 10)
        statsLabel.frame.size = CGSize(width: self.viewWidth, height: 15)
        statsLabel.frame.origin = CGPoint(x: 0 , y: viewHeight - viewWidth - 5)
        addSubview(containerView)
        addSubview(statsLabel)
        containerView.addSubview(percentageLabel)
        containerView.addSubview(nutriTextLabel)
        percentageLabel.textColor = self.text_color
        percentageLabel.font = UIFont(name: "PingFangSC-Medium", size: 16)
        percentageLabel.textAlignment = .center
        nutriTextLabel.textColor = self.text_color
        nutriTextLabel.font = UIFont(name: "PingFangSC-Regular", size: 10)
        nutriTextLabel.textAlignment = .center
    }
    
    
    
    
}
