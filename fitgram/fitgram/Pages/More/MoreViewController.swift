//
//  MoreViewController.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 1/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia
import SwiftGRPC

class MoreViewController: BaseViewController {
    public var rootView:MoreView!
    var recipeFavItems = [Apisvr_FavouriteItem]()
    var restaurantFavItems = [Apisvr_FavouriteRestaurant]()
    
    override func viewDidLoad() {
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
        self.rootView.switchToRecipeCollectionView()
//        self.requestFavRestaurant()
    }
    
    override func loadView() {
        rootView = MoreView()
        view = rootView
        rootView.onProfileContainerTapEvent = {
            let targetVC = ProfileViewController()
            self.navigationController?.pushViewController(targetVC, animated: true)
        }
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onCoachBtnPressed))
        rootView.horizontalContainer.addGestureRecognizer(tapRecognizer)
        rootView.recipeLikeCollectionView.delegate = self
        rootView.recipeLikeCollectionView.dataSource = self
        rootView.restaurantLikeTableView.delegate = self
        rootView.restaurantLikeTableView.dataSource = self
        rootView.likeSegmentedControl.addTarget(self, action: #selector(onSegmentSwitch), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.requestFavItem()
        self.requestProfileData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //for showing index 0 segment
        if self.rootView.likeSegmentedControl.selectedSegmentIndex == 0 {
            self.rootView.switchToRecipeCollectionView()
        } else {
            self.rootView.switchToRestaurantLikeTableView()
        }
    }
    
    @objc func onSegmentSwitch(sender:UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        switch index {
        case 0:
            self.rootView.switchToRecipeCollectionView()
            self.requestFavItem()
        case 1:
            self.rootView.switchToRestaurantLikeTableView()
            self.requestFavRestaurant()
        default:
            break
        }
    }
    
    @objc func onCoachBtnPressed(){
        let targetVC = CoachDetailViewController()
//        targetVC.delegate = self
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    func requestProfileData() {
        guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
            return
        }
        do{
            let metaData = try Metadata(["authorization": "Token " + token])
            let request = Apisvr_GetUserProfileReq()
            try ProfileDataManager.shared.client.getUserProfile(request, metadata: metaData) { (resp, result) in
                if(result.statusCode == .ok){
                    ProfileDataManager.shared.profile = resp!
                    let splitStrs = ProfileDataManager.shared.profile.avatarURL.split(separator: "/")
                    if splitStrs.count > 0{
                          ProfileDataManager.shared.profile.avatarURL = "portraitImages/" + splitStrs.last!
                    }
                    DispatchQueue.main.async {
                        self.rootView.portraitTitleLabel.text = ProfileDataManager.shared.profile.nickname
                        self.rootView.portraitImageView.layer.cornerRadius = self.rootView.portraitImageView.frame.size.width/2
                        self.rootView.portraitImageView.clipsToBounds = true
                        self.rootView.portraitImageView.kf.setImage(with: URL(string: "https://fitgramer.oss-ap-southeast-1.aliyuncs.com/"+ProfileDataManager.shared.profile.avatarURL),placeholder: UIImage(named: "profile_avatar"))
                    }
                }
            }
        } catch {
            print(error)
            DispatchQueue.main.async {
                self.showAlertMessage(msg: error.localizedDescription)
            }
        }
    }
    
    func requestFavItem(){
        let req = Apisvr_GetFavouriteRecipesReq()
        guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
            return
        }
        do{
            let metaData = try Metadata(["authorization": "Token " + token])
            try ProfileDataManager.shared.client.getFavouriteRecipes(req, metadata: metaData) { (resp, result) in
                if result.statusCode == .ok {
                    DispatchQueue.main.async {
                        self.recipeFavItems = resp!.recipes
                        self.rootView.recipeLikeCollectionView.reloadData()
                    }
                    
                }
            }
        } catch {
            print(error)
        }
        
    }
    
    func requestFavRestaurant(){
        let req = Apisvr_GetFavouriteRestaurantsReq()
        guard let token = UserDefaults.standard.string(forKey:  Constants.tokenKey) else {
            return
        }
        do{
            let metaData = try Metadata(["authorization": "Token " + token])
            try ProfileDataManager.shared.client.getFavouriteRestaurants(req, metadata: metaData, completion: { (resp, result) in
                if result.statusCode == .ok {
                    DispatchQueue.main.async {
                        self.restaurantFavItems = resp!.restaurants
                        self.rootView.restaurantLikeTableView.reloadData()
                    }
                }
            })
        } catch {
            print(error)
        }
    }
    
    func displayTransistScaleAnimation(index:Int, recipe:RecipeModel,mealType:Apisvr_MealType) {
        let targetVC = RecipeDetailViewController()
        targetVC.recipe = recipe
        targetVC.mealType = mealType
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    
    
}

extension MoreViewController: BarcodeScannerDelegate {
    
    func onDectect(barcode: String) {
        //TODO: request coach info by coach id
        let alertView = UIAlertController(title: "", message: barcode, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            print( barcode.components(separatedBy: "coach_id=").count)
            if barcode.components(separatedBy: "coach_id=").count > 1{
                DispatchQueue.main.async {
                    let coachId = Int(barcode.components(separatedBy: "coach_id=")[1])
                    let targetVC = CoachContractViewController()
                    targetVC.coachId = coachId!
                    self.navigationController?.pushViewController(targetVC, animated: true)
                }
               
            }
        }
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
    }
}

extension MoreViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeFavItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikeCollectionViewCell", for: indexPath) as? LikeCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.calorieLabel.text = String(Int(recipeFavItems[indexPath.row].energy)) + "kCal"
        cell.foodNameLabel.text = recipeFavItems[indexPath.row].foodName
        cell.foodImageView.image = UIImage(named: "fitgram_defaultIcon")
        cell.foodImageView.kf.setImage(with: URL(string: recipeFavItems[indexPath.row].imgURL))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sideLength = (UIScreen.main.bounds.width - 27) / 3
        return CGSize(width: sideLength, height: sideLength)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let foodId = self.recipeFavItems[indexPath.row].foodID
        let mealType =  Apisvr_MealType(rawValue: Int(self.recipeFavItems[indexPath.row].dishType))!
        do{
            try RecommendationDataManager.shared.retrieveRecipeDetail(recipeId: Int(foodId)) { (recipe) in
                DispatchQueue.main.async {
                    self.displayTransistScaleAnimation(index: indexPath.row, recipe: recipe, mealType: mealType)
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.showAlertMessage(msg: error.localizedDescription)
            }
        }
        
    }
    
}

extension MoreViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantFavItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LikeTableViewCell", for: indexPath) as? LikeTableViewCell else {
            return UITableViewCell()
        }
        cell.restaurantNameLabel.text = restaurantFavItems[indexPath.row].restaurantName
        cell.restaurantImageView.frame.size.height = 200
        cell.restaurantImageView.contentMode = .scaleAspectFit
        cell.restaurantImageView.kf.setImage(with: URL(string: restaurantFavItems[indexPath.row].restaurantImgURL))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let targetVC = RestaurantFavViewController()
        targetVC.restaurantId = restaurantFavItems[indexPath.row].restaurantID
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    
}
