//
//  ReportListCell.swift
//  fitgram
//
//  Created by boyuan lin on 18/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class ReportListCell: UITableViewCell {
    private var shadowRect = UIView()
    private var statContainer = UIView()
    public var dateLabel = UILabel()
    public var coachWeeklyLabel = UILabel()
    var arrowImageView = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        sv(
            shadowRect.sv(
                statContainer.sv(
                    dateLabel,
                    coachWeeklyLabel
                ),
                arrowImageView
            )
        )
        layout(
            8,
            |-16-shadowRect-16-|,
            8
        )
        layout(
            |-8-statContainer-arrowImageView-8-|
        )
        layout(
            8,
            |-dateLabel-|,
            |-coachWeeklyLabel-|,
            8
        )
        shadowRect.width(UIScreen.main.bounds.width - 16)
        shadowRect.layer.shadowOffset = CGSize(width: 0, height: 0) //no shadow direction
        shadowRect.layer.cornerRadius = 5
        shadowRect.layer.shadowColor = UIColor.black.cgColor
        shadowRect.layer.shadowOpacity = 0.1
        shadowRect.layer.shadowRadius = 10
        shadowRect.backgroundColor = UIColor.white
        //label font
        dateLabel.font = UIFont(name: "PingFangSC-Medium", size: 17)
        coachWeeklyLabel.font = UIFont(name: "PingFangSC-Medium", size: 17)
        //image arrow
        arrowImageView.image = UIImage(named: "rightArrow_black")
        arrowImageView.width(10)
        arrowImageView.height(15)
        arrowImageView.centerVertically()
        
    }
    
   
    
}
