//
//  WeightChartView.swift
//  fitgram
//
//  Created by boyuan lin on 18/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Charts
import Stevia

class WeightChartView: UIView {
    public let dateTab = UISegmentedControl(frame: CGRect.zero)
    public var weightChart = LineChartView()
    public var weightRecordBtn = UIButton()
    
    public var onRecordWeightBtnPressedEvent: () -> Void = { }
    
    convenience init(){
        self.init(frame:CGRect.zero)
        self.backgroundColor = .white
        sv(
            dateTab,
            weightChart,
            weightRecordBtn
        )
        layout(
            20,
            |-16--dateTab-16-|,
            20,
            |-16-weightChart-16-| ~ 230,
            20,
            |-weightRecordBtn-|
        )
        dateTab.centerHorizontally()
        dateTab.insertSegment(withTitle: "年", at: 0, animated: false)
        dateTab.insertSegment(withTitle: "月", at: 0, animated: false)
        dateTab.insertSegment(withTitle: "周", at: 0, animated: false)
        dateTab.insertSegment(withTitle: "日", at: 0, animated: false)
        dateTab.selectedSegmentIndex = 0
        dateTab.tintColor = .black
        dateTab.backgroundColor = .white
        weightRecordBtn.setTitle("记录体重", for: .normal)
        weightRecordBtn.width(125)
        weightRecordBtn.centerHorizontally()
        weightRecordBtn.backgroundColor = .black
        weightRecordBtn.layer.cornerRadius = 15
        weightRecordBtn.layer.masksToBounds = true
        weightRecordBtn.addTarget(self, action: #selector(onRecordWeightBtnPressed), for: .touchUpInside)
    }
    
    @objc func onRecordWeightBtnPressed(){
        self.onRecordWeightBtnPressedEvent()
    }
    
    
    
    
    
    
}
