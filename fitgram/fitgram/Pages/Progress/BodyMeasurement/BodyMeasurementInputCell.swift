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
    public var unitLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        sv(
            titleLabel,
            valTextField,
            unitLabel
        )
        layout(
            8,
            |-16-titleLabel-valTextField.width(50%)-unitLabel-16-|,
            8
        )
        titleLabel.font = UIFont(name: "PingFangSC-Regular", size: 17)
        valTextField.textAlignment = .right
        valTextField.keyboardType = .decimalPad
        unitLabel.text = "cm"
        unitLabel.font = UIFont(name: "PingFangSC-Light", size: 13)
        unitLabel.textColor = UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1)
    }
    
}
