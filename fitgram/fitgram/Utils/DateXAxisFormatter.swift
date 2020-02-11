//
//  DateXAxisFormatter.swift
//  fitgram
//
//  Created by boyuan lin on 4/2/20.
//  Copyright © 2020 boyuan lin. All rights reserved.
//

import Foundation
import Charts

@objc(BarChartFormatter)
public class DateXAxisFormatter: NSObject, IAxisValueFormatter{

    public func stringForValue(_ date: Double, axis: AxisBase?) -> String {
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd/MM"
        dayFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let day = dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(date)))
        return day
    }
}
