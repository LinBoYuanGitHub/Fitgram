//
//  HomeView.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 18/9/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class RecommendHomeView:UIView {
    let recommendationMainTableView = UITableView.init()
    let dateTab = UISegmentedControl(frame: CGRect.zero)
    //grocery list btn
    let toGroceryListButton = UIButton(frame: CGRect(x: 32, y: 0, width: UIScreen.main.bounds.width - 64, height: 45))
    let footerContainer = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
    
    convenience init() {
        self.init(frame: CGRect.zero)
        sv(
            dateTab,
            recommendationMainTableView
        );
        layout(
            20,
            |-20-dateTab-20-| ~ 40,
            8,
            |recommendationMainTableView|,
            0
        )
        self.backgroundColor = .white
        //UISegmented control
        dateTab.centerHorizontally()
        dateTab.insertSegment(withTitle: "今天", at: 0, animated: false)
        dateTab.insertSegment(withTitle: "明天", at: 1, animated: false)
        dateTab.selectedSegmentIndex = 0
        dateTab.tintColor = .black
        dateTab.backgroundColor = .white
        //main tableview setting
        recommendationMainTableView.register(RecommendHomeTableCell.self, forCellReuseIdentifier: "RecommendHomeTableCell")
        recommendationMainTableView.backgroundColor = .clear
        recommendationMainTableView.allowsSelection = false
//        if let layout = recommendationCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.scrollDirection = .horizontal
//        }
        toGroceryListButton.backgroundColor = .black
        toGroceryListButton.layer.cornerRadius = 20
        toGroceryListButton.setTitle("食材清单", for: .normal)
        footerContainer.addSubview(toGroceryListButton)
        recommendationMainTableView.tableFooterView = footerContainer
        
    }
    
    

}
