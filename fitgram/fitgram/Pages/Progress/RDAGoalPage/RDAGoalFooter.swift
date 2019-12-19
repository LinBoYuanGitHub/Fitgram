//
//  RDAGoalFooter.swift
//  fitgram
//
//  Created by boyuan lin on 19/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class RDAGoalFooter:UIView {
    public var goalFooterTitleLable = UILabel()
    public var goalEnergyTitleLabel = UILabel()
    public var goalEnergyValueLabel = UILabel()
    public var goalSeperatorLine = UIView()
    public var goalEnergyTextArea = UITextView()
    
    convenience init() {
        self.init()
        sv(
            goalFooterTitleLable,
            goalEnergyTitleLabel,
            goalEnergyValueLabel,
            goalEnergyTextArea
        )
        layout(
            |-goalFooterTitleLable-|,
            |-goalEnergyTitleLabel-goalEnergyValueLabel-|,
            |-goalSeperatorLine-|,
            |-goalEnergyTextArea-|
        )
        goalFooterTitleLable.font = UIFont(name: "PingFangSC-Regular", size: 20)
        goalFooterTitleLable.text = "自定义营养目标"
        goalEnergyTitleLabel.font = UIFont(name: "PingFangSC-Regular", size: 17)
        goalEnergyValueLabel.font = UIFont(name: "PingFangSC-Regular", size: 17)
        goalEnergyValueLabel.textColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        goalEnergyTextArea.font = UIFont(name: "PingFangSC-Regular", size: 14)
    }
    
    
}
