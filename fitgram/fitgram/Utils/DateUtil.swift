//
//  DateUtil.swift
//  fitgram
//
//  Created by boyuan lin on 16/1/20.
//  Copyright © 2020 boyuan lin. All rights reserved.
//

import Foundation

class DateUtil {
    
    static func CNDateFormatter(date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        return dateFormatter.string(from: date)
    }
    
    static func EnDateFormatter(date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }

}
