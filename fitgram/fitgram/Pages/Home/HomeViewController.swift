//
//  HomeViewController.swift
//  fitgram
//
//  Created by boyuan lin on 14/1/20.
//  Copyright © 2020 boyuan lin. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    var segmentControl: UISegmentedControl!
    var contentView: UIView!
    var currentVC:UIViewController!
    let firstVC = RecommendHomeViewController()
    let secondVC = RestaurantListViewController()
    
    override func viewDidLoad() {
        segmentControl = UISegmentedControl(frame: CGRect(x: 16, y: 60, width: UIScreen.main.bounds.width - 32, height: 40))
        contentView = UIView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100))
        self.view.backgroundColor = .white
        self.view.addSubview(segmentControl)
        self.view.addSubview(contentView)
        //config view
        segmentControl.insertSegment(withTitle: "Fitness Recipes", at: 0, animated: false)
        segmentControl.insertSegment(withTitle: "Restaurants", at: 1, animated: false)
        segmentControl.addTarget(self, action: #selector(onSwitchTab), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black,
                                                     NSAttributedString.Key.font: UIFont(name: "PingFangSC-Medium", size: 14)!], for: .normal)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black,
                                                     NSAttributedString.Key.font: UIFont(name: "PingFangSC-Medium", size: 14)!], for: .selected)
        
        currentVC = firstVC
        currentVC.view.frame = self.contentView.bounds
        self.addChild(currentVC)
        self.contentView.addSubview(currentVC.view)
        currentVC.didMove(toParent: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func onSwitchTab(sender:UISegmentedControl) {
        currentVC.view.removeFromSuperview()
        currentVC.removeFromParent()
        let index = sender.selectedSegmentIndex
        switch index{
        case 0:
            currentVC = firstVC
        case 1:
            currentVC = secondVC
        default:break
        }
        currentVC.view.frame = self.contentView.bounds
        self.addChild(currentVC)
        currentVC.didMove(toParent: self)
        self.contentView.addSubview(currentVC.view)
    }
}
