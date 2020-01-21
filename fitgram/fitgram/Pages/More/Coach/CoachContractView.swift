//
//  CoachDetailView.swift
//  fitgram
//
//  Created by boyuan lin on 10/1/20.
//  Copyright © 2020 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class CoachContractView:UIView {
    public var coachPortraitContainer = UIView()
    public var coachPortraitImageView = UIImageView()
    public var coachNameLabel = UILabel()
    public var locationNameLabel = UILabel()
    public var gymInfoLabel = UILabel()
    
    public var expTextLabel = UILabel()
    public var expYearLabel = UILabel()
    public var certificationLabel = UILabel()
    public var certificationCourseLabel = UILabel()
    
    public var checkBtn = UIButton()
    public var termsConditionTextView = UILabel()
    
    private var upperLineView = UIView()
    private var bottomLineView = UIView()
    
    public var confirmBtn = UIButton()
    
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
            checkBtn,
            termsConditionTextView,
            confirmBtn
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
            |-16-checkBtn-10-termsConditionTextView-16-|,
            20,
            |-32-confirmBtn-32-| ~ 50
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
        
        termsConditionTextView.numberOfLines = 3
        termsConditionTextView.font = UIFont(name: "PingFangSC-Regular", size: 13)
        checkBtn.setImage(UIImage(named: "checkBtnBox"), for: .normal)
        align(tops: [checkBtn,termsConditionTextView])
        //bottom confirm button
        confirmBtn.centerHorizontally()
        confirmBtn.backgroundColor = UIColor(red: 33/255, green: 43/255, blue: 54/255, alpha: 1)
        confirmBtn.layer.cornerRadius = 20
        confirmBtn.setTitle("确认", for: .normal)
    }
}
