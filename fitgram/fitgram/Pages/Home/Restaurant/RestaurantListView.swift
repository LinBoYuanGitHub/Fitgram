//
//  RestaurantListView.swift
//  fitgram
//
//  Created by boyuan lin on 9/1/20.
//  Copyright © 2020 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class RestaurantListView: UIView {
//    public var filterSegment = UISegmentedControl()
    public var restaurantTableView = UITableView.init()
    
    convenience init(){
        self.init(frame: .zero)
        self.backgroundColor = .white
        sv(
            restaurantTableView
        )
        layout(
            10,
            |-0-restaurantTableView-0-|,
            0
        )
        restaurantTableView.register(RestaurantCell.self, forCellReuseIdentifier: "RestaurantCell")
        restaurantTableView.separatorStyle = .none
        restaurantTableView.showsVerticalScrollIndicator = false
        restaurantTableView.tableFooterView = UIView()
    }
    
    
    
}
