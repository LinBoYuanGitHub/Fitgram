//
//  ExerciseItemCell.swift
//  fitgram
//
//  Created by boyuan lin on 17/1/20.
//  Copyright © 2020 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class ExerciseItemCell:UICollectionViewCell {
    public var shadowContainer = UIView()
    public var coloredLine = UIView()
    public var dateLabel = UILabel()
    public var exerciseImage = UIImageView()
    public var exerciseNameLabel = UILabel()
    public var exerciseTimesLabel = UILabel()
    public var exerciseDesLabel = UILabel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sv(
            shadowContainer.sv(
                coloredLine,
                dateLabel,
                exerciseImage,
                exerciseNameLabel,
                exerciseTimesLabel,
                exerciseDesLabel
            )
        )
        layout(
            0,
            |-0-shadowContainer-0-|,
            0
        )
        layout(
            20,
            |-8-coloredLine-| ~ 5,
            20,
            |-8-dateLabel-8-|,
            10,
            |-8-exerciseImage-8-| ~ 90,
            5,
            |-8-exerciseNameLabel-exerciseTimesLabel-8-|,
            5,
            |-8-exerciseDesLabel-8-|
        )
        shadowContainer.layer.shadowOffset = CGSize(width: 0, height: 0) //no shadow direction
        shadowContainer.layer.cornerRadius = 10
        shadowContainer.layer.shadowColor = UIColor.black.cgColor
        shadowContainer.layer.shadowOpacity = 0.2
        shadowContainer.layer.shadowRadius = 10
        shadowContainer.backgroundColor = UIColor.white
        shadowContainer.width((UIScreen.main.bounds.width - 60)/2)
        coloredLine.width(40)
        coloredLine.backgroundColor = UIColor(red: 92/255, green: 106/255, blue: 196/255, alpha: 1)
        dateLabel.font = UIFont(name: "PingFangSC-Regular", size: 11)
        exerciseNameLabel.font = UIFont(name: "PingFangSC-Semibold", size: 14)
        exerciseTimesLabel.font = UIFont(name: "PingFangSC-Regular", size: 14)
        exerciseDesLabel.font = UIFont(name: "PingFangSC-Light", size: 11)
        exerciseImage.image = UIImage(named: "exerciseSample_image")
        exerciseTimesLabel.width(30)
    }
}
