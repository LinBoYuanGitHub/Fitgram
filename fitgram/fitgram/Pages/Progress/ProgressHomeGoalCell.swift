//
//  ProgressHomeGoalCell.swift
//  fitgram
//
//  Created by boyuan lin on 12/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class ProgressHomeGoalCell:UITableViewCell {
    public var titleLabel = UILabel()
    public var arrowImage = UIImageView()
    public var goalLabel = UILabel()
    public var expctedDateLable = UILabel()
    public var goalProgressBar = UIProgressView()
    public var initialWeightLabel = UILabel()
    public var targetWeightLabel = UILabel()
    
    public var onArrowPressedAction: () -> Void = {}
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.isUserInteractionEnabled = true
        sv(
            titleLabel,
            arrowImage,
            goalLabel,
            expctedDateLable,
            goalProgressBar,
            initialWeightLabel,
            targetWeightLabel
        )
        layout(
            8,
            |-16-titleLabel-arrowImage-16-|,
            20,
            |-16-goalLabel-16-|,
            5,
            |-16-expctedDateLable-16-|,
            20,
            |-16-goalProgressBar-16-|,
            3,
            |-16-initialWeightLabel-targetWeightLabel-16-|,
            20
        )
        titleLabel.font = UIFont(name: Constants.Dimension.RegularFont, size: 14)
        titleLabel.text = "目标:减脂"
        arrowImage.image = UIImage(named: "rightArrow_black")
        arrowImage.width(10)
        arrowImage.height(15)
        arrowImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(onArrowPressed))
        arrowImage.addGestureRecognizer(tapGesture)
        
        goalLabel.width(50%)
        goalLabel.textAlignment = .center
        goalLabel.text = "已减去1.2公斤"
        goalLabel.font = UIFont(name: Constants.Dimension.RegularFont, size: 18)
        goalLabel.centerHorizontally()
        
        expctedDateLable.text = "预计30天可以达到目标"
        expctedDateLable.textAlignment = .center
        expctedDateLable.font = UIFont(name: "PingFangSC-Regular", size: 13)
        expctedDateLable.centerHorizontally()
        
        goalProgressBar.height(10)
        goalProgressBar.progressViewStyle = .bar
        goalProgressBar.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        goalProgressBar.progressTintColor = UIColor(red: 252/255, green: 200/255, blue: 45/255, alpha: 1)
        goalProgressBar.progress  = 0.2
        goalProgressBar.layer.cornerRadius = 5
        goalProgressBar.layer.masksToBounds = true
        
        initialWeightLabel.text = "初始 53公斤"
        initialWeightLabel.textAlignment = .left
        initialWeightLabel.font = UIFont(name: "PingFangSC-Light", size: 13)
        targetWeightLabel.text = "目标 45公斤"
        targetWeightLabel.textAlignment = .right
        targetWeightLabel.font = UIFont(name: "PingFangSC-Light", size: 13)
    }
    
    @objc func onArrowPressed(){
        self.onArrowPressedAction()
    }
}
