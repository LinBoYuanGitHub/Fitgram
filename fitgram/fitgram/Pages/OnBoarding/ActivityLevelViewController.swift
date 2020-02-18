//
//  ActivityLevelViewController.swift
//  fitgram
//
//  Created by boyuan lin on 19/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import SwiftGRPC

class ActivityLevelViewController: BaseViewController{
    
    public var titleLabel = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.height/5, width: UIScreen.main.bounds.width, height: 30))
    public var activityBtn_1 = UIButton(frame: CGRect(x: 60, y: UIScreen.main.bounds.height/5 + 60, width: UIScreen.main.bounds.width - 120, height: 50))
    public var activityBtn_2 = UIButton(frame: CGRect(x: 60, y: UIScreen.main.bounds.height/5 + 120, width: UIScreen.main.bounds.width - 120, height: 50))
    public var activityBtn_3 = UIButton(frame: CGRect(x: 60, y: UIScreen.main.bounds.height/5 + 180, width: UIScreen.main.bounds.width - 120, height: 50))
    public var activityBtn_4 = UIButton(frame: CGRect(x: 60, y: UIScreen.main.bounds.height/5 + 240, width: UIScreen.main.bounds.width - 120, height: 50))
    public var confirmBtn = UIButton(frame: CGRect(x: 32, y: UIScreen.main.bounds.height/5 + 350, width: UIScreen.main.bounds.width - 64, height: 50))
    
    var progressBar = UIProgressView(progressViewStyle: .bar)
    var buttons = [UIButton]()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        self.setUpProgressView()
        buttons = [activityBtn_1,activityBtn_2,activityBtn_3,activityBtn_4]
        self.titleLabel.text = "What’s your daily activity level?"
        self.titleLabel.font  = UIFont(name: "PingFangSC-Medium", size: 20)
        self.titleLabel.textAlignment = .center
        //confirm button
        confirmBtn.setTitle("Next", for: .normal)
        confirmBtn.layer.cornerRadius = 10
        confirmBtn.layer.masksToBounds = true
        confirmBtn.backgroundColor = UIColor(red: 252/255, green: 200/255, blue: 45/255, alpha: 1)
        confirmBtn.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        
        setUpActButtons(targetBtn: activityBtn_1, titleText: "Sedentary", tag:1)
        setUpActButtons(targetBtn: activityBtn_2, titleText: "Light activity", tag:2)
        setUpActButtons(targetBtn: activityBtn_3, titleText: "Moderate activity", tag:3)
        setUpActButtons(targetBtn: activityBtn_4, titleText: "Extremely active", tag:4)
        self.view.addSubview(titleLabel)
        self.view.addSubview(confirmBtn)
    }
    
    func setUpProgressView() {
        self.title = "7/7"
        progressBar.frame = CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width, height: 6)
        progressBar.progress = 7/7
        progressBar.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        progressBar.progressTintColor = UIColor(red: 252/255, green: 200/255, blue: 45/255, alpha: 1)
        self.view.addSubview(progressBar)
    }
    
    func setUpActButtons(targetBtn:UIButton,titleText:String, tag:Int){
        targetBtn.setTitle(titleText, for: .normal)
        targetBtn.adjustsImageWhenHighlighted = false
        targetBtn.setTitleColor(.white, for: .selected)
        targetBtn.setTitleColor(.black, for: .normal)
        targetBtn.layer.cornerRadius = 10
        targetBtn.layer.masksToBounds = true
        targetBtn.tag = tag
        targetBtn.setBackgroundColor(color: UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1), forState: .normal)
        targetBtn.setBackgroundColor(color: UIColor(red: 251/255, green: 200/255, blue: 45/255, alpha: 1), forState: .selected)
        targetBtn.addTarget(self, action: #selector(onOptionSelected), for: .touchUpInside)
        self.view.addSubview(targetBtn)
        buttons.append(targetBtn)
    }
    
    @objc func onOptionSelected(sender:UIButton) {
        buttons.forEach { (button) in
            button.isSelected = (button == sender)
            if button.isSelected {
                switch button.tag{
                case 1: ProfileDataManager.shared.profile.activityLevel = .extremelyInactive
                case 2: ProfileDataManager.shared.profile.activityLevel = .sedentary
                case 3: ProfileDataManager.shared.profile.activityLevel = .moderatelyActive
                case 4: ProfileDataManager.shared.profile.activityLevel = .extremelyInactive
                case 5: ProfileDataManager.shared.profile.activityLevel = .vigorouslyActive
                default: ProfileDataManager.shared.profile.activityLevel = .unknownLevel
                }
                
            }
        }
    }
    
    @objc func nextStep() {
        updateProfile()
    }
    
    func updateProfile(){
        ProfileDataManager.shared.updateUserProfile(completion: { (isSuccess) in
            if isSuccess {
                self.getGoalDetail()
            }
        }) { (errMsg) in
            //TODO notify user update fialed
            print(errMsg)
            DispatchQueue.main.async {
                self.showAlertMessage(msg: errMsg)
            }
        }
    }
    
    func getGoalDetail() {
        let req = Apisvr_GetGoalDetailsReq()
        do{
            guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                return
            }
            let metaData = try Metadata(["authorization": "Token " + token])
            try ProfileDataManager.shared.client.getGoalDetails(req, metadata: metaData) { (resp, result) in
                if result.statusCode == .ok {
                    DispatchQueue.main.async {
                        let calorie = resp?.recommendedEnergyInstake
                        let days = resp?.days
                        let weightLoss = resp?.recommendedWeightLoss
                        let targetVC = EnergyIntakenViewController()
                        targetVC.recommendCalorie = Int(calorie!)
                        targetVC.days = Int(days!)
                        targetVC.weightLoss =  Int(weightLoss!)
                        self.navigationController?.pushViewController(targetVC, animated: true)
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
    
}
