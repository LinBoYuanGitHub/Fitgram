//
//  RestaurantDetailViewController.swift
//  fitgram
//
//  Created by boyuan lin on 9/1/20.
//  Copyright © 2020 boyuan lin. All rights reserved.
//

import UIKit
import Stevia
import SwiftGRPC

class RestaurantDetailViewController:BaseViewController {
    var restaurant = Apisvr_Restaurant()
    var menus = [Apisvr_Menu]()
    var rootView:RestaurantDetailView!
    
    override func viewDidLoad() {
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
    }
    
    override func loadView() {
        rootView = RestaurantDetailView()
        view = rootView
        rootView.menuCollectionView.delegate = self
        rootView.menuCollectionView.dataSource = self
        rootView.addressLabel.text = restaurant.address
        rootView.restaurantNameLabel.text = restaurant.restaurantName
        rootView.setRatingStar(rating: Int(restaurant.rating))
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(naviToMap))
        rootView.locationContainer.addGestureRecognizer(tapRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Restaurant"
    }
    
    @objc func naviToMap(){
        let lat = restaurant.lat
        let lng = restaurant.lng
        let restaurantName = restaurant.restaurantName.replacingOccurrences(of: " ", with: "+").replacingOccurrences(of: "&", with: "")
//        let trafficMode = "traffic"
//        let zoom = 17
//        let url = URL(string: "http://maps.google.com/maps/?q=\(lat),\(lng)&zoom=\(zoom)")
        guard let url = URL(string: "comgooglemaps://?q=\(restaurantName)&center=\(lat),\(lng)/") else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc func onFavBtnPressed(sender:UIButton){
        let index = sender.tag
        if menus[index].isFavourite {
            self.onFoodUnFav(index: index)
        } else {
            self.onFoodFav(index: index)
        }
    }
    
    func onFoodFav(index:Int){
        let foodId = menus[index].foodID
        var req = Apisvr_AddFavouriteItemReq()
        req.itemID = foodId
        guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
            return
        }
        let menuIndexPath = IndexPath(row: index, section: 0)
        let menuCell = self.rootView.menuCollectionView.cellForItem(at: menuIndexPath) as! MenuCell
        menuCell.likeBtn.isEnabled = false
        do{
            let metaData = try Metadata(["authorization": "Token " + token])
            try ProfileDataManager.shared.client.addFavouriteItem(req, metadata: metaData) { (resp, result) in
            DispatchQueue.main.async {
                menuCell.likeBtn.isEnabled = true
                if result.statusCode == .ok {
                    self.menus[index].isFavourite = true
                    self.menus[index].favouriteNum += 1
                    menuCell.likeBtn.isSelected = true
                    menuCell.likeBtn.setTitle(String(Int(self.menus[index].favouriteNum)), for: .normal)
                }
             }
           }
        } catch {
            menuCell.likeBtn.isEnabled = true
            print(error)
        }
    }
    
    func onFoodUnFav(index:Int) {
        let foodId = menus[index].foodID
        var req = Apisvr_RemoveFavouriteItemReq()
        req.itemID = Int32(foodId)
        guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
            return
        }
        let menuIndexPath = IndexPath(row: index, section: 0)
        let menuCell = self.rootView.menuCollectionView.cellForItem(at: menuIndexPath) as! MenuCell
        menuCell.likeBtn.isEnabled = false
        do{
            let metaData = try Metadata(["authorization": "Token " + token])
            try ProfileDataManager.shared.client.removeFavouriteItem(req, metadata: metaData) { (resp, result) in
                DispatchQueue.main.async {
                    menuCell.likeBtn.isEnabled = true
                    if result.statusCode == .ok {
                        self.menus[index].isFavourite = false
                        self.menus[index].favouriteNum -= 1
                        menuCell.likeBtn.isSelected = false
                        menuCell.likeBtn.setTitle(String(Int(self.menus[index].favouriteNum)), for: .normal)
                    }
                }
            }
        } catch {
            print(error)
        }
        
    }
    
    @objc func onCheckBtnPressed(sender:UIButton){
        let menu = self.menus[sender.tag]
        requestFoodDetail(menu: menu)
    }
    
    func requestFoodDetail(menu:Apisvr_Menu){
        if LoginDataManager.shared.getUserStatus() == .unknownUserType {
            let targetVC = LoginViewController()
            self.navigationController?.pushViewController(targetVC, animated: true)
        } else {
            do{
                var req = Apisvr_GetFoodLogDetailReq()
                var foodTag = Apisvr_FoodTag()
                foodTag.foodID = menu.foodID
                req.foodTags = [foodTag]
                guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                    return
                }
                let metaData = try Metadata(["authorization": "Token " + token])
                try FoodDiaryDataManager.shared.client.getFoodLogDetail(req, metadata: metaData) { (resp, result) in
                    if result.statusCode == .ok {
                        DispatchQueue.main.async {
                            let targetVC = FoodDiaryDetailViewController()
                            targetVC.imgUrl = menu.foodImgURL
                            targetVC.foodDiaryList = resp!.foodLogs
                            targetVC.mealLogList = FoodDiaryDataManager.shared.convertFoodLogToInfo(foodDiaryList: resp!.foodLogs)
                            targetVC.mealType = .breakfast//TODO modify latter
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

extension RestaurantDetailViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as? MenuCell else {
            return UICollectionViewCell()
        }
        let entity = menus[indexPath.row]
        cell.menuImageView.kf.setImage(with: URL(string: entity.foodImgURL),placeholder:UIImage(named: "fitgram_restaurant_defaultIcon"))
        cell.menuNameLabel.text = entity.foodName
        cell.menuPriceLabel.text = "S$\(Int(entity.price))"
        cell.menuCalorieLabel.text = "\(Int(entity.energy))kCal"
        cell.likeBtn.setTitle("\(entity.favouriteNum)", for: .normal)
        cell.likeBtn.isSelected = entity.isFavourite
        cell.likeBtn.tag = indexPath.row
        cell.likeBtn.addTarget(self, action: #selector(onFavBtnPressed), for: .touchUpInside)
        cell.checkBtn.tag = indexPath.row
        cell.checkBtn.addTarget(self, action: #selector(onCheckBtnPressed), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 16) / 2
        return CGSize(width: width, height: 305)
    }
      
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//      
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
    
    
    
    
}
