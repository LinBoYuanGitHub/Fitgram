//
//  GroceryListView.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 11/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class GroceryListView: UIView {
    public let groceryTableView = UITableView.init()
    //bottom ingredient view
    public let ingredientBottomView = UIView()
    public let seperatorLine = UIView()
    public let allIngredientBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 47))
    public let recipeCounterLabel = UILabel(frame: CGRect(x:0, y: 0, width: 37, height: 47))
    
    convenience init() {
        self.init(frame: CGRect.zero)
        self.backgroundColor = . white
        groceryTableView.register(GroceryTableCell.self, forCellReuseIdentifier: "GroceryTableCell")
//        groceryTableView.allowsSelection = false
        groceryTableView.separatorStyle = .none
        var bottomPadding = 0
        if #available(iOS 11.0, *) {
            bottomPadding = Int((UIApplication.shared.keyWindow?.safeAreaInsets.bottom)!)
        }
        sv(
            groceryTableView,
            seperatorLine,
            ingredientBottomView
        );
        layout(
            8,
            |groceryTableView|,
            |seperatorLine| ~ 1,
            |ingredientBottomView| ~ 47,
            bottomPadding
        )
        seperatorLine.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        allIngredientBtn.center = CGPoint(x: UIScreen.main.bounds.width/2, y: 24)
        allIngredientBtn.setTitleColor(UIColor(red:0.99, green:0.78, blue:0.18, alpha:1.0), for: .normal)
        allIngredientBtn.setTitleColor(UIColor(red:0.53, green:0.53, blue:0.53, alpha:1.0), for: .disabled)
        allIngredientBtn.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 17)
        allIngredientBtn.setImage(UIImage(named: "ingredientBox_yellow"), for: .normal)
        allIngredientBtn.setImage(UIImage(named: "ingredientBox_gray"), for: .disabled)
        allIngredientBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        recipeCounterLabel.center = CGPoint(x: UIScreen.main.bounds.width - 55, y: 24)
        allIngredientBtn.setTitle("全部食材", for: .normal)
        recipeCounterLabel.font = UIFont(name: "PingFangSC-Regular", size: 14)
        recipeCounterLabel.text = "食谱"
        recipeCounterLabel.textColor = UIColor.gray
        ingredientBottomView.addSubview(allIngredientBtn)
        ingredientBottomView.addSubview(recipeCounterLabel)
    }
    
    
    
    
    
}
