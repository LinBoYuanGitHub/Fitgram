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

class RecipeDetailViewController:UIViewController{
    var rootView:RecipeDetailView!
    let vc = AVPlayerViewController()
    //data part
    var recipe = RecipeModel()
    //cache
    var datasource = RecommendationDataManager()
    
    override func loadView() {
        rootView = RecipeDetailView()
        rootView.recipeDetailTable.delegate = self
        rootView.recipeDetailTable.dataSource = self
        rootView.recipeDetailTable.allowsSelection = false
//        rootView.contentView.ingredientDataList = recipe.ingredientList
//        rootView.contentView.assembleIngredientList()
        view = rootView
    }
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barStyle = .black
        self.rootView.naviCoverView.alpha = 0
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.hidesBackButton = true
        //        self.navigationController?.navigationBar.subviews[0].alpha = 0
        //        self.navigationController?.navigationBar.tintColor = UIColor.black
        //        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "backbutton_black"), style: .plain, target: self, action: #selector(onBackPressed))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        //        self.rootView.customBackButton.addTarget(self, action: #selector(onBackPressed), for: .touchUpInside)
        self.rootView.playButton.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        self.rootView.contentView.startCookBtn.addTarget(self, action: #selector(startCook), for: .touchUpInside)
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
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //dismiss the floating btn when exit
        self.rootView.contentView.dismissStartCookBtn()
    }
    
    
    @objc func onBackPressed(){
        self.navigationController?.popViewController(animated: true)
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
        self.present(cookingVC, animated: true)
        self.rootView.contentView.dismissStartCookBtn()
    }
    
    
    func retrieveRecipeDetail(){
        self.rootView.recipeDetailTable.isScrollEnabled = false
        do{
            try datasource.retrieveRecipeDetail(recipeId: recipe.recipeId) { (recipe) in
                self.recipe = recipe
                self.rootView.contentView.ingredientDataList = recipe.ingredientList
                DispatchQueue.main.async {
                    self.rootView.recipeDetailTable.reloadData()
                    self.rootView.contentView.assembleIngredientList()
                    self.rootView.contentView.createStartCookButton()
                    self.rootView.bringSubviewToFront(self.rootView.recipeDetailTable)
                    self.rootView.recipeDetailTable.isScrollEnabled = true
                }
            }
        } catch {
            print(error)
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
        cell.recipeStepImage.kf.setImage(with: URL(string: recipe.stepList[indexPath.section].stepImageUrl))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
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
            self.rootView.contentView.showStartCookBtn()
        } else if (y > 100 || y < UIScreen.main.bounds.height + 500 - self.rootView.recipeDetailTable.contentSize.height) {
            self.rootView.contentView.dismissStartCookBtn()
        }
    }
}

