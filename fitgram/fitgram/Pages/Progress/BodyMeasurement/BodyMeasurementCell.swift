//
//  BodyMeasurementCell.swift
//  fitgram
//
//  Created by boyuan lin on 20/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Charts
import Stevia


class BodyMeasurementCell:UITableViewCell {
    public var bodyMeasurementTitle = UILabel()
    public var bodyWeightChart = LineChartView()
    public var recordWeightBtn = UIButton()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        sv(
            bodyMeasurementTitle,
            bodyWeightChart,
            recordWeightBtn
        )
        layout(
            0,
            |-16-bodyMeasurementTitle-16-|,
            |-16-bodyWeightChart-16-| ~ 200,
            |-recordWeightBtn-| ~ 35,
            0
        )
        bodyMeasurementTitle.font = UIFont(name: "PingFangSC-semibold", size: 14)
        bodyWeightChart.xAxis.labelPosition = .bottom
        recordWeightBtn.centerHorizontally()
        recordWeightBtn.width(125)
        recordWeightBtn.setTitle("记录", for: .normal)
        recordWeightBtn.backgroundColor = .black
        recordWeightBtn.setTitleColor(.white, for: .normal)
        recordWeightBtn.layer.cornerRadius = 15
        recordWeightBtn.layer.masksToBounds = true
    }
}
