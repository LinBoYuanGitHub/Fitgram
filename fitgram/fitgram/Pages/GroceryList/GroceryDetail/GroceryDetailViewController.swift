//
//  GroceryDetailViewController.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 11/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia
import SwiftGRPC

class GroceryDetailViewController: UIViewController {
    var rootView:GroceryDetailView!  = nil
    var isAllIngredient = false
    var detailItemId = 0
    var groceryDetailItem = Apisvr_GetCheckListItemResp()
    var groceryList = [Apisvr_IngredientInfo]()
    
    var HeadImageHeight = 0
    
    override func loadView() {
        rootView = GroceryDetailView()
        rootView.ingredientTableView.delegate = self
        rootView.ingredientTableView.dataSource = self
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  "食材列表"
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "backbutton_black"), style: .plain, target: self, action: #selector(onBackPressed))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
    }
    
    @objc func onBackPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension GroceryDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryDetailItem.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.rootView.ingredientTableView.dequeueReusableCell(withIdentifier: "GroceryIngredientCell") as? GroceryIngredientCell else {
            return UITableViewCell()
        }
        cell.ingredientNameLabel.text = groceryDetailItem.ingredients[indexPath.row].name
        cell.portionDescLabel.text = String(groceryDetailItem.ingredients[indexPath.row].amount) + groceryDetailItem.ingredients[indexPath.row].unit
        cell.checkBox.tag = indexPath.row
        cell.checkBox.addTarget(self, action: #selector(onIngredientItemCheck), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(HeadImageHeight)
    }
    
    @objc func onIngredientItemCheck(sender:UIButton){
        self.onIngredientCheck(index:sender.tag)
    }
    
    func onIngredientCheck(index:Int){
        let ingredient = self.groceryDetailItem.ingredients[index]
        var req = Apisvr_IngredientCheckReq()
        req.recommendedRecipeID = Int32(self.detailItemId)
        req.ingredientID = Int32(ingredient.ingredientID)
        req.check = !ingredient.isChecked
        do{
            guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                return
            }
            let metaData = try Metadata(["authorization": "Token " + token])
            try RecommendationDataManager.shared.client.ingredientCheck(req, metadata: metaData, completion: { (resp, result) in
                let indexPath = IndexPath(row: index, section: 0)
                guard let cell = self.rootView.ingredientTableView.cellForRow(at: indexPath) as? GroceryIngredientCell else {
                    return
                }
                self.groceryDetailItem.ingredients[index].isChecked = req.check
                cell.checkBox.isSelected = req.check
            })
        } catch {
            print(error)
        }
      
    }
    
    
}
