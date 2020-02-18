//
//  NoZeroValueFormatter.swift
//  fitgram
//
//  Created by boyuan lin on 18/2/20.
//  Copyright © 2020 boyuan lin. All rights reserved.
//

import Charts

class NoZeroValueFormatter: NumberFormatter,IAxisValueFormatter {
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if value == 0 {
            return ""
        } else {
            return String(Int(value))
        }
    }
    
    override init() {
        super.init()
        self.numberStyle = .none
        self.zeroSymbol = ""
    }
    
   
}
