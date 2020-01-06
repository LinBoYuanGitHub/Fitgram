//
//  HomeTabViewController.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 30/9/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class HomeTabViewController: UITabBarController {
    let recommendHomeVC = RecommendHomeViewController()
    let foodDiaryVC = FoodDiaryViewController()
    let progressVC = ProgressViewController()
    let moreVC = MoreViewController()
    let profileVC = ProfileViewController()
    
    override func viewDidLoad() {
        UITabBar.appearance().tintColor = UIColor(red: 255/255, green: 189/255, blue: 0, alpha: 1)
        recommendHomeVC.tabBarItem =  UITabBarItem(title: "", image: UIImage(named: "appBottomHome_unselected"), selectedImage: UIImage(named: "appBottomHome_selected"))
        foodDiaryVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "appBottomDiary_unselected"), selectedImage: UIImage(named: "appBottomDiary_selected"))
        progressVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "appBottomProgress_unselected"), selectedImage: UIImage(named: "appBottomProgress_selected"))
        profileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "appBottomProfile_unselected"), selectedImage: UIImage(named: "appBottomProfile_selected"))
        self.viewControllers = [recommendHomeVC, foodDiaryVC, progressVC, profileVC]
        self.selectedViewController = recommendHomeVC
        self.selectedIndex = 0
        self.delegate = self
    }
    
    func navigateToLoginPage(){
        let targetVC = LoginViewController()
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    
}

extension HomeTabViewController: UITabBarControllerDelegate {
    
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        let userType = Apisvr_UserType(rawValue: UserDefaults.standard.integer(forKey: Constants.userStatusKey))
//        if viewController != recommendHomeVC && userType == .unknownUserType {
//            navigateToLoginPage()
//            tabBarController.selectedIndex = 0
//        }
//    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let userType = Apisvr_UserType(rawValue: UserDefaults.standard.integer(forKey: Constants.userStatusKey))
        if viewController != recommendHomeVC && userType == .unknownUserType {
            navigateToLoginPage()
            return false
        }
        //navigation bar hidden config
        if viewController == foodDiaryVC {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
        return true
    }
}

