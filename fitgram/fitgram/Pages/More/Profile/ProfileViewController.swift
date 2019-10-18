//
//  ProfileViewController.swift
//  fitgram
//
//  Created by boyuan lin on 18/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class ProfileViewController:UIViewController{
    var rootView = ProfileView()
    var profile = ProfileModel()
    let profileFieldList = ["性别","出生年份","身高","体重","日常运动量"]
    let genderValueList = ["女","男"]
    let birthyearValueList = [Int]()
    let activityLevelValueList = ["卧床休息","轻度,静坐少动","中度,常常站立走动","重度,负重"]
    let sectionTitle = "个人信息"
    
    let genderPicker = UIPickerView()
    let birthdayPicker = UIPickerView()
    let activityLevelPicker = UIPickerView()
    
    let genderIndex = 0
    let birthdayIndex = 1
    let activityIndex = 4
    
    override func loadView() {
        rootView = ProfileView()
        rootView.profileTableView.delegate = self
        rootView.profileTableView.dataSource = self
        rootView.profileTableView.allowsSelection = false
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的"
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
    }
}

extension ProfileViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 //gender,birth,height,weight,activitylvl
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.rootView.profileTableView.dequeueReusableCell(withIdentifier: "ProfileTableCell") as? ProfileTableCell else {
            return UITableViewCell()
        }
        cell.profileInfoLabel.text = profileFieldList[indexPath.row]
        switch indexPath.row {
        case 0://gender
            genderPicker.tag = genderIndex
            cell.profileInfoTextField.inputView = genderPicker
            break
        case 1://birthYear
            birthdayPicker.tag = birthdayIndex
            cell.profileInfoTextField.inputView = birthdayPicker
            break
        case 2://height
            break
        case 3://weight
            break
        case 4://actvity level
            activityLevelPicker.tag = activityIndex
            cell.profileInfoTextField.inputView = activityLevelPicker
            break
        default:
            break
        }
        return cell
    }
    
    
}

extension ProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case genderIndex:
            return genderValueList[row]
        case birthdayIndex:
            return String(1970+row)
        case activityIndex:
            return activityLevelValueList[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case genderIndex:
            break
        case birthdayIndex:
            break
        case activityIndex:
            break
        default:
            break
        }
    }
    
    
}
