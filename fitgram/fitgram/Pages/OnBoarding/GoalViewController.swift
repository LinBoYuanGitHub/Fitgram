//
//  GoalViewController.swift
//  fitgram
//
//  Created by boyuan lin on 19/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class GoalViewController: UIViewController {
    
    var progressBar = UIProgressView(progressViewStyle: .bar)
    
    var logoImageView = UIImageView(frame: CGRect(x: Double(UIScreen.main.bounds.width - 33), y: 50, width: 66, height: 66))
    var goalTitleLabel = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.height/5, width: UIScreen.main.bounds.width, height: 30))
    
    var targetBtn_1 = UIButton(frame: CGRect(x: 32, y: Double(UIScreen.main.bounds.height/5 + 120), width: Double(UIScreen.main.bounds.width - 64), height: 80))
    var targetBtn_2 = UIButton(frame: CGRect(x: 32, y: Double(UIScreen.main.bounds.height/5 + 240), width: Double(UIScreen.main.bounds.width - 64), height: 80))
    var targetBtn_3 = UIButton(frame: CGRect(x: 32, y: Double(UIScreen.main.bounds.height/5 + 360), width: Double(UIScreen.main.bounds.width - 64), height: 80))
    
    let backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    private let textFont = UIFont(name: "PingFangSC-Medium", size: 20)
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.backgroundColor = .white
        backgroundImage.image = UIImage(named: "registration_background")
        self.setUpProgressView()
        self.view.addSubview(progressBar)
        self.view.addSubview(logoImageView)
        self.view.addSubview(goalTitleLabel)
        self.view.addSubview(targetBtn_1)
        self.view.addSubview(targetBtn_2)
        self.view.addSubview(targetBtn_3)
        self.view.addSubview(backgroundImage)
        self.view.sendSubviewToBack(backgroundImage)
        self.setUpView()
    }
    
    func setUpProgressView() {
        self.title = "1/7"
        progressBar.frame = CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width, height: 6)
        progressBar.progress = 1/7
        progressBar.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        progressBar.progressTintColor = UIColor(red: 252/255, green: 200/255, blue: 45/255, alpha: 1)
    }
    
    func setUpView() {
        goalTitleLabel.text = "您的健身目标"
        goalTitleLabel.textAlignment = .center
        goalTitleLabel.font = textFont
        
        setUpButtonAttribute(targetBtn: targetBtn_1, title: "减脂", tag: 1)
        setUpButtonAttribute(targetBtn: targetBtn_2, title: "塑形", tag: 2)
        setUpButtonAttribute(targetBtn: targetBtn_3, title: "增肌", tag: 3)
    }
    
    func setUpButtonAttribute(targetBtn:UIButton, title:String, tag:Int) {
        targetBtn.setTitle(title, for: .normal)
        targetBtn.layer.cornerRadius = 10
        targetBtn.titleLabel?.font = textFont
        targetBtn.setTitleColor(.black, for: .normal)
        targetBtn.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        targetBtn.tag = tag
        targetBtn.addTarget(self, action: #selector(onGoalSelected), for: .touchUpInside)
    }
    
    @objc func onGoalSelected(sender:UIButton){
        let tag = sender.tag
        ProfileDataManager.shared.profile.goal = Int32(tag)
        let targetVC = GenderViewController()
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    
}
