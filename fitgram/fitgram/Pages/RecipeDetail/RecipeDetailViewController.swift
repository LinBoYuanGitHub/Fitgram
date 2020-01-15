//
//  ReceipeDetailViewController.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 11/9/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Kingfisher
import AVKit
import SwiftGRPC

class RecipeDetailViewController:UIViewController{
    var rootView:RecipeDetailView!
    let vc = AVPlayerViewController()
    //data part
    var recipe = RecipeModel()
    var mealType:Apisvr_MealType = .breakfast
    
    override func loadView() {
        rootView = RecipeDetailView()
        rootView.recipeDetailTable.delegate = self
        rootView.recipeDetailTable.dataSource = self
        rootView.recipeDetailTable.allowsSelection = false
        view = rootView
    }
    
    override func viewDidLoad() {
        //        self.rootView.customBackButton.addTarget(self, action: #selector(onBackPressed), for: .touchUpInside)
        self.rootView.playButton.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        self.rootView.headerView.startCookBtn.addTarget(self, action: #selector(startCook), for: .touchUpInside)
        self.rootView.footerView.checkButton.addTarget(self, action: #selector(saveToFoodDiary), for: .touchUpInside)
        self.rootView.recipeTitle.text = recipe.recipeTitle
        let imageUrl = URL(string: recipe.videoCoverImageUrl)
        self.rootView.headerImage.kf.setImage(with: imageUrl)
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
        //retrieve more recipe data
        retrieveRecipeDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.barStyle = .black
        self.rootView.naviCoverView.alpha = 0
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "backbutton_black"), style: .plain, target: self, action: #selector(onBackPressed))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //dismiss the floating btn when exit
        DispatchQueue.main.async {
            self.rootView.headerView.dismissStartCookBtn()
        }
    }
    
    
    @objc func onBackPressed(){
        self.navigationController?.popViewController(animated: true)
//        self.rootView.headerView.dismissStartCookBtn()
    }
    
    @objc func playVideo(){
        let videoUrl = URL(fileURLWithPath: recipe.recipeVideoUrl)
        //        let videoUrl = URL(fileURLWithPath: "https://i4.chuimg.com/e655f0aeb0e311e8960402420a000135_720w_720h.mp4")
        let playerItem = AVPlayerItem(url: videoUrl)
        let player = AVPlayer(playerItem: playerItem)
        //        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEndTime), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        vc.player = player
        self.present(vc, animated: true) {
            self.vc.player?.play()
        }
    }
    
    @objc func playerItemDidReachEndTime(notification: NSNotification){
        vc.player?.seek(to: .zero)
        vc.player?.play()
    }
    
    @objc func startCook(){
        let cookingVC = CookingDetailViewController()
        cookingVC.stepList = recipe.stepList
        cookingVC.recipeId = recipe.recipeId
        cookingVC.mealType = self.mealType
        cookingVC.foodImage = self.rootView.headerImage.image!
        let naviVC = UINavigationController()
        naviVC.viewControllers = [cookingVC]
        self.present(naviVC, animated: true)
        self.rootView.headerView.dismissStartCookBtn()
    }
    
    func convertFoodLogToInfo(foodDiaryList:[Apisvr_FoodLog]) -> [Apisvr_FoodLogInfo]{
        var foodLogInfos = [Apisvr_FoodLogInfo]()
        for index in 0...foodDiaryList.count - 1 {
            var foodInfo = Apisvr_FoodLogInfo()
            //set up initial value for logs
            foodInfo.amount = 1
            foodInfo.foodID = foodDiaryList[index].foodID
            foodInfo.selectedUnitID = foodDiaryList[index].selectedUnitID
            foodInfo.tagX = 0
            foodInfo.tagY = 0
            foodLogInfos.append(foodInfo)
        }
        return foodLogInfos
    }
    
    
    func retrieveRecipeDetail(){
//        self.rootView.recipeDetailTable.isScrollEnabled = false
        do{
            try  RecommendationDataManager.shared.retrieveRecipeDetail(recipeId: recipe.recipeId) { (recipe) in
                self.recipe = recipe
                DispatchQueue.main.async {
                    self.rootView.headerView.setData(ingredientDataList:  recipe.ingredientList, nutritionData: recipe.nutrientData, duration: recipe.recipeCookingDuration , difficulity: recipe.difficulity)
                    self.rootView.recipeDetailTable.reloadData()
                    self.rootView.headerView.createStartCookButton()
                }
            }
        } catch {
            print(error)
        }
        
    }
    
   @objc func saveToFoodDiary(){
        if LoginDataManager.shared.getUserStatus() == .unknownUserType {
            let targetVC = LoginViewController()
            self.navigationController?.pushViewController(targetVC, animated: true)
        } else {
            do{
                var req = Apisvr_GetFoodLogDetailReq()
                var foodTag = Apisvr_FoodTag()
                foodTag.foodID = Int32(recipe.recipeId)
                req.foodTags = [foodTag]
                guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                    return
                }
                let metaData = try Metadata(["authorization": "Token " + token])
                try FoodDiaryDataManager.shared.client.getFoodLogDetail(req, metadata: metaData) { (resp, result) in
                    if result.statusCode == .ok {
                        DispatchQueue.main.async {
                            let targetVC = FoodDiaryDetailViewController()
                            targetVC.foodImage = self.rootView.headerImage.image!
                            targetVC.foodDiaryList = resp!.foodLogs
                            targetVC.mealLogList = FoodDiaryDataManager.shared.convertFoodLogToInfo(foodDiaryList: resp!.foodLogs)
                            targetVC.mealType = self.mealType//TODO modify latter
                            self.navigationController?.pushViewController(targetVC, animated: true)
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
}

extension RecipeDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return recipe.stepList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = "步骤 "+String(section + 1) + "/" + String(recipe.stepList.count)
        return title
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.rootView.recipeDetailTable.dequeueReusableCell(withIdentifier: "RecipeDetailCell") as? RecipeDetailTableCell else {
            return UITableViewCell()
        }
        cell.recipeStepLabel.text = recipe.stepList[indexPath.section].stepText
//        cell.recipeStepImage.kf.setImage(with: URL(string: recipe.stepList[indexPath.section].stepImageUrl))
        cell.recipeStepImage.kf.setImage(with: URL(string: "https://picsum.photos/500/500"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let numOfLines = recipe.stepList[indexPath.section].stepText.count/20 + 1
        return CGFloat(Int(UIScreen.main.bounds.width) + numOfLines * 30 + 16)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y =  UIScreen.main.bounds.width - (scrollView.contentOffset.y)
        let height = min(max(y, 60),  UIScreen.main.bounds.size.height)
        rootView.headerImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        //change status bar style when scolling over a certain distance
        if (y > 250) {
            self.navigationController?.navigationBar.barStyle = .black
        } else if (self.navigationController?.navigationBar.barStyle == .blackOpaque){
            self.navigationController?.navigationBar.barStyle = .default
        }
        //change the navigation bar background alpha when scrolling over a certain distance
        if (y < 250 && y > 88) {
            self.rootView.naviCoverView.alpha = (250-y)/162 //gardient alpha changing
            //            self.rootView.customBackButton.tintColor = .black
            self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: (y-88)/162, green: (y-88)/162, blue: (y-88)/162, alpha: 1)
            //            self.navigationItem.leftBarButtonItem?.customView.alpha = (y-88)/162
        } else if(y <= 88) {
            self.rootView.naviCoverView.alpha = 1 //after navi bar fix on top
        } else {
            self.rootView.naviCoverView.alpha = 0
        }
        //play button visibility
        if(y>488 && y<538) {
            self.rootView.playButton.alpha = (538-y)/50
        } else if (y<=488){
            self.rootView.playButton.alpha = 1
        } else {
            self.rootView.playButton.alpha = 0
        }
        //start cook btn visibility
        if (y <= 100 && y >= UIScreen.main.bounds.height + 500 - self.rootView.recipeDetailTable.contentSize.height) {
            self.rootView.headerView.showStartCookBtn()
        } else if (y > 100 || y < UIScreen.main.bounds.height + 500 - self.rootView.recipeDetailTable.contentSize.height) {
            self.rootView.headerView.dismissStartCookBtn()
        }
    }
}

