//
//  ProfileViewController.swift
//  fitgram
//
//  Created by boyuan lin on 18/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia
import SwiftGRPC

class ProfileViewController: UIViewController{
    var rootView = ProfileView()
//    var profile = ProfileModel()
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
    let heightIndex = 2
    let weightIndex = 3
    let activityIndex = 4
    
    let profileDataSvr = ProfileDataService()
    var profile = Apisvr_GetUserProfileResp()
    
    override func loadView() {
        rootView = ProfileView()
        rootView.profileTableView.delegate = self
        rootView.profileTableView.dataSource = self
        rootView.profileTableView.allowsSelection = false
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initMockedProfile()
        self.navigationController?.navigationBar.topItem?.title = "我的"
        genderPicker.delegate = self
        genderPicker.dataSource = self
        birthdayPicker.delegate = self
        birthdayPicker.dataSource = self
        activityLevelPicker.delegate = self
        activityLevelPicker.dataSource = self
        //set init value for profile
        
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
        self.getProfileDataFromLocalStorage()
        self.rootView.profileTableView.reloadData()
    }
    
    func initMockedProfile(){
        
    }
    
    func requestProfileData(){
        guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
            return
        }
        do{
            let metaData = try Metadata(["authorization": "Token " + token])
            let request = Apisvr_GetUserProfileReq()
            
            try profileDataSvr.client.getUserProfile(request, metadata: metaData) { (resp, result) in
                if(result.statusCode == .ok){
                    guard let response = resp else {
                        //error resp message
                        return
                    }
                    self.profile = response
                    self.rootView.profileTableView.reloadData()
                }
            }
        } catch {
            print(error)
            //show error message
        }
    }
    
    func updateProfileData(){
        guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
            return
        }
        do{
            let metaData = try Metadata(["authorization": "Token " + token])
            var request = Apisvr_UpdateUserProfileReq()
            request.activityLevel = profile.activityLevel
            request.avatarURL = profile.avatarURL
            request.birthYear = profile.birthYear
            request.gender = profile.gender
            request.height = profile.height
            request.weight = profile.weight
            try profileDataSvr.client.updateUserProfile(request, metadata: metaData, completion: { (resp, result) in
                if (result.statusCode == .ok){
                    print("update sucessfully")
                }
            })
        } catch {
            print(error)
            //show error message
        }
    }
    
    func getProfileDataFromLocalStorage() {
        let storage = UserDefaults.standard
        self.profile.gender = Int32(storage.integer(forKey: Constants.Profile.genderStorageKey))
        self.profile.birthYear = Int32(storage.integer(forKey: Constants.Profile.birthyearStorageKey))
        self.profile.height = storage.double(forKey: Constants.Profile.heightStorageKey)
        self.profile.weight = storage.double(forKey: Constants.Profile.weightStorageKey)
        self.profile.activityLevel = Int32(storage.integer(forKey: Constants.Profile.activityLvlStorageKey))
    }
    
    func updateProfileToStorage() {
        let storage = UserDefaults.standard
        storage.set(self.profile.gender, forKey: Constants.Profile.genderStorageKey)
        storage.set(self.profile.birthYear, forKey: Constants.Profile.birthyearStorageKey)
        storage.set(self.profile.height, forKey: Constants.Profile.heightStorageKey)
        storage.set(self.profile.weight, forKey: Constants.Profile.weightStorageKey)
        storage.set(self.profile.activityLevel, forKey: Constants.Profile.activityLvlStorageKey)
    }
    
    
}

extension ProfileViewController: UITextFieldDelegate {
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        if textField.tag == heightIndex{//height
//            let value = Double(textField.text!)
//            profile.height = value!
//        } else if textField.tag == weightIndex{//weight
//            let value = Double(textField.text!)
//            profile.weight = value!
//        }
//        self.updateProfileData()
//        return true
//    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        if textField.tag == heightIndex{//height
            let value = Double(textField.text!)
            profile.height = value!
        } else if textField.tag == weightIndex{//weight
            let value = Double(textField.text!)
            profile.weight = value!
        }
        self.updateProfileToStorage()
    }
    
    
}

extension ProfileViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 //gender,birth,height,weight,activitylvl
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.rootView.profileTableView.dequeueReusableCell(withIdentifier: "ProfileTableCell") as? ProfileTableCell else {
            return UITableViewCell()
        }
        cell.profileInfoLabel.text = profileFieldList[indexPath.row]
        cell.profileInfoTextField.tag = indexPath.row
        cell.profileInfoTextField.delegate = self
        switch indexPath.row {
        case 0://gender
            genderPicker.tag = genderIndex
            cell.profileInfoTextField.inputView = genderPicker
            cell.profileInfoTextField.text = genderValueList[0]
            cell.profileInfoTextField.delegate = self
            break
        case 1://birthYear
            birthdayPicker.tag = birthdayIndex
            cell.profileInfoTextField.inputView = birthdayPicker
            cell.profileInfoTextField.text = String(profile.birthYear)
            cell.profileInfoTextField.delegate = self
            birthdayPicker.selectRow(20, inComponent: 0, animated: false)
            break
        case 2://height
            cell.profileInfoTextField.keyboardType = .decimalPad
            cell.profileInfoTextField.text = String(profile.height)
            cell.profileUnitLabel.text = "cm"
            cell.profileInfoTextField.delegate = self
            break
        case 3://weight
            cell.profileInfoTextField.keyboardType = .decimalPad
            cell.profileInfoTextField.text = String(profile.weight)
            cell.profileUnitLabel.text = "kg"
            cell.profileInfoTextField.delegate = self
            break
        case 4://actvity level
            activityLevelPicker.tag = activityIndex
            cell.profileInfoTextField.inputView = activityLevelPicker
            cell.profileInfoTextField.text = activityLevelValueList[0]
            cell.profileInfoTextField.delegate = self
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
        switch pickerView.tag {
        case genderIndex:
            return genderValueList.count
        case birthdayIndex:
            return 50
        case activityIndex:
            return activityLevelValueList.count
        default:
            return 0
        }
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
        let indexPath = IndexPath(row: pickerView.tag, section: 0)
        guard let cell = self.rootView.profileTableView.cellForRow(at: indexPath) as? ProfileTableCell else {
            return
        }
        switch pickerView.tag {
        case genderIndex:
            profile.gender = Int32(row)
            cell.profileInfoTextField.text = genderValueList[row]
            break
        case birthdayIndex:
            profile.birthYear = Int32(1970 + row)
            cell.profileInfoTextField.text = String(1970 + row)
            break
        case activityIndex:
            profile.activityLevel = Int32(row)
            cell.profileInfoTextField.text = activityLevelValueList[row]
            break
        default:
            break
        }
    }
    
    
}
