//
//  FoodDiaryDetailViewController.swift
//  fitgram
//
//  Created by boyuan lin on 11/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class FoodDiaryDetailViewController: UIViewController{
    
    public var rootView:FoodDiaryDetailView!
    public var foodDiaryList = [Apisvr_FoodLog]()
    public var foodImage = UIImage()
    
    
    override func viewDidLoad() {
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "backbutton_black"), style: .plain, target: self, action: #selector(onBackPressed))
        self.initMockUpData()
        rootView.recipeTable.reloadData()
    }
    
    override func loadView() {
        rootView = FoodDiaryDetailView()
        rootView.foodImageView.image = foodImage
        rootView.recipeTable.delegate = self
        rootView.recipeTable.dataSource = self
        view = rootView
    }
    
    @objc func onBackPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func initMockUpData(){
        var foodLog = Apisvr_FoodLog()
        foodLog.amount = 1
        foodLog.energy = 280
        foodLog.foodName = "马铃薯粉[洋芋粉,薯仔薯粉,薯仔粉,土豆粉]"
        var option1 = Apisvr_UnitOption()
        option1.name = "碗"
        option1.weight = 250
        var option2 = Apisvr_UnitOption()
        option2.name = "100克"
        option2.weight = 100
        foodLog.unitOption.append(option1)
        foodLog.unitOption.append(option2)
        foodDiaryList.append(foodLog)
    }
    
    
}


extension FoodDiaryDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodDiaryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FoodDiaryDetailViewCell", for: indexPath) as? FoodDiaryDetailViewCell else {
            return UITableViewCell()
        }
        let entity = foodDiaryList[indexPath.row]
        cell.foodNameLabel.text = entity.foodName
        cell.weightLabel.text = "共\(entity.unitOption[0].weight)克"
        cell.amountInputField.text = String(entity.amount)
        cell.unitInputField.text = entity.unitOption[0].name
        let attributedText = NSAttributedString(string: String(entity.energy) + "千卡")
        let range = NSRange(location: 0, length: (String(Int(entity.energy))).count)
        let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
        mutableAttributedText.addAttribute(.foregroundColor, value: UIColor.yellow, range: range)
        cell.calorieLabel.attributedText = mutableAttributedText
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}
