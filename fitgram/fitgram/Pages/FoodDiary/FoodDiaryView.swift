//
//  FoodDiaryView.swift
//  fitgram
//
//  Created by boyuan lin on 4/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class FoodDiaryView: UIView{
    let foodDiaryTableView = UITableView.init()
//    let nutrientPanel = NutritionPanelView()
    
    convenience init(){
        self.init(frame: CGRect.zero)
        self.backgroundColor = .white
        foodDiaryTableView.register(FoodDiaryMainCell.self, forCellReuseIdentifier: "FoodDiaryMainCell")
        foodDiaryTableView.allowsSelection = false
        foodDiaryTableView.showsVerticalScrollIndicator = false
//        foodDiaryTableView.tableHeaderView = nutrientPanel
        sv(
            foodDiaryTableView
        )
        layout(
            0,
            |-foodDiaryTableView-|,
            0
        )
    }
    
    
}



