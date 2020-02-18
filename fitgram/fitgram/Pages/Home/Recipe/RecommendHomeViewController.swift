//
//  HomeViewController.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 18/9/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import AVKit
import Stevia
import SwiftGRPC

class RecommendHomeViewController:UIViewController{
    
    let vc = AVPlayerViewController()
    var rootView:RecommendHomeView! = nil
    
    var recommendationList = [RecommendationModel]()
    let mealList = ["Breakfast","Lunch","Dinner"]

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleRefresh(_:)),
                                 for: .valueChanged)
        refreshControl.tintColor = UIColor(red: 238/255, green: 194/255, blue: 0, alpha: 1)
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.retrieveRecommendationList()
    }
    
    func initMockUpData() {
        for index in 0...2 {
            var recModel = RecommendationModel()
            var recipeList = [RecipeModel]()
            let mealTitle = mealList[index]
            for _ in 1...5 {
                var recipe = RecipeModel()
                recipe.recipeTitle = "酸奶南瓜碗"
                recipe.recipeCalorie = "345千卡"
                recipe.recipeCookingDuration = 10
                recipe.videoCoverImageUrl = "https://i2.chuimg.com/ac6aa49e873d4aaa926e89d42c8a022b_1920w_1920h.jpg?imageView2/2/w/300/interlace/1/q/90"
                recipe.recipeVideoUrl = "https://i4.chuimg.com/e655f0aeb0e311e8960402420a000135_720w_720h.mp4"
                //add ingredient list testing data
                recipe.ingredientList.append(IngredientModel(ingredientName: "虾仁", portionDesc: "50克",isChecked: false))
                recipe.ingredientList.append(IngredientModel(ingredientName: "鸡蛋", portionDesc: "1个",isChecked: false))
                recipe.ingredientList.append(IngredientModel(ingredientName: "盐", portionDesc: "适量",isChecked: false))
                recipe.ingredientList.append(IngredientModel(ingredientName: "料酒", portionDesc: "1勺",isChecked: false))
                recipe.ingredientList.append(IngredientModel(ingredientName: "白胡椒粉", portionDesc: "适量",isChecked: false))
                recipe.ingredientList.append(IngredientModel(ingredientName: "牛奶 ", portionDesc: "2勺",isChecked: false))
                //add steplist mock up data
                recipe.stepList.append(StepModel(stepText: "虾仁+料酒+白胡椒碎，腌制5-10分钟", stepImageUrl: recipe.videoCoverImageUrl ))
                recipe.stepList.append(StepModel(stepText: "鸡蛋+盐+白胡椒碎+牛奶，拌匀。", stepImageUrl: recipe.videoCoverImageUrl ))
                recipe.stepList.append(StepModel(stepText: "翻炒，翻炒，这个半流动的状态怎么这么好看。", stepImageUrl: recipe.videoCoverImageUrl ))
                recipeList.append(recipe)
            }
            recModel.recipeList = recipeList
            recModel.mealTitle = mealTitle
            recommendationList.append(recModel)
        }
    }
    
    func retrieveRecommendationList(){
        RecommendationDataManager.shared.retrieveRecommendationList(dateStr: "") {recommendationList in
            print("request finish")
            self.recommendationList = recommendationList
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.refreshControl.endRefreshing()
                let indexSet = IndexSet([0])
                self.rootView.recommendationMainTableView.reloadSections(indexSet, with: .automatic)
            })
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.initMockUpData()
        self.retrieveRecommendationList()
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
        self.rootView.toGroceryListButton.addTarget(self, action: #selector(naviToGroceryListView), for: .touchUpInside)
        self.rootView.recommendationMainTableView.addSubview(self.refreshControl)
    }
    
    @objc func naviToGroceryListView(){
        let targetVC = GroceryListViewController()
        targetVC.groceryList = self.getSelectedRecipeGroceryList()
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    func getSelectedRecipeGroceryList() -> [GroceryItem]{
        var groceryList = [GroceryItem]()
        for index in 0...recommendationList.count-1 {
            let recipe = self.recommendationList[index].recipeList[recommendationList[index].selected_Pos]
            var groceryItem = GroceryItem()
            groceryItem.dishImageUrl = recipe.videoCoverImageUrl
            groceryItem.dishTitle = recipe.recipeTitle
            groceryItem.isChecked = true
            groceryItem.groceryItemId = recipe.recipeId
            groceryList.append(groceryItem)
        }
        return groceryList
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.alpha = 1
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 0.1)
        self.navigationController?.navigationBar.layer.shadowOpacity = 1.0
        self.navigationController?.navigationBar.layer.shadowRadius = 0.0
    }
    
    override func loadView() {
        rootView = RecommendHomeView()
        rootView.recommendationMainTableView.delegate = self
        rootView.recommendationMainTableView.dataSource = self
        view = rootView
//        rootView.onDateSegmentSwitchAction = { index in
//            //index for switch today and tomorrow
//            self.retrieveRecommendationList()
//        }
    }
    
    func playVideo(videoUrl: URL, contentView:UIView) {
        let playerItem = AVPlayerItem(url: videoUrl)
        let player = AVPlayer(playerItem: playerItem)
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEndTime), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        vc.player = player
        vc.view.frame = contentView.bounds
        vc.showsPlaybackControls = false
        self.addChild(vc)
        contentView.addSubview(vc.view)
        vc.player?.play()
    }
    
    /** loop through the original video */
    @objc func playerItemDidReachEndTime(notification: NSNotification) {
        vc.player?.seek(to: .zero)
        vc.player?.play()
    }
    
    func onFoodFav(mealIndex:Int,recipeIndex:Int) {
        let foodId = recommendationList[mealIndex].recipeList[recipeIndex].recipeId
        var req = Apisvr_AddFavouriteItemReq()
        req.itemID = Int32(foodId)
        guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
            return
        }
        let mealIndexPath = IndexPath(row: mealIndex, section: 0)
        let mealCell = self.rootView.recommendationMainTableView.cellForRow(at: mealIndexPath) as! RecommendHomeTableCell
        let recipeIndexPath = IndexPath(row: recipeIndex, section: 0)
        let recipeCell = mealCell.recommendationCollectionView.cellForItem(at: recipeIndexPath) as! RecommendHomeCollectionCell
        do{
            let metaData = try Metadata(["authorization": "Token " + token])
            recipeCell.likeButton.isEnabled = false
            try ProfileDataManager.shared.client.addFavouriteItem(req, metadata: metaData) { (resp, result) in
                DispatchQueue.main.async {
                    recipeCell.likeButton.isEnabled = true
                    if result.statusCode == .ok {
                        self.recommendationList[mealIndex].recipeList[recipeIndex].isLike = true
                        recipeCell.likeButton.isSelected = true
                    }
                }
                
            }
        } catch {
            recipeCell.likeButton.isEnabled = true
            print(error)
        }
        
    }
    
    func onFoodUnFav(mealIndex:Int,recipeIndex:Int) {
        let foodId = recommendationList[mealIndex].recipeList[recipeIndex].recipeId
        var req = Apisvr_RemoveFavouriteItemReq()
        req.itemID = Int32(foodId)
        guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
            return
        }
        let mealIndexPath = IndexPath(row: mealIndex, section: 0)
        let mealCell = self.rootView.recommendationMainTableView.cellForRow(at: mealIndexPath) as! RecommendHomeTableCell
        let recipeIndexPath = IndexPath(row: recipeIndex, section: 0)
        let recipeCell = mealCell.recommendationCollectionView.cellForItem(at: recipeIndexPath) as! RecommendHomeCollectionCell
        do{
            let metaData = try Metadata(["authorization": "Token " + token])
            recipeCell.likeButton.isEnabled = false
            try ProfileDataManager.shared.client.removeFavouriteItem(req, metadata: metaData) { (resp, result) in
                DispatchQueue.main.async {
                    recipeCell.likeButton.isEnabled = true
                    if result.statusCode == .ok {
                        self.recommendationList[mealIndex].recipeList[recipeIndex].isLike = false
                        recipeCell.likeButton.isSelected = false
                    }
                }
            }
        } catch {
            recipeCell.likeButton.isEnabled = true
            print(error)
        }
        
    }

    
}

extension RecommendHomeViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommendationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.rootView.recommendationMainTableView.dequeueReusableCell(withIdentifier: "RecommendHomeTableCell") as? RecommendHomeTableCell else {
            return UITableViewCell()
        }
        cell.mealText.text = recommendationList[indexPath.row].mealTitle
        cell.setRecommendationList(dishList: recommendationList[indexPath.row].recipeList)
        cell.didSelectAction = {recipe,columnIndex in
            self.displayTransistScaleAnimation(rowIndex: indexPath.row, columnIndex: columnIndex,recipe: recipe)
        }
        cell.didMoveAction = { movePositionIndex in
            self.recommendationList[indexPath.row].selected_Pos = movePositionIndex
        }
        cell.didCollectionCheck = { collectionIndex in
            let isLike = self.recommendationList[indexPath.row].recipeList[collectionIndex].isLike
            if isLike {
                self.onFoodUnFav(mealIndex: indexPath.row, recipeIndex: collectionIndex)
            } else {
                self.onFoodFav(mealIndex: indexPath.row, recipeIndex: collectionIndex)
            }
        }
        cell.didCheckAction = { index in
            let recipe = self.recommendationList[indexPath.row].recipeList[index]
            var mealType = Apisvr_MealType.unknownMealType
            switch indexPath.row{
            case 0: mealType = .breakfast
            case 1: mealType = .lunch
            case 2: mealType = .dinner
            default: break
            }
            self.requestFoodDetail(recipe: recipe , mealType: mealType)
        }
        return cell
    }
    
    func requestFoodDetail(recipe:RecipeModel , mealType: Apisvr_MealType){
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
                            targetVC.imgUrl = recipe.videoCoverImageUrl
                            targetVC.foodDiaryList = resp!.foodLogs
                            targetVC.mealLogList = FoodDiaryDataManager.shared.convertFoodLogToInfo(foodDiaryList: resp!.foodLogs)
                            targetVC.mealType = mealType
                            self.navigationController?.pushViewController(targetVC, animated: true)
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    
    func displayTransistScaleAnimation(rowIndex:Int,columnIndex:Int,recipe:RecipeModel){
        let tableViewIndexPath = IndexPath(item: rowIndex, section: 0)
        let collectionViewIndexPath = IndexPath(item: columnIndex, section: 0)
        guard let targetTableCell = self.rootView.recommendationMainTableView.cellForRow(at: tableViewIndexPath) as? RecommendHomeTableCell else {
            return
        }
        guard let targetCollectionCell = targetTableCell.recommendationCollectionView.cellForItem(at: collectionViewIndexPath) as? RecommendHomeCollectionCell else {
            return
        }
        let scale = UIScreen.main.bounds.width / targetCollectionCell.videoPlayView.frame.size.width
        
        let targetRect = UIApplication.shared.keyWindow?.convert(targetCollectionCell.videoPlayView.frame, from:  targetCollectionCell)
        let animationContainer = UIView(frame: CGRect(x: targetRect!.origin.x, y: targetRect!.origin.y, width: targetRect!.width, height: UIScreen.main.bounds.height - targetRect!.origin.y))
        animationContainer.backgroundColor = .white
        let animationImage = UIImageView(frame: targetRect!)
        animationImage.image = targetCollectionCell.videoPlayView.image
        UIApplication.shared.keyWindow?.addSubview(animationContainer)
        UIApplication.shared.keyWindow?.addSubview(animationImage)
        UIApplication.shared.keyWindow?.bringSubviewToFront(animationContainer)
        UIApplication.shared.keyWindow?.bringSubviewToFront(animationImage)
        UIView.animate(withDuration: 0.2, animations: {
            animationImage.transform = CGAffineTransform.identity.scaledBy(x: scale, y: scale).translatedBy(x: 0, y: 42-(targetRect?.origin.y)!)
            animationContainer.transform = CGAffineTransform.identity.scaledBy(x: scale, y: scale)
        }) { _ in
            animationImage.transform = CGAffineTransform.identity
            let targetVC = RecipeDetailViewController()
            self.navigationController?.pushViewController(targetVC, animated: false)
            targetVC.recipe = recipe
            switch rowIndex {
            case 0: targetVC.mealType = .breakfast
            case 1: targetVC.mealType = .lunch
            case 2: targetVC.mealType = .dinner
            default: targetVC.mealType = .unknownMealType
            }
            animationImage.removeFromSuperview()
            animationContainer.removeFromSuperview()
        }
       
    }
    
}
