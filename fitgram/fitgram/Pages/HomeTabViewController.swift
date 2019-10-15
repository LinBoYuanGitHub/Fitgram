//
//  HomeTabViewController.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 30/9/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class HomeTabViewController: UITabBarController {
    
    override func viewDidLoad() {
        let recommendHomeVC = RecommendHomeViewController()
        let foodDiaryVC = FoodDiaryViewController()
        let progressVC = ProgressViewController()
        let moreVC = MoreViewController()
        recommendHomeVC.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
        foodDiaryVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        progressVC.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 2)
        moreVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 3)
        self.viewControllers = [recommendHomeVC, foodDiaryVC, progressVC, moreVC]
        self.selectedViewController = recommendHomeVC
        self.selectedIndex = 0
    }
    
    
    
    
    
    
}
