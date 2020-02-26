//
//  FoodDiaryViewController.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 1/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import SwiftGRPC
import EPCalendarPicker

class FoodDiaryViewController:BaseViewController {
    var rootView:FoodDiaryView! = nil
    var nutritient = Apisvr_FoodDiaryNutrient()
    var mealEntity = Apisvr_GetFoodDiaryResp()
    
    public var diaryDate = Date()
    private var keyboardOffsetDistance = 100
    public var currentMealType:Apisvr_MealType = .breakfast
    
    override func viewDidLoad() {
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
        rootView.onDateBtnPressedEvent = {
//            let targetVC = CalendarViewController()
//            self.navigationController?.pushViewController(targetVC, animated: true)
            let calendarPicker = EPCalendarPicker(startYear: 2019, endYear: 2020, multiSelection: false, selectedDates: [self.diaryDate])
            calendarPicker.calendarDelegate = self
            calendarPicker.weekdayTintColor = .black
            let navigationController = UINavigationController(rootViewController: calendarPicker)
            self.present(navigationController, animated: true) {
                calendarPicker.scrollToMonthForDate(self.diaryDate)
            }
        }
        
        rootView.onLeftArrowPressedEvent = {
            self.diaryDate = Calendar.current.date(byAdding: .day,value: -1, to: self.diaryDate)!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM"
            let title = dateFormatter.string(from: self.diaryDate)
            self.rootView.dateBtn.setTitle(title, for: .normal)
            self.requestForFoodDiary()
        }
        
        rootView.onRightArrowPressedEvent = {
            self.diaryDate = Calendar.current.date(byAdding: .day,value: 1, to: self.diaryDate)!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM"
            let title = dateFormatter.string(from: self.diaryDate)
            self.rootView.dateBtn.setTitle(title, for: .normal)
            self.requestForFoodDiary()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.requestForFoodDiary()
        //navigatation bar setting
        self.navigationController?.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func loadView() {
        rootView = FoodDiaryView()
        rootView.foodDiaryTableView.delegate = self
        rootView.foodDiaryTableView.dataSource = self
        rootView.foodDiaryTableView.separatorStyle = .none
        self.initNutritientData()
        rootView.nutrientPanel.nutrientObj = nutritient
        view = rootView
    }
    
    func requestForFoodDiary(){
        do{
            var request = Apisvr_GetFoodDiaryReq()
            let calendar = Calendar(identifier: .chinese)
            let components = calendar.dateComponents([.year,.month,.day],from: diaryDate)
            request.date = Int64(calendar.date(from: components)!.timeIntervalSince1970)
            guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                return
            }
            let metaData = try Metadata(["authorization": "Token " + token])
            self.rootView.leftDateArrow.isEnabled = false
            self.rootView.rightDateArrow.isEnabled = false
            try FoodDiaryDataManager.shared.client.getFoodDiary(request, metadata: metaData) { (resp, result) in
                if result.statusCode != .ok {
                    return
                }
                self.mealEntity = resp!
                self.nutritient = resp!.nutrient
                DispatchQueue.main.async {
                    self.rootView.leftDateArrow.isEnabled = true
                    self.rootView.rightDateArrow.isEnabled = true
                    self.rootView.foodDiaryTableView.reloadData()
                    self.rootView.nutrientPanel.nutrientObj = self.nutritient
                    self.rootView.nutrientPanel.nutritionCollectionView.reloadData()
                }
            }
        }catch {
            DispatchQueue.main.async {
                self.rootView.leftDateArrow.isEnabled = true
                self.rootView.rightDateArrow.isEnabled = true
            }
            print(error)
        }
    }
    
    func initNutritientData(){
        nutritient.energyIntake = 1523
        nutritient.energyRecommend = 1456
        nutritient.fatIntake = 73
        nutritient.fatRecommend = 61
        nutritient.carbohydrateIntake = 68
        nutritient.carbohydrateRecommend = 169
        nutritient.proteinIntake = 15
        nutritient.proteinRecommend = 34
    }
    
    
    func showRecordActionSheet(){
        let optionMenu = UIAlertController(title: nil, message: "Option", preferredStyle: .actionSheet)
        let cameraOption  = UIAlertAction(title: "Camera", style: .default) { (alertAction) in
            self.openCamera()
            optionMenu.dismiss(animated: true, completion: nil)
        }
        let galleryOption  = UIAlertAction(title: "Album", style: .default) { (alertAction) in
            self.openAlbum()
            optionMenu.dismiss(animated: true, completion: nil)
        }
        let textOption  = UIAlertAction(title: "Text Search", style: .default) { (alertAction) in
            let targetVC = TextSearchViewController()
            targetVC.textSearchDelegate = self
            targetVC.isKeepSearchPage = true
            targetVC.mealType = self.currentMealType
            optionMenu.dismiss(animated: true, completion: nil)
            self.navigationController?.pushViewController(targetVC, animated: true)
        }
        let cancelOption  = UIAlertAction(title: "Cancel", style: .cancel) { (alertAction) in
            optionMenu.dismiss(animated: true, completion: nil)
        }
        optionMenu.addAction(cameraOption)
        optionMenu.addAction(galleryOption)
        optionMenu.addAction(textOption)
        optionMenu.addAction(cancelOption)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        } else {
            //TODO show modal native camera not available
            let alert = UIAlertController.init(title: "Message", message: "No Camera Dectected", preferredStyle: .alert)
            let cancel = UIAlertAction.init(title: "Confirm", style: .cancel, handler: nil)
            alert.addAction(cancel)
            self.show(alert, sender: nil)
        }
    }
    
    func openAlbum(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        } else {
            //TODO show modal native camera not available
            let alert = UIAlertController.init(title: "Message", message: "Cannot Open Album", preferredStyle: .alert)
            let cancel = UIAlertAction.init(title: "Confirm", style: .cancel, handler: nil)
            alert.addAction(cancel)
            self.show(alert, sender: nil)
        }
    }
    
    func requestFoodItemDetail(mealLog:Apisvr_FoodDiaryMealLog){
        var req = Apisvr_GetMealLogReq()
        req.mealLogID = mealLog.mealLogID
        do {
            guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                return
            }
            let metaData = try Metadata(["authorization": "Token " + token])
            try FoodDiaryDataManager.shared.client.getMealLog(req, metadata: metaData) { (resp, result) in
                DispatchQueue.main.async {
                    if result.statusCode == .ok {
                        let targetVC = FoodDiaryDetailViewController()
                        targetVC.imgUrl = resp!.imgURL
                        targetVC.foodDiaryList = resp!.foodLogs
                        targetVC.mealLogList = FoodDiaryDataManager.shared.convertFoodLogToInfo(foodDiaryList: resp!.foodLogs)
                        targetVC.mealLogId = mealLog.mealLogID
                        targetVC.isUpdate = true
                        self.navigationController?.pushViewController(targetVC, animated: true)
                    } else {
                        self.showAlertMessage(msg: result.statusMessage!)
                    }
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.showAlertMessage(msg: error.localizedDescription)
            }
        }
        
    }
    
}

extension FoodDiaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealEntity.mealLogs.count //breakfast, lunch, dinner
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FoodDiaryMainCell", for: indexPath) as? FoodDiaryMainCell else {
            return UITableViewCell()
        }
        switch indexPath.row{
        case 0://breakfast
            cell.mealTItle.text = "Breakfast"
            cell.calorieTitle.text = String(Int(mealEntity.nutrientByMeal.breakfastEnergy)) + "kCal"
            cell.suggestionIntakenLabel.text = "Recommended:\(Int(mealEntity.nutrientByMeal.breakfastPercentage*100))% (approx \(Int(mealEntity.nutrient.energyRecommend*mealEntity.nutrientByMeal.breakfastPercentage))kCal)"
            cell.setUpMealData(mealList: mealEntity.mealLogs[0].mealLogByType)   //Apisvr_FoodDiaryMealLog
            cell.didSelectMealAction = { index in
                self.currentMealType = .breakfast
                self.showRecordActionSheet()
            }
            break;
        case 1://lunch
             cell.mealTItle.text = "Lunch"
             cell.calorieTitle.text = String(Int(mealEntity.nutrientByMeal.lunchEnergy)) + "kCal"
             cell.suggestionIntakenLabel.text = "Recommend:\(Int(mealEntity.nutrientByMeal.lunchPercentage*100))% (approx \(Int(mealEntity.nutrient.energyRecommend*mealEntity.nutrientByMeal.lunchPercentage))kCal)"
             cell.setUpMealData(mealList: mealEntity.mealLogs[1].mealLogByType)
             cell.didSelectMealAction = { index in
                self.currentMealType = .lunch
                self.showRecordActionSheet()
             }
            break;
        case 2://dinner
             cell.mealTItle.text = "Dinner"
             cell.calorieTitle.text = String(Int(mealEntity.nutrientByMeal.dinnerEnergy)) + "kCal"
             cell.suggestionIntakenLabel.text = "Recomended:\(Int(mealEntity.nutrientByMeal.dinnerPercentage*100))% (approx \(Int(mealEntity.nutrient.energyRecommend*mealEntity.nutrientByMeal.dinnerPercentage))kCal)"
             cell.setUpMealData(mealList: mealEntity.mealLogs[2].mealLogByType)
             cell.didSelectMealAction = { index in
                self.showRecordActionSheet()
                self.currentMealType = .dinner
             }
             break;
        default: break;
        }
        cell.viewMealAction = { mealItemIndex in
            let mealLog = self.mealEntity.mealLogs[indexPath.row].mealLogByType[mealItemIndex]
            self.requestFoodItemDetail(mealLog: mealLog)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var mealLogs = [Apisvr_FoodDiaryMealLog]()
        mealLogs = mealEntity.mealLogs[indexPath.row].mealLogByType
        return calculateCellHeight(mealLogs:mealLogs)
    }
    
    func calculateCellHeight(mealLogs:[Apisvr_FoodDiaryMealLog]) -> CGFloat{
        var recipeNum = 0
        for meal in mealLogs {
            let count = meal.foodLog.count
            recipeNum += count
        }
        let collectionViewHeight =  ((mealLogs.count)/4 + 1) * 75
        let tableviewHeight = recipeNum * 52
        return CGFloat(110 + collectionViewHeight + tableviewHeight)
    }
    
    
    
}

extension FoodDiaryViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else {
            return
        }
        self.dismiss(animated: true)
        guard let userId = UserDefaults.standard.string(forKey: Constants.userIdKey) else {
            return
        }
        let timeStamp = String(Int(Date().timeIntervalSince1970 * 1000))
        let objectKey = userId + "_" + timeStamp
//        self.showLoadingDialog(targetController: self, loadingText: "上传图片中...")
        UploaderManager.shared.asyncPutFoodDiaryImage(objectKey: objectKey, image: selectedImage) { (objectKey) in
            do{
                var req = Apisvr_RecognitionReq()
                req.imgURL = objectKey
                req.lat = 0.0
                req.lng = 0.0
                guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                    return
                }
                let metaData = try Metadata(["authorization": "Token " + token])
//                self.modifyLoadingDialogText(loadingText: "识别中...")
//                self.hideLoadingDialog()
                try FoodDiaryDataManager.shared.client.recognition(req, metadata: metaData, completion: { (resp, result) in
                    DispatchQueue.main.asyncAfter(deadline:  .now() + 0.5, execute: {
                        if result.statusCode == .ok {
                            guard let taskId = resp?.taskID else {
                                return
                            }
                            let targetVC = FoodDiaryTagViewController()
                            targetVC.selectedImage = selectedImage
                            targetVC.taskId = taskId
                            targetVC.imageKey = objectKey
                            targetVC.mealType = self.currentMealType
                            targetVC.diaryDate = self.diaryDate
                            self.navigationController?.pushViewController(targetVC, animated: true)
                        }
                    })
                })
            } catch {
                print(error)
            }
        }
        
    }
}

extension FoodDiaryViewController: TextSearchDelegate {
    
    func onReturnTextsSearchResult(item: Apisvr_SearchItem) {
        do{
            var req = Apisvr_GetFoodLogDetailReq()
            var textTag = Apisvr_FoodTag()
            textTag.foodID = item.searchItemID
            req.foodTags = [textTag]
            guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                return
            }
            let metaData = try Metadata(["authorization": "Token " + token])
            try FoodDiaryDataManager.shared.client.getFoodLogDetail(req, metadata: metaData) { (resp, result) in
                if result.statusCode == .ok{
                    DispatchQueue.main.async {
                        let targetVC = FoodDiaryDetailViewController()
                        targetVC.diaryDate = self.diaryDate
                        targetVC.foodDiaryList = resp!.foodLogs
                        targetVC.mealLogList = FoodDiaryDataManager.shared.convertFoodLogToInfo(foodDiaryList: resp!.foodLogs)
                        targetVC.mealType = self.currentMealType
                        self.navigationController?.pushViewController(targetVC, animated: true)
                    }
                }
               
            }
        }catch {
            print(error)
        }
    }
    
    func onCancelTextSearchAction() {
        
    }
}

extension FoodDiaryViewController: EPCalendarPickerDelegate {
    
    
    func epCalendarPicker(_: EPCalendarPicker, didSelectDate date: Date) {
        self.diaryDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        let title = dateFormatter.string(from: self.diaryDate)
        self.rootView.dateBtn.setTitle(title, for: .normal)
        self.requestForFoodDiary()
    }
    
    func epCalendarPicker(_: EPCalendarPicker, didCancel error: NSError) {
        self.dismiss(animated: true, completion: nil)
    }
}
