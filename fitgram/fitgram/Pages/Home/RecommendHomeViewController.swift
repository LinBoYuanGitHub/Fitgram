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

class RecommendHomeViewController:UIViewController{
    
    let vc = AVPlayerViewController()
    var rootView:RecommendHomeView! = nil
    
    var recommendationList = [RecommendationModel]()
    let mealList = ["早餐","午餐","晚餐"]
    
    var datasource = RecommendationDataManager()
    
    
    func initMockUpData() {
        for index in 0...2 {
            var recModel = RecommendationModel()
            var recipeList = [RecipeModel]()
            let mealTitle = mealList[index]
            for _ in 1...5 {
                var recipe = RecipeModel()
                recipe.recipeTitle = "酸奶南瓜碗"
                recipe.recipeCalorie = "345千卡"
                recipe.recipeCookingDuration = "烹饪时间约10-15分钟"
                recipe.videoCoverImageUrl = "https://i2.chuimg.com/ac6aa49e873d4aaa926e89d42c8a022b_1920w_1920h.jpg?imageView2/2/w/300/interlace/1/q/90"
                recipe.recipeVideoUrl = "https://i4.chuimg.com/e655f0aeb0e311e8960402420a000135_720w_72逻辑0h.mp4"
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
        datasource.retrieveRecommendationList(dateStr: "") {recommendationList in
            print("request finish")
            self.recommendationList = recommendationList
            DispatchQueue.main.async {
                 self.rootView.recommendationMainTableView.reloadData()
            }
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
    }
    
    @objc func naviToGroceryListView(){
        let targetVC = GroceryListViewController()
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
    }
    
//    func prepareVideo() {
//        let videoUrl = URL(fileURLWithPath: "https://i4.chuimg.com/e655f0aeb0e311e8960402420a000135_720w_720h.mp4")
//        let urlAsset = AVURLAsset(url: videoUrl)
//        urlAsset.resourceLoader.setDelegate(self, queue: DispatchQueue.main)
//    }
    
    
    
    func playVideo(videoUrl: URL, contentView:UIView){
//        let videoUrl = URL(fileURLWithPath: "https://i4.chuimg.com/e655f0aeb0e311e8960402420a000135_720w_720h.mp4")
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
        return cell
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
            animationImage.removeFromSuperview()
            animationContainer.removeFromSuperview()
        }
       
    }
    
}
