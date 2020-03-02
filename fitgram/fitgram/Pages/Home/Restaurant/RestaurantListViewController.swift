//
//  RestaurantListViewController.swift
//  fitgram
//
//  Created by boyuan lin on 9/1/20.
//  Copyright © 2020 boyuan lin. All rights reserved.
//

import UIKit
import Stevia
import SwiftGRPC
import CoreLocation

class RestaurantListViewController: UIViewController {
    var rootView: RestaurantListView!
    var restaurantList = [Apisvr_Restaurant]()
    
    override func viewDidLoad() {
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
        self.requestRestaurantList()
        self.enableLocationServices()
    }
    
    func enableLocationServices() {
        guard let apppDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        apppDelegate.locationManager.delegate = self
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
               // Request when-in-use authorization initially
               apppDelegate.locationManager.desiredAccuracy = kCLLocationAccuracyBest
               apppDelegate.locationManager.requestWhenInUseAuthorization()
               apppDelegate.locationManager.startUpdatingLocation()
        case .restricted, .denied:
               break
        case .authorizedWhenInUse:
               // Enable basic location features
               apppDelegate.locationManager.desiredAccuracy = kCLLocationAccuracyBest
               apppDelegate.locationManager.startUpdatingLocation()
        case .authorizedAlways:
               break
        @unknown default:
            break
        }
       }
    
    override func loadView() {
        rootView = RestaurantListView()
        view = rootView
        self.rootView.restaurantTableView.delegate = self
        self.rootView.restaurantTableView.dataSource = self
    }
    
    func requestRestaurantList(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        do{
            var req = Apisvr_GetRestaurantsReq()
            req.lat = Float(appDelegate.userLocation.lat)
            req.lng = Float(appDelegate.userLocation.lng)
            guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                return
            }
            let metaData = try Metadata(["authorization": "Token " + token])
            try RecommendationDataManager.shared.client.getRestaurants(req, metadata: metaData) { (resp, result) in
                if result.statusCode == .ok {
                    DispatchQueue.main.async {
                        self.restaurantList = resp!.restaurants
                        self.rootView.restaurantTableView.reloadData()
                    }
                }
            }
        } catch {
            print(error)
        }
        
    }
}

extension RestaurantListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as? RestaurantCell else {
            return UITableViewCell()
        }
        let restaurant = restaurantList[indexPath.row]
        cell.addressLabel.text = restaurant.address
        cell.restaurantImageView.kf.setImage(with: URL(string: restaurant.restaurantImgURL))
        cell.restaurantNameLabel.text = restaurant.restaurantName
        cell.setRatingStar(rating: Int(restaurant.rating))
        //TODO hardcode distance value
        cell.distanceLabel.text = ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restaurantId = restaurantList[indexPath.row].restaurantID
        var req = Apisvr_GetRestaurantMenusReq()
        req.restaurantID = restaurantId
        guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
            return
        }
        do{
            let metaData = try Metadata(["authorization": "Token " + token])
            try RecommendationDataManager.shared.client.getRestaurantMenus(req, metadata: metaData) { (resp, result) in
                if result.statusCode == .ok{
                    DispatchQueue.main.async {
                        let targetVC = RestaurantDetailViewController()
                        targetVC.menus = resp!.menus
                        targetVC.restaurant = self.restaurantList[indexPath.row]
                        self.navigationController?.pushViewController(targetVC, animated: true)
                    }
                } else {
                    print(result.statusMessage)
                }
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
}

extension RestaurantListViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        delegate.userLocation.lat = (locations.last?.coordinate.latitude)!
        delegate.userLocation.lng = (locations.last?.coordinate.longitude)!
        delegate.locationManager.stopUpdatingLocation()
        self.requestRestaurantList()
    }
}
