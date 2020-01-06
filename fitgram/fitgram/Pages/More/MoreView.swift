//
//  MoreView.swift
//  fitgram
//
//  Created by boyuan lin on 31/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class MoreView: UIView {
    public var portraitImageView = UIImageView()
    public var portraitTitleLabel = UILabel()
    public var arrowImageView = UIImageView()
    
    public var horizontalContainer = UIView()
    
    public var coachContainer = UIView()
    public var coachMemberIcon = UIImageView()
    public var coachMemberLabel = UILabel()
    
    public var verticalView = UIView()
    
    public var nutriContainer = UIView()
    public var nutriRecommendIcon = UIImageView()
    public var nutriRecommendLabel = UILabel()
    
    convenience init(){
        self.init(frame: .zero)
        sv(
            portraitImageView,
            portraitTitleLabel,
            arrowImageView,
            horizontalContainer.sv(
                coachContainer.sv(
                    coachMemberIcon,
                    coachMemberLabel
                ),
                verticalView,
                nutriContainer.sv(
                    nutriRecommendIcon,
                    nutriRecommendLabel
                )
            )
        )
        layout(
            20,
            |-portraitImageView-portraitTitleLabel-arrowImageView-| ~ 100,
            20,
            |-horizontalContainer-| ~ 80
        )
        layout(
            |-coachContainer-verticalView-nutriContainer-|
        )
        layout(
            |-coachMemberIcon-|,
            |-coachMemberLabel-|
        )
        layout(
            |-nutriRecommendIcon-|,
            |-nutriRecommendLabel-|
        )
        portraitImageView.width(80)
        portraitImageView.height(80)
        portraitTitleLabel.font = UIFont(name: "PingFangSC-Medium", size: 20)
        arrowImageView.image = UIImage(named: "rightArrow_black")
        
    }
}
