//
//  EnergyIntakenViewController.swift
//  fitgram
//
//  Created by boyuan lin on 19/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import SwiftGRPC

public enum TargetTrend{
    case increase
    case decrease
    case netrual
}

class EnergyIntakenViewController: BaseViewController {
    
    var titleLabel = UILabel(frame: CGRect(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 20))
    var energyLabel = UILabel(frame: CGRect(x: 0, y: 250, width: UIScreen.main.bounds.width, height: 40))
    var graphImageView = UIImageView(frame: CGRect(x: 32, y: UIScreen.main.bounds.height/2 - 100, width: UIScreen.main.bounds.width - 64, height: 200))
    var descLabel = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.height/2 + 150, width: UIScreen.main.bounds.width, height: 30))
    var initialWeight = UIButton()
    var targetWeight = UIButton()
    
    var confirmBtn = UIButton(frame: CGRect(x: 32, y:  UIScreen.main.bounds.height - 150, width: UIScreen.main.bounds.width - 64, height: 50))
    
    public var targetTrend:TargetTrend  = .increase
    public var recommendCalorie = 1200
    public var days = 28
    public var weightLoss = 4
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        titleLabel.text = "每日膳食能量推荐摄入量:"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1)
        titleLabel.font = UIFont(name: "PingFangSC-Light", size: 14)
        titleLabel.textColor = UIColor.lightGray
        energyLabel.text = "\(recommendCalorie)kcal"
        energyLabel.font = UIFont(name: "PingFangSC-Medium", size: 40)
        energyLabel.textAlignment = .center
        descLabel.font = UIFont(name: "PingFangSC-Regular", size: 18)
        descLabel.textAlignment = .center
        
        confirmBtn.setTitle("开始", for: .normal)
        confirmBtn.titleLabel?.textColor = .white
        confirmBtn.backgroundColor = UIColor(red: 252/255, green: 200/255, blue: 45/255, alpha: 1)
        confirmBtn.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 17)
        confirmBtn.layer.cornerRadius = 20
        confirmBtn.layer.masksToBounds = true
        confirmBtn.addTarget(self, action: #selector(onConfirmBtnPressed), for: .touchUpInside)
        self.buildTrendGraph()
        
        initialWeight.setBackgroundImage(UIImage(named: "whiteBox")!, for: .normal)
        initialWeight.setTitleColor(.black, for: .normal)
        initialWeight.contentEdgeInsets = UIEdgeInsets(top: -5, left: 0, bottom: 5, right: 0)
        targetWeight.setBackgroundImage(UIImage(named: "greenBox")!, for: .normal)
        targetWeight.setTitleColor(.white, for: .normal)
        targetWeight.contentEdgeInsets = UIEdgeInsets(top: -2, left: 0, bottom: 2, right: 0)
        self.view.addSubview(titleLabel)
        self.view.addSubview(energyLabel)
        self.view.addSubview(descLabel)
        self.view.addSubview(confirmBtn)
    }
    
    
    
    func buildTrendGraph() {
        switch ProfileDataManager.shared.profile.goal {
        case .loseWeight:
            graphImageView.image = UIImage(named: "weight_decrease")
            initialWeight.frame = CGRect(x: 0, y:  UIScreen.main.bounds.height/2 - 120, width: 120, height: 80)
            targetWeight.frame = CGRect(x: UIScreen.main.bounds.width - 135, y:  UIScreen.main.bounds.height/2-20 , width: 120, height: 80)
            //mock up part
            initialWeight.setTitle("\(ProfileDataManager.shared.profile.weight) kg", for: .normal)
            targetWeight.setTitle("\(Int(ProfileDataManager.shared.profile.weight) - self.weightLoss) kg", for: .normal)
            descLabel.text = "坚持\(days)天，您可减脂\(weightLoss)公斤"
            break
        case .keepFit:
            graphImageView.image = UIImage(named: "weight_neutral")
            initialWeight.frame = CGRect(x: 0, y:  UIScreen.main.bounds.height/2 - 70 , width: 120, height: 80)
            targetWeight.frame = CGRect(x: UIScreen.main.bounds.width - 135, y:  UIScreen.main.bounds.height/2 - 70 , width: 120, height: 80)
            //mock up part
            initialWeight.setTitle("\(ProfileDataManager.shared.profile.weight) kg", for: .normal)
            targetWeight.setTitle("\(ProfileDataManager.shared.profile.weight) kg", for: .normal)
            descLabel.text = "按照推荐能量摄入，保持体型"
            break
        case .gainMuscle:
            graphImageView.image = UIImage(named: "weight_increase")
            initialWeight.frame = CGRect(x: 0, y:  UIScreen.main.bounds.height/2-20 , width: 120, height: 80)
            targetWeight.frame = CGRect(x: UIScreen.main.bounds.width - 135, y:  UIScreen.main.bounds.height/2 - 120, width: 120, height: 80)
            //mock up part
            initialWeight.setTitle("\(ProfileDataManager.shared.profile.weight) kg", for: .normal)
            targetWeight.setTitle("\(Int(ProfileDataManager.shared.profile.weight) + self.weightLoss) kg", for: .normal)
            descLabel.text = "坚持\(days)天，您可增肌\(weightLoss)公斤"
            break
        default:
            break
        }
        graphImageView.contentMode = .scaleAspectFit
        self.view.addSubview(graphImageView)
        //positioning the target label
        self.view.addSubview(initialWeight)
        self.view.addSubview(targetWeight)
    }
    
    @objc func onConfirmBtnPressed() {
        ProfileDataManager.shared.updateUserProfile(completion: { (isSuccess) in
            if isSuccess {
                DispatchQueue.main.async {
                    let naviVC = UINavigationController()
                    naviVC.viewControllers = [HomeTabViewController()]
                    self.present(naviVC, animated: true, completion: nil)
                }
            }
        }) { (errMsg) in
            //TODO notify user update fialed
            print(errMsg)
            DispatchQueue.main.async {
                self.showAlertMessage(msg: errMsg)
            }
        }
    }
}
