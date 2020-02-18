//
//  ProgressReportCell.swift
//  fitgram
//
//  Created by boyuan lin on 12/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class ProgressReportCell:UITableViewCell {
    public var reportIcon = UIButton()
    public var arrowImageView = UIImageView()
    public var seperatorLine = UIView()
    public var onReportPressed: () -> Void  = {  }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        sv(
            reportIcon,
            arrowImageView,
            seperatorLine
        )
        layout(
            15,
            |-16-reportIcon-arrowImageView-16-|,
            15,
            |-16-seperatorLine-0-| ~ 1,
            0
        )
        seperatorLine.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        reportIcon.setImage(UIImage(named: "reportIcon"), for: .normal)
        reportIcon.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
        reportIcon.setTitle("Health Report", for: .normal)
        reportIcon.setTitleColor(.black, for: .normal)
        reportIcon.contentHorizontalAlignment = .left
        reportIcon.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 14)
        arrowImageView.image = UIImage(named: "rightArrow_black")
        reportIcon.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 14)
        reportIcon.addTarget(self, action: #selector(onEnterReport), for: .touchUpInside)
    }
    
    @objc func onEnterReport(){
        onReportPressed()
    }
    
    
}
