//
//  FoodDiaryDetailView.swift
//  fitgram
//
//  Created by boyuan lin on 11/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class FoodDiaryDetailView:UIView {
    
    public var foodImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
    public var recipeTable = UITableView.init(frame: CGRect(x: 0, y: UIScreen.main.bounds.width, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-UIScreen.main.bounds.width))
    
    convenience init(){
        self.init(frame:CGRect.zero)
        self.backgroundColor = .white
        foodImageView.contentMode = .scaleAspectFit
        recipeTable.register(FoodDiaryDetailViewCell.self, forCellReuseIdentifier: "FoodDiaryDetailViewCell")
        recipeTable.allowsSelection = false
        recipeTable.separatorStyle = .none
        addSubview(foodImageView)
        addSubview(recipeTable)
    }
    
}
