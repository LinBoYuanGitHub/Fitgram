//
//  RestaurantFavViewController.swift
//  fitgram
//
//  Created by boyuan lin on 19/1/20.
//  Copyright © 2020 boyuan lin. All rights reserved.
//

import UIKit
import SwiftGRPC

class RestaurantFavViewController:BaseViewController {
    public var restaurantId:Int32 = 0
    public var restaurantFavCollectionView = UICollectionView.init(frame: CGRect(x: 8, y: 20, width: UIScreen.main.bounds.width - 16 , height: UIScreen.main.bounds.height - 20), collectionViewLayout: UICollectionViewFlowLayout())
    public var favItems = [Apisvr_FavouriteItem]()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        self.view.addSubview(restaurantFavCollectionView)
        self.configRestaurantFavCollectionView()
        self.requestForRestaurantFavItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func configRestaurantFavCollectionView(){
        restaurantFavCollectionView.delegate = self
        restaurantFavCollectionView.dataSource = self
        restaurantFavCollectionView.backgroundColor = .white
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        let sideLength = (UIScreen.main.bounds.width - 27) / 3
        layout.itemSize = CGSize(width: sideLength, height: sideLength)
//        layout.footerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 20)
        restaurantFavCollectionView.collectionViewLayout = layout
        restaurantFavCollectionView.showsVerticalScrollIndicator = false
        restaurantFavCollectionView.register(LikeCollectionViewCell.self, forCellWithReuseIdentifier: "LikeCollectionViewCell")
    }
    
    func requestForRestaurantFavItem(){
        var req = Apisvr_GetFavouriteRestaurantMenusReq()
        req.restaurantID = self.restaurantId
        guard let token = UserDefaults.standard.string(forKey:  Constants.tokenKey) else {
            return
        }
        do{
               let metaData = try Metadata(["authorization": "Token " + token])
                try ProfileDataManager.shared.client!.getFavouriteRestaurantMenus(req, metadata: metaData, completion: { (resp, result) in
                    if result.statusCode == .ok {
                        DispatchQueue.main.async {
                            self.favItems = resp!.menus
                            self.restaurantFavCollectionView.reloadData()
                        }
                   }
               })
        } catch {
            print(error)
        }
    }
    
}


extension RestaurantFavViewController:UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikeCollectionViewCell", for: indexPath) as? LikeCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.calorieLabel.text = String(Int(favItems[indexPath.row].energy)) + "千卡"
        cell.foodNameLabel.text = favItems[indexPath.row].foodName
        cell.foodImageView.image = UIImage(named: "fitgram_defaultIcon")
        cell.foodImageView.kf.setImage(with: URL(string: favItems[indexPath.row].imgURL))
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
        let foodId = self.favItems[indexPath.row].foodID
//        do{
//            try RecommendationDataManager.shared.retrieveRecipeDetail(recipeId: Int(foodId)) { (recipe) in
//                DispatchQueue.main.async {
//                    let targetVC = RecipeDetailViewController()
//                    targetVC.recipe = recipe
//                    targetVC.mealType = .breakfast
//                    self.navigationController?.pushViewController(targetVC, animated: true)
//                }
//            }
//        } catch {
//            DispatchQueue.main.async {
//                self.showAlertMessage(msg: error.localizedDescription)
//            }
//        }
        
    }
    
    
}
