//
//  TextSearchSuggestionCollectionCell.swift
//  fitgram
//
//  Created by boyuan lin on 8/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class TextSearchSuggestionCollectionCell:UICollectionViewCell {
    public var foodTagBtn = UIButton()
    private var plainGray = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        foodTagBtn.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 12)
        foodTagBtn.isEnabled = false
        foodTagBtn.setTitleColor(.black, for: .normal)
//        foodTagBtn.setTitleColor(.white, for: .selected)
        foodTagBtn.setBackgroundColor(color: plainGray, forState: .normal)
//        foodTagBtn.setBackgroundColor(color: .black, forState: .selected)
        foodTagBtn.layer.cornerRadius = 20
        foodTagBtn.clipsToBounds = true
        sv(
            foodTagBtn
        )
        layout(
            |-foodTagBtn-| ~ 30
        )
    }
    
    
}
