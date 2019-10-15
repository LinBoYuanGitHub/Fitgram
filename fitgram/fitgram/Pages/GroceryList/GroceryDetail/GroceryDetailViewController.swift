//
//  GroceryDetailViewController.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 11/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class GroceryDetailViewController: UIViewController {
    var rootView:GroceryDetailView!  = nil
    var ingredientList = [IngredientModel]()
    
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
//        self.navigationController?.navigationBar.topItem?.title = "食材列表"
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
        return ingredientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.rootView.ingredientTableView.dequeueReusableCell(withIdentifier: "GroceryIngredientCell") as? GroceryIngredientCell else {
            return UITableViewCell()
        }
        cell.ingredientNameLabel.text = ingredientList[indexPath.row].ingredientName
        cell.portionDescLabel.text = ingredientList[indexPath.row].portionDesc
        cell.checkBox.tag = indexPath.row
        cell.checkBox.addTarget(self, action: #selector(onIngredientItemCheck), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    @objc func onIngredientItemCheck(sender:UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 0)
        guard let cell = rootView.ingredientTableView.cellForRow(at: indexPath) as? GroceryIngredientCell else {
            return
        }
        cell.checkBox.isSelected = !cell.checkBox.isSelected
    }
    
    
}
