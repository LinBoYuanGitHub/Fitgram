//
//  RDAGoalCell.swift
//  fitgram
//
//  Created by boyuan lin on 18/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class RDAGoalCell: UITableViewCell {
    public var titleLabel = UILabel()
    public var valueLabel = UITextField()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        sv(
            titleLabel,
            valueLabel
        )
        layout(
            10,
            |-32-titleLabel-valueLabel-32-|,
            10
        )
        titleLabel.font = UIFont(name: "PingFangSC-Regular", size: 17)
        valueLabel.font = UIFont(name: "PingFangSC-Regular", size: 17)
    }
    
    
    
    
}
