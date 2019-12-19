//
//  ProgressMeasurementLogCell.swift
//  fitgram
//
//  Created by boyuan lin on 17/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class ProgressHomeMeasurementLogCell:UICollectionViewCell {
    
    public let cubicShadow = UIView()
    public var lineView = UIView()
    public var titleLabel = UILabel()
    public var valueLabel = UILabel()
    public var unitLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        sv(
            cubicShadow.sv(
                lineView,
                titleLabel,
                valueLabel,
                unitLabel
            )
        )
        layout(
            5,
            |-cubicShadow.width(100)-| ~ 100,
            5
        )
        layout(
            8,
            |-16-lineView-32-|,
            8,
            |-16-titleLabel-|,
            16,
            |-16-valueLabel-unitLabel-|
        )
        cubicShadow.layer.shadowOffset = CGSize(width: 0, height: 0) //no shadow direction
        cubicShadow.layer.cornerRadius = 5
        cubicShadow.layer.shadowColor = UIColor.black.cgColor
        cubicShadow.layer.shadowOpacity = 0.05
        cubicShadow.layer.shadowRadius = 10
        cubicShadow.backgroundColor = UIColor.white
        //line view
        lineView.backgroundColor = UIColor(red: 180/255, green: 225/255, blue: 250/255, alpha: 1)
        lineView.layer.cornerRadius = 2
        lineView.clipsToBounds = true
        lineView.height(5)
        titleLabel.font = UIFont(name: "PingFangSC-Medium", size: 14)
        valueLabel.font = UIFont(name: "PingFangSC-Medium", size: 20)
        valueLabel.textColor = UIColor(red: 252/255, green: 200/255, blue: 45/255, alpha: 1)
        unitLabel.font = UIFont(name: "PingFangSC-Light", size: 8)
    }
}
