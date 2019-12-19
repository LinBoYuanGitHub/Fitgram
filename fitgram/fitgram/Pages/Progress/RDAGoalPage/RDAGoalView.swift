//
//  RDAGoalView.swift
//  fitgram
//
//  Created by boyuan lin on 18/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class RDAGoalView: UIView {
    
    public var RDATableView = UITableView.init()
    
    
    convenience init() {
        self.init(frame: CGRect.zero)
        sv(
            RDATableView
        )
        layout(
            0,
            |-RDATableView-|
        )
        RDATableView.register(RDAGoalCell.self, forCellReuseIdentifier: "RDAGoalCell")
    }
    
    
}
