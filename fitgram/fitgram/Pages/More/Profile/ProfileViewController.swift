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

class ProfileViewController: BaseViewController{
    var rootView = ProfileView()
//    var profile = ProfileModel()
    let profileFieldList = ["Gender","Birth Year","Height","Weight","Daily activity level"]
    let fixSectionFieldList = ["Avatar","Nickname"]
    let genderValueList = ["Female","Male"]
    let birthyearValueList = [Int]()
    let activityLevelValueList = ["Sedentary","Light activity","Moderate activity","Extremely active"]
    let sectionTitle = "Personal Infomation"
    
    let genderPicker = UIPickerView()
    let birthdayPicker = UIPickerView()
    let activityLevelPicker = UIPickerView()
    
    let genderIndex = 0
    let birthdayIndex = 1
    let heightIndex = 2
    let weightIndex = 3
    let activityIndex = 4
    
    let profileDataSvr = ProfileDataManager.shared
//    var profile = Apisvr_GetUserProfileResp()
    
    override func loadView() {
        rootView = ProfileView()
        rootView.profileTableView.delegate = self
        rootView.profileTableView.dataSource = self
        rootView.profileTableView.allowsSelection = false
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "My Profile"
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
//        self.requestProfileData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func requestProfileData() {
        guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
            return
        }
        do{
            let metaData = try Metadata(["authorization": "Token " + token])
            let request = Apisvr_GetUserProfileReq()
            try profileDataSvr.client.getUserProfile(request, metadata: metaData) { (resp, result) in
                if(result.statusCode == .ok){
                    ProfileDataManager.shared.profile = resp!
                    DispatchQueue.main.async {
                        self.rootView.profileTableView.reloadData()
                    }
                }
            }
        } catch {
            print(error)
            DispatchQueue.main.async {
                self.showAlertMessage(msg: error.localizedDescription)
            }
        }
    }
    
    func updateProfileData(){
        guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
            return
        }
        do{
            let metaData = try Metadata(["authorization": "Token " + token])
            var request = Apisvr_UpdateUserProfileReq()
            if let nickNameCell = self.rootView.profileTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? ProfileTableCell {
                request.nickname = nickNameCell.profileInfoTextField.text!
            }
            request.activityLevel =  ProfileDataManager.shared.profile.activityLevel
            request.avatarURL =  ProfileDataManager.shared.profile.avatarURL
            request.birthYear =  ProfileDataManager.shared.profile.birthYear
            request.gender =  ProfileDataManager.shared.profile.gender
            request.height =  ProfileDataManager.shared.profile.height
            request.weight =  ProfileDataManager.shared.profile.weight
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
        ProfileDataManager.shared.profile.gender = Apisvr_Gender.init(rawValue: storage.integer(forKey: Constants.Profile.genderStorageKey))!
        ProfileDataManager.shared.profile.birthYear = Int32(storage.integer(forKey: Constants.Profile.birthyearStorageKey))
        ProfileDataManager.shared.profile.height = storage.float(forKey: Constants.Profile.heightStorageKey)
        ProfileDataManager.shared.profile.weight = storage.float(forKey: Constants.Profile.weightStorageKey)
        ProfileDataManager.shared.profile.activityLevel = Apisvr_ActivityLevel.init(rawValue: storage.integer(forKey: Constants.Profile.activityLvlStorageKey))!
    }
    
    func updateProfileToStorage() {
        let storage = UserDefaults.standard
        storage.set(ProfileDataManager.shared.profile.gender.rawValue, forKey: Constants.Profile.genderStorageKey)
        storage.set(ProfileDataManager.shared.profile.birthYear, forKey: Constants.Profile.birthyearStorageKey)
        storage.set(ProfileDataManager.shared.profile.height, forKey: Constants.Profile.heightStorageKey)
        storage.set(ProfileDataManager.shared.profile.weight, forKey: Constants.Profile.weightStorageKey)
        storage.set(ProfileDataManager.shared.profile.activityLevel.rawValue, forKey: Constants.Profile.activityLvlStorageKey)
    }
    
    
}

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        if textField.tag == heightIndex{//height
            let value = Float(textField.text!)
             ProfileDataManager.shared.profile.height = value!
        } else if textField.tag == weightIndex{//weight
            let value = Float(textField.text!)
             ProfileDataManager.shared.profile.weight = value!
        }
        self.updateProfileToStorage()
        self.updateProfileData()
    }
    
    
}

extension ProfileViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return sectionTitle
        } else {
            return ""
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 90
        } else {
            return 46
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1{
            return 5 //gender,birth,height,weight,activitylvl
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0: 
                guard let cell = self.rootView.profileTableView.dequeueReusableCell(withIdentifier: "ProfileAvatarCell") as? ProfileAvatarCell else {
                    return UITableViewCell()
                }
                cell.profileInfoLabel.text = fixSectionFieldList[indexPath.row]
                cell.profileAvatarView.kf.setImage(with: URL(string: "https://fitgramer.oss-ap-southeast-1.aliyuncs.com/" + profileDataSvr.profile.avatarURL),placeholder: UIImage(named: "profile_avatar"))
                cell.profileAvatarView.layer.cornerRadius = 77/2
                cell.profileAvatarView.clipsToBounds = true
                let imageTapRecognizer =  UITapGestureRecognizer(target: self, action: #selector(showImagePickerSelection))
                cell.profileAvatarView.isUserInteractionEnabled = true
                cell.profileAvatarView.addGestureRecognizer(imageTapRecognizer)
                cell.clipsToBounds = true
                return cell
            case 1:
                guard let cell = self.rootView.profileTableView.dequeueReusableCell(withIdentifier: "ProfileTableCell") as? ProfileTableCell else {
                    return UITableViewCell()
                }
                cell.profileInfoLabel.text = fixSectionFieldList[indexPath.row]
                cell.profileInfoTextField.text = profileDataSvr.profile.nickname
                cell.profileInfoTextField.delegate = self
//                cell.profileInfoTextField.isEnabled = false
                return cell
            default:
                return UITableViewCell()
            }
        } else {
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
                let valueIndex =  ProfileDataManager.shared.profile.gender.rawValue - 1 //fix the offset of the picker index for gender
                if valueIndex > 0 && valueIndex < genderValueList.count {
                    cell.profileInfoTextField.text = genderValueList[valueIndex]
                } else {
                    cell.profileInfoTextField.text = genderValueList[0]
                }
                cell.profileInfoTextField.delegate = self
                break
            case 1://birthYear
                birthdayPicker.tag = birthdayIndex
                cell.profileInfoTextField.inputView = birthdayPicker
                cell.profileInfoTextField.text = String(ProfileDataManager.shared.profile.birthYear)
                cell.profileInfoTextField.delegate = self
                birthdayPicker.selectRow(20, inComponent: 0, animated: false)
                break
            case 2://height
                cell.profileInfoTextField.keyboardType = .decimalPad
                cell.profileInfoTextField.text = String(ProfileDataManager.shared.profile.height)
                cell.profileUnitLabel.text = "cm"
                cell.profileInfoTextField.delegate = self
                break
            case 3://weight
                cell.profileInfoTextField.keyboardType = .decimalPad
                cell.profileInfoTextField.text = String(ProfileDataManager.shared.profile.weight)
                cell.profileUnitLabel.text = "kg"
                cell.profileInfoTextField.delegate = self
                break
            case 4://actvity level
                activityLevelPicker.tag = activityIndex
                cell.profileInfoTextField.inputView = activityLevelPicker
                if ProfileDataManager.shared.profile.activityLevel != .unknownLevel {
                    cell.profileInfoTextField.text = activityLevelValueList[ProfileDataManager.shared.profile.activityLevel.rawValue - 1]
                }
                cell.profileInfoTextField.delegate = self
                break
            default:
                break
            }
            return cell
        }
    }
    
    @objc func showImagePickerSelection(){
        let optionMenu = UIAlertController(title: nil, message: "Option", preferredStyle: .actionSheet)
        let cameraOption  = UIAlertAction(title: "Camera", style: .default) { (alertAction) in
            self.openCamera()
            optionMenu.dismiss(animated: true, completion: nil)
        }
        let galleryOption  = UIAlertAction(title: "Album", style: .default) { (alertAction) in
            self.openAlbum()
            optionMenu.dismiss(animated: true, completion: nil)
        }
        let cancelOption  = UIAlertAction(title: "Cancel", style: .cancel) { (alertAction) in
            optionMenu.dismiss(animated: true, completion: nil)
        }
        optionMenu.addAction(cameraOption)
        optionMenu.addAction(galleryOption)
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
               let alert = UIAlertController.init(title: "Message", message: "Cannot open album", preferredStyle: .alert)
               let cancel = UIAlertAction.init(title: "Confirm", style: .cancel, handler: nil)
               alert.addAction(cancel)
               self.show(alert, sender: nil)
           }
       }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else {
            return
        }
        let compressedImage = selectedImage.resized(withPercentage: 0.2)!
         DispatchQueue.main.async {
            guard let userId = UserDefaults.standard.string(forKey: Constants.userIdKey) else {
                       return
            }
            picker.dismiss(animated: true, completion: nil)
            let timeStamp = String(Int(Date().timeIntervalSince1970 * 1000))
            let objectKey = "portrait_" + userId + "_" + timeStamp
            UploaderManager.shared.asyncPutPortraitImage(objectKey: objectKey, image: compressedImage) { (objectKey) in
                self.profileDataSvr.profile.avatarURL = objectKey
                DispatchQueue.main.async {
                    guard let cell = self.rootView.profileTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ProfileAvatarCell else {
                        return
                    }
                    self.updateProfileData()
                    cell.profileAvatarView.layer.cornerRadius =  cell.profileAvatarView.frame.width/2
                    cell.profileAvatarView.clipsToBounds = true
                    cell.profileAvatarView.image = selectedImage
                }
            }
        }
        
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
        let indexPath = IndexPath(row: pickerView.tag, section: 1)
        guard let cell = self.rootView.profileTableView.cellForRow(at: indexPath) as? ProfileTableCell else {
            return
        }
        switch pickerView.tag {
        case genderIndex:
            ProfileDataManager.shared.profile.gender =  Apisvr_Gender.init(rawValue: row + 1)!
            cell.profileInfoTextField.text = genderValueList[row]
            break
        case birthdayIndex:
            ProfileDataManager.shared.profile.birthYear = Int32(1970 + row)
            cell.profileInfoTextField.text = String(1970 + row)
            break
        case activityIndex:
            ProfileDataManager.shared.profile.activityLevel = Apisvr_ActivityLevel.init(rawValue: row + 1)!
            cell.profileInfoTextField.text = activityLevelValueList[row]
            break
        default:
            break
        }
//        self.updateProfileToStorage()
//        self.updateProfileData()
    }
    
    
}
