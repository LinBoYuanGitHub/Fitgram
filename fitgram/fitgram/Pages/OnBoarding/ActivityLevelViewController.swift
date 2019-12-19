//
//  ActivityLevelViewController.swift
//  fitgram
//
//  Created by boyuan lin on 19/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class ActivityLevelViewController: UIViewController{
    
    public var titleLabel = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.height/5, width: UIScreen.main.bounds.width, height: 30))
    public var activityBtn_1 = UIButton(frame: CGRect(x: 60, y: UIScreen.main.bounds.height/5 + 60, width: UIScreen.main.bounds.width - 120, height: 50))
    public var activityBtn_2 = UIButton(frame: CGRect(x: 60, y: UIScreen.main.bounds.height/5 + 120, width: UIScreen.main.bounds.width - 120, height: 50))
    public var activityBtn_3 = UIButton(frame: CGRect(x: 60, y: UIScreen.main.bounds.height/5 + 180, width: UIScreen.main.bounds.width - 120, height: 50))
    public var activityBtn_4 = UIButton(frame: CGRect(x: 60, y: UIScreen.main.bounds.height/5 + 240, width: UIScreen.main.bounds.width - 120, height: 50))
    public var confirmBtn = UIButton(frame: CGRect(x: 32, y: UIScreen.main.bounds.height/5 + 350, width: UIScreen.main.bounds.width - 64, height: 50))
    
    var buttons = [UIButton]()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        buttons = [activityBtn_1,activityBtn_2,activityBtn_3,activityBtn_4]
        self.titleLabel.text = "你的日常运动量"
        self.titleLabel.font  = UIFont(name: "PingFangSC-Medium", size: 20)
        self.titleLabel.textAlignment = .center
        //confirm button
        confirmBtn.setTitle("下一步", for: .normal)
        confirmBtn.layer.cornerRadius = 10
        confirmBtn.layer.masksToBounds = true
        confirmBtn.backgroundColor = UIColor(red: 252/255, green: 200/255, blue: 45/255, alpha: 1)
        confirmBtn.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        
        setUpActButtons(targetBtn: activityBtn_1, titleText: "卧床休息", tag:1)
        setUpActButtons(targetBtn: activityBtn_2, titleText: "轻度,静坐少动", tag:2)
        setUpActButtons(targetBtn: activityBtn_3, titleText: "中度,常常走动", tag:3)
        setUpActButtons(targetBtn: activityBtn_4, titleText: "重度,负重", tag:4)
        self.view.addSubview(titleLabel)
        self.view.addSubview(confirmBtn)
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
    
    @objc func onOptionSelected(sender:UIButton){
        buttons.forEach { (button) in
            button.isSelected = (button == sender)
            if button.isSelected {
                 ProfileDataManager.shared.profile.activityLevel = Int32(button.tag)
            }
        }
    }
    
    @objc func nextStep(){
        let targetVC = EnergyIntakenViewController()
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
}
