//
//  CoachInfoView.swift
//  fitgram
//
//  Created by boyuan lin on 20/1/20.
//  Copyright © 2020 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class CoachInfoView:UIView {
    public var coachPortraitContainer = UIView()
    public var coachPortraitImageView = UIImageView()
    public var coachNameLabel = UILabel()
    public var locationNameLabel = UILabel()
    public var gymInfoLabel = UILabel()
    
    public var expTextLabel = UILabel()
    public var expYearLabel = UILabel()
    public var certificationLabel = UILabel()
    public var certificationCourseLabel = UILabel()
    
    private var upperLineView = UIView()
    private var bottomLineView = UIView()
    
    public var serviceDurationLabel = UILabel()
    public var startTitleLabel = UILabel()
    public var startDateLabel = UILabel()
    public var endTitleLabel = UILabel()
    public var endDateLabel = UILabel()
    
    private let CoachPortraitLength:CGFloat = 150
    
    convenience init(){
        self.init(frame: .zero)
        self.backgroundColor = .white
        sv(
            coachPortraitContainer.sv(
                coachPortraitImageView
            ),
            coachNameLabel,
            locationNameLabel,
            gymInfoLabel,
            upperLineView,
            expTextLabel,
            expYearLabel,
            certificationLabel,
            certificationCourseLabel,
            bottomLineView,
            serviceDurationLabel,
            startTitleLabel,
            startDateLabel,
            endTitleLabel,
            endDateLabel
        )
        layout(
            20,
            |-coachPortraitContainer-|,
            10,
            |-16-coachNameLabel-16-|,
            10,
            |-locationNameLabel-|,
            20,
            |-gymInfoLabel-|,
            20,
            |-16-upperLineView-16-|,
            10,
            |-16-expTextLabel-16-|,
            5,
            |-16-expYearLabel-16-|,
            20,
            |-16-certificationLabel-16-|,
            5,
            |-16-certificationCourseLabel-16-|,
            20,
            |-16-bottomLineView-16-|,
            20,
            |-16-serviceDurationLabel-|,
            10,
            |-16-startTitleLabel-endTitleLabel-16-|,
            10,
            |-16-startDateLabel-endDateLabel-16-|
        )
        layout(
            |-coachPortraitImageView-|
        )
        coachPortraitContainer.width(CoachPortraitLength)
        coachPortraitContainer.height(CoachPortraitLength)
        coachPortraitContainer.centerHorizontally()
        coachPortraitContainer.layer.cornerRadius = CoachPortraitLength/2
        coachPortraitContainer.clipsToBounds = true
        coachPortraitContainer.layer.borderWidth = 1
        coachPortraitContainer.layer.borderColor = UIColor.black.cgColor
        
        coachPortraitImageView.width(130)
        coachPortraitImageView.height(130)
        coachPortraitImageView.centerHorizontally()
        coachPortraitImageView.centerVertically()
        
        coachNameLabel.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        coachNameLabel.centerHorizontally()
        coachNameLabel.textAlignment = .center
        locationNameLabel.centerHorizontally()
        locationNameLabel.textColor = .lightGray
        locationNameLabel.textAlignment = .center
        gymInfoLabel.centerHorizontally()
        gymInfoLabel.textColor = .lightGray
        gymInfoLabel.textAlignment = .center
        //bottom part
        expTextLabel.font = UIFont(name: "PingFangSC-Regular", size: 17)
        expYearLabel.textColor = .lightGray
        expYearLabel.font = UIFont(name: "PingFangSC-Regular", size: 13)
        certificationLabel.font = UIFont(name: "PingFangSC-Regular", size: 17)
        certificationCourseLabel.font = UIFont(name: "PingFangSC-Regular", size: 13)
        certificationCourseLabel.textColor = .lightGray
        //seperator Line
        upperLineView.backgroundColor = .lightGray
        upperLineView.height(1)
        bottomLineView.backgroundColor = .lightGray
        bottomLineView.height(1)
        //service duration
        serviceDurationLabel.text = "Service Term"
        serviceDurationLabel.font = UIFont(name: "PingFangSC-Regular", size: 17)
        startTitleLabel.text = "Service Start Date"
        startTitleLabel.font = UIFont(name: "PingFangSC-Regular", size: 14)
        endTitleLabel.font =  UIFont(name: "PingFangSC-Regular", size: 14)
        endTitleLabel.text = "Service End Date"
        startDateLabel.font = UIFont(name: "PingFangSC-Regular", size: 14)
        startDateLabel.textColor = .lightGray
        endDateLabel.font = UIFont(name: "PingFangSC-Regular", size: 14)
        endDateLabel.textColor = .lightGray
    }
}
