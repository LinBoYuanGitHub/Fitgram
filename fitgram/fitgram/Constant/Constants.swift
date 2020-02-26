//
//  Constants.swift
//  fitgram
//
//  Created by boyuan lin on 21/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import Foundation

struct Constants {
    public static let tokenKey = "token"
    public static let userIdKey = "userId"
    public static let userStatusKey = "userStatus"
    
    struct Profile {
        public static let genderStorageKey = "genderKey"
        public static let birthyearStorageKey = "birthYearKey"
        public static let heightStorageKey = "heightKey"
        public static let weightStorageKey = "weightKey"
        public static let activityLvlStorageKey = "activityLevelKey"
    }
    
    struct Dimension {
        public static let RoundButtoRradius = 15
        public static let SmallTextFont = 14
        public static let MediumTextFont = 16
        public static let LargeTextFont = 18
        public static let RegularFont = "PingFangSC-Regular"
    }
    
    struct Config {
        public static let BreakfastStartTime = 05
        public static let BreakfastEndTime = 10
        public static let LunchStartTime = 11
        public static let LunchEndTime = 15
        public static let DinnerStartTime = 16
        public static let DinnerEndTime = 24
    }
    
}
