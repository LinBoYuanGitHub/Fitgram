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
        rootView.coachContainer.addGestureRecognizer(tapRecognizer)
        rootView.recipeLikeCollectionView.delegate = self
        rootView.recipeLikeCollectionView.dataSource = self
        rootView.restaurantLikeTableView.delegate = self
        rootView.restaurantLikeTableView.dataSource = self
        rootView.likeSegmentedControl.addTarget(self, action: #selector(onSegmentSwitch), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.requestFavItem()
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
        let targetVC = ScannerViewController()
        targetVC.delegate = self
        self.navigationController?.pushViewController(targetVC, animated: true)
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
    
    func displayTransistScaleAnimation(index:Int, recipe:RecipeModel) {
        let targetVC = RecipeDetailViewController()
        targetVC.recipe = recipe
        targetVC.mealType = .breakfast
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    
    
}

extension MoreViewController: BarcodeScannerDelegate {
    
    func onDectect(barcode: String) {
        //TODO: request coach info by coach id
        let alertView = UIAlertController(title: "", message: barcode, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .default) { (_) in
            let targetVC = CoachDetailViewController()
            self.navigationController?.pushViewController(targetVC, animated: true)
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
        cell.calorieLabel.text = String(Int(recipeFavItems[indexPath.row].energy)) + "千卡"
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
        do{
            try RecommendationDataManager.shared.retrieveRecipeDetail(recipeId: Int(foodId)) { (recipe) in
                DispatchQueue.main.async {
                    self.displayTransistScaleAnimation(index: indexPath.row, recipe: recipe)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as? RestaurantCell else {
            return UITableViewCell()
        }
        cell.restaurantNameLabel.text = restaurantFavItems[indexPath.row].restaurantName
        cell.restaurantImageView.kf.setImage(with: URL(string: restaurantFavItems[indexPath.row].restaurantImgURL))
        cell.restaurantImageView.contentMode = .scaleAspectFill
        cell.restaurantImageView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: 200)
        cell.infoShadow.frame.size = CGSize(width: UIScreen.main.bounds.width, height: 100)
        return cell
    }
    
    
}
