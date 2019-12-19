//
//  GenderViewController.swift
//  fitgram
//
//  Created by boyuan lin on 19/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class GenderViewController: UIViewController {
    
    var progressBar = UIProgressView(progressViewStyle: .bar)
    
    var titleLabel = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.height/5, width: UIScreen.main.bounds.width, height: 30))
    var femaleBtn = UIButton(frame: CGRect(x: 32, y: UIScreen.main.bounds.height/2 - 50, width: 130, height: 130))
    var maleBtn  = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 162, y: UIScreen.main.bounds.height/2 - 50 , width: 130, height: 130))
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        titleLabel.text = "你的性别?"
        titleLabel.font  = UIFont(name: "PingFangSC-Medium", size: 20)
        titleLabel.textAlignment = .center
        
        maleBtn.setImage(UIImage(named: "genderMale_unselected"), for: .normal)
        maleBtn.setImage(UIImage(named: "genderMale_selected"), for: .selected)
        femaleBtn.setImage(UIImage(named: "genderFemale_unselected"), for: .normal)
        femaleBtn.setImage(UIImage(named: "genderFemale_selected"), for: .selected)
        self.setUpProgressView()
        self.view.addSubview(progressBar)
        self.view.addSubview(titleLabel)
        self.view.addSubview(femaleBtn)
        self.view.addSubview(maleBtn)
        maleBtn.addTarget(self, action: #selector(onGenderSelected), for: .touchUpInside)
        femaleBtn.addTarget(self, action:  #selector(onGenderSelected), for: .touchUpInside)
    }
    
    func setUpProgressView() {
        self.title = "2/7"
        progressBar.frame = CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width, height: 6)
        progressBar.progress = 2/7
        progressBar.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        progressBar.progressTintColor = UIColor(red: 252/255, green: 200/255, blue: 45/255, alpha: 1)
    }
    
    @objc func onGenderSelected(sender:UIButton) {
        maleBtn.isSelected = (sender == maleBtn)
        femaleBtn.isSelected = (sender == femaleBtn)
        if sender == femaleBtn{
            ProfileDataManager.shared.profile.gender = 0
        } else {
            ProfileDataManager.shared.profile.gender = 1
        }
        let targetVC = BirthYearViewController()
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    
}
