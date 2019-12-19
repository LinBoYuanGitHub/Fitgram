//
//  weightChart.swift
//  fitgram
//
//  Created by boyuan lin on 18/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class WeightChartViewController: UIViewController {
    var rootView:WeightChartView!
    
    override func viewDidLoad() {
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
        self.title = "体重"
    }
    
    override func loadView() {
        self.rootView = WeightChartView()
        self.view = self.rootView
    }
    
}
