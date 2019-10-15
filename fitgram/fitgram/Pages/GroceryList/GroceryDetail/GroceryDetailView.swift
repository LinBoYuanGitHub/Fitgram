//
//  GroceryDetailView.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 11/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class GroceryDetailView:UIView {
    public var ingredientTableView = UITableView.init()
    
    convenience init(){
        self.init(frame: CGRect.zero)
        self.backgroundColor = . white
        ingredientTableView.register(GroceryIngredientCell.self, forCellReuseIdentifier: "GroceryIngredientCell")
        ingredientTableView.allowsSelection = false
        sv(
            ingredientTableView
        )
        layout(
            0,
            |ingredientTableView|,
            0
        )
        
    }
    
}
