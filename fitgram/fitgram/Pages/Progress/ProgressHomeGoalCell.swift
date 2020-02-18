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
        titleLabel.text = "Goal:Lose Weight"
        arrowImage.image = UIImage(named: "rightArrow_black")
        arrowImage.width(10)
        arrowImage.height(15)
        arrowImage.isHidden = true
        arrowImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(onArrowPressed))
        arrowImage.addGestureRecognizer(tapGesture)
        
        goalLabel.width(50%)
        goalLabel.textAlignment = .center
        goalLabel.text = "Currently Lost 1.2 kg"
        goalLabel.font = UIFont(name: Constants.Dimension.RegularFont, size: 18)
        goalLabel.centerHorizontally()
        
        expctedDateLable.text = "30 days left to reach goal"
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
        
        initialWeightLabel.text = "Initial Weight  53kg"
        initialWeightLabel.textAlignment = .left
        initialWeightLabel.font = UIFont(name: "PingFangSC-Light", size: 13)
        targetWeightLabel.text = "Target Weight 45kg"
        targetWeightLabel.textAlignment = .right
        targetWeightLabel.font = UIFont(name: "PingFangSC-Light", size: 13)
    }
    
    @objc func onArrowPressed(){
        self.onArrowPressedAction()
    }
}
