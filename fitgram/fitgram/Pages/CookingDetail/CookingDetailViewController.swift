//
//  CookingDetailViewController.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 8/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import SwiftGRPC

class CookingDetailViewController: UIViewController {
    let mOptions = ViewPagerOptions()
    var stepList = [StepModel]()
    var viewPager:ViewPager? //have to set the viewpager as a global virable
    //dismiss button
    var closeBtn = UIButton(frame: CGRect(x: 0, y: 42, width: 64, height: 64))
    var recipeId = 0
    var mealType:Apisvr_MealType = .breakfast
    var foodImage = UIImage()
    
    override func loadView() {
        let newView = UIView()
        newView.backgroundColor = UIColor.white
        view = newView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPageOption()
        //set up close btn
        closeBtn.setImage(UIImage(named: "closeIcon_white"), for: .normal)
        closeBtn.addTarget(self, action: #selector(onBackPressed), for: .touchUpInside)
        self.view.bringSubviewToFront(closeBtn)
        self.view.addSubview(closeBtn)
    }
    
    func initPageOption(){
        mOptions.tabType = .basic
        mOptions.distribution = .segmented
        mOptions.tabViewTextDefaultColor = UIColor.white
        mOptions.tabViewTextHighlightColor = UIColor.white
        mOptions.tabViewBackgroundDefaultColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        mOptions.tabViewBackgroundHighlightColor =  UIColor(red: 33/255, green: 43/255, blue: 54/255, alpha: 1)
        mOptions.isTabIndicatorAvailable = false
        mOptions.tabViewHeight = 30
        //set up page view
        viewPager = ViewPager(viewController: self)
        viewPager?.setOptions(options: mOptions)
        viewPager?.setDataSource(dataSource: self)
        viewPager?.setDelegate(delegate: self)
        viewPager?.build()
    }
    
    @objc func onBackPressed(){
        self.parent!.dismiss(animated: true, completion: nil)
    }

    
}

extension CookingDetailViewController: ViewPagerDataSource, ViewPagerDelegate{
    
    func numberOfPages() -> Int {
        return stepList.count + 1
    }
    
    func viewControllerAtPosition(position: Int) -> UIViewController {
        let pageController  = CookingStepViewController()
        if position == stepList.count {
            let stepText = "真棒！您又向健身目标靠近了一步，开始打卡记录您的饮食吧。"
            let stepImageUrl = stepList[0].stepImageUrl
            pageController.isLast  = true
            pageController.imageUrl = stepImageUrl
            pageController.stepText = stepText
            pageController.checkBtn.addTarget(self, action: #selector(saveToFoodDiary), for: .touchUpInside)
        } else {
            let stepText = stepList[position].stepText
            let stepImageUrl = stepList[position].stepImageUrl
            pageController.imageUrl = stepImageUrl
            pageController.stepText = stepText
        }
        return pageController
    }
    
    
    @objc func saveToFoodDiary() {
        if LoginDataManager.shared.getUserStatus() == .unknownUserType {
            let targetVC = LoginViewController()
            self.navigationController?.pushViewController(targetVC, animated: true)
        } else {
            do{
                var req = Apisvr_GetFoodLogDetailReq()
                var foodTag = Apisvr_FoodTag()
                foodTag.foodID = Int32(recipeId)
                req.foodTags = [foodTag]
                guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                    return
                }
                let metaData = try Metadata(["authorization": "Token " + token])
                try FoodDiaryDataManager.shared.client.getFoodLogDetail(req, metadata: metaData) { (resp, result) in
                    if result.statusCode == .ok {
                        DispatchQueue.main.async {
                            let targetVC = FoodDiaryDetailViewController()
                            targetVC.mealType = self.mealType //TODO modify latter
                            targetVC.foodImage = self.foodImage
                            targetVC.foodDiaryList = resp!.foodLogs
                            targetVC.mealLogList = FoodDiaryDataManager.shared.convertFoodLogToInfo(foodDiaryList:  resp!.foodLogs)
                            self.navigationController?.pushViewController(targetVC, animated: true)
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    
    func tabsForPages() -> [ViewPagerTab] {
        var tabs = [ViewPagerTab]()
        for index in 0...(stepList.count) { // include last page
            var tab:ViewPagerTab? = nil
            if (index == stepList.count){
                tab = ViewPagerTab(title: "完成", image: UIImage(named: "tinyLike_white"))
            } else {
                tab = ViewPagerTab(title: "0"+String(index+1), image: nil)
            }
            tabs.append(tab!)
        }
        return tabs
    }
    
    func startViewPagerAtIndex() -> Int {
        return 0
    }
    
    func willMoveToControllerAtIndex(index: Int) {
        
    }
    
    func didMoveToControllerAtIndex(index: Int) {
        
    }
    
    
}
