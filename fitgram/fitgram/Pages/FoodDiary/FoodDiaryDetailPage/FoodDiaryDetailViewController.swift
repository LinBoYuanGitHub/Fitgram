//
//  FoodDiaryDetailViewController.swift
//  fitgram
//
//  Created by boyuan lin on 11/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import SwiftGRPC

class FoodDiaryDetailViewController: UIViewController{
    
    public var rootView:FoodDiaryDetailView!
    public var foodDiaryList = [Apisvr_FoodLog]()
    public var mealLogList = [Apisvr_FoodLogInfo]()
    public var foodImage = UIImage()
    
    public var diaryDate = Date()
    public var imgUrl = ""
    public var inputType:Apisvr_InputType = .camera
    public var mealType: Apisvr_MealType = .lunch
    
    private var calorieColor = UIColor(red: 238/255, green: 194/255, blue: 0, alpha: 1)
    
    
    override func viewDidLoad() {
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
//        self.navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "backbutton_black"), style: .plain, target: self, action: #selector(onBackPressed))
         self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "确认", style: .plain, target: self, action: #selector(onFoodRecordFinish))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 80/255, green: 184/255, blue: 60/255, alpha: 1)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name:  UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardwillHide(notification:)), name:  UIResponder.keyboardWillHideNotification, object: nil)
        //dismiss keyboard part
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    override func loadView() {
        rootView = FoodDiaryDetailView()
        rootView.foodImageView.image = foodImage
        rootView.recipeTable.delegate = self
        rootView.recipeTable.dataSource = self
        view = rootView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc func keyboardWillShow(notification: Notification){
        UIView.animate(withDuration: 0.3) {
            self.rootView.recipeTable.frame.origin.y -= 200
            
        }
    }
    
    @objc func keyboardwillHide(notification:Notification){
        UIView.animate(withDuration: 0.3) {
            self.rootView.recipeTable.frame.origin.y += 200
        }
    }
    
    
    @objc func onFoodRecordFinish(){
        do{
            var req = Apisvr_CreateMealLogReq()
            guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                return
            }
            let metaData = try Metadata(["authorization": "Token " + token])
            let calendar = Calendar(identifier: .chinese)
            let components = calendar.dateComponents([.year,.month,.day],from: Date())
            req.date = Int64(calendar.date(from: components)!.timeIntervalSince1970)
            req.foodLogs = mealLogList
            req.imgURL = imgUrl
            req.inputType = inputType
            req.mealType = mealType
            try FoodDiaryDataManager.shared.client.createMealLog(req, metadata: metaData) { (resp, result) in
                 DispatchQueue.main.async {
                    if result.statusCode == .ok {
                        guard let rootview = self.navigationController?.viewControllers[0] as? HomeTabViewController else {
                            return
                        }
                        self.navigationController?.popToRootViewController(animated: true)
                        rootview.selectedIndex = 1
                    }
                }
            }
        }catch {
            print(error)
        }
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


extension FoodDiaryDetailViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodDiaryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FoodDiaryDetailViewCell", for: indexPath) as? FoodDiaryDetailViewCell else {
            return UITableViewCell()
        }
        let entity = foodDiaryList[indexPath.row]
        cell.foodNameLabel.text = entity.foodName
//        cell.weightLabel.text = "共\(entity.unitOption[0].weight)克"
        cell.weightLabel.text = "共100克"
        cell.amountInputField.text = String(Int(entity.amount))
        cell.amountInputField.tag = indexPath.row
        cell.amountInputField.delegate = self
//        cell.unitInputField.text = entity.unitOption[0].name
        for unit in entity.unitOption where unit.unitID == entity.selectedUnitID {
             cell.unitInputField.text = unit.name
        }
        let portionPicker = UIPickerView()
        portionPicker.tag = indexPath.row
        portionPicker.delegate = self
        portionPicker.dataSource = self
        cell.unitInputField.inputView = portionPicker
        let attributedText = NSAttributedString(string: String(Int(entity.energy)) + "千卡")
        let range = NSRange(location: 0, length: (String(Int(entity.energy))).count)
        let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
        mutableAttributedText.addAttribute(.foregroundColor, value: calorieColor, range: range)
        cell.calorieLabel.attributedText = mutableAttributedText
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let amountValue = Float(textField.text!) else {
            return
        }
        let index = textField.tag
        mealLogList[index].amount = amountValue
    }
    
    
}

extension FoodDiaryDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return foodDiaryList[pickerView.tag].unitOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return foodDiaryList[pickerView.tag].unitOption[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let indexPath = IndexPath(row: pickerView.tag, section: 0)
        guard let cell = self.rootView.recipeTable.cellForRow(at: indexPath) as? FoodDiaryDetailViewCell else {
            return
        }
        cell.unitInputField.text = foodDiaryList[pickerView.tag].unitOption[row].name
        mealLogList[pickerView.tag].selectedUnitID = foodDiaryList[pickerView.tag].unitOption[row].unitID
    }
    
    
}
