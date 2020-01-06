//
//  BodyMeasurementInputCell.swift
//  fitgram
//
//  Created by boyuan lin on 20/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class BodyMeasurementInputCell: UITableViewCell{
    public var titleLabel = UILabel()
    public var valTextField = UITextField()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        sv(
            titleLabel,
            valTextField
        )
        layout(
            8,
            |-16-titleLabel-valTextField-16-|,
            8
        )
        titleLabel.font = UIFont(name: "PingFangSC-Regular", size: 17)
    }
    
}
