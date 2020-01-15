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
    public var recipeTable = UITableView.init(frame: CGRect(x: 0, y: UIScreen.main.bounds.width - 50, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-UIScreen.main.bounds.width))
    public var footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
    public var deleteBtn = UIButton(frame: CGRect(x: 16, y: 10, width: UIScreen.main.bounds.width - 50, height: 40))
    
    convenience init() {
        self.init(frame:CGRect.zero)
        self.backgroundColor = .white
        foodImageView.contentMode = .scaleAspectFit
        recipeTable.register(FoodDiaryDetailViewCell.self, forCellReuseIdentifier: "FoodDiaryDetailViewCell")
        recipeTable.allowsSelection = false
        recipeTable.separatorStyle = .none
        addSubview(foodImageView)
        addSubview(recipeTable)
    }
    
    func addFooterDeleteView() {
        //add footer view
        deleteBtn.frame.size = CGSize(width: UIScreen.main.bounds.width - 32, height: 40)
        deleteBtn.backgroundColor = UIColor(red: 180/255, green: 21/255, blue: 28/255, alpha: 1)
        deleteBtn.setTitle("删除", for: .normal)
        deleteBtn.layer.cornerRadius = 10
        deleteBtn.layer.masksToBounds = true
        footerView.addSubview(deleteBtn)
        recipeTable.tableFooterView = footerView
    }
    
}
