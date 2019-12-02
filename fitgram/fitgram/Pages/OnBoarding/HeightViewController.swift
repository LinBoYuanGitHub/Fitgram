//
//  HeightViewController.swift
//  fitgram
//
//  Created by boyuan lin on 19/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class HeightViewController: UIViewController {
    var progressBar = UIProgressView(progressViewStyle: .bar)
    var titleLabel = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.height/5, width: UIScreen.main.bounds.width, height: 30))
    var heightTextField = UITextField(frame: CGRect(x: Int(UIScreen.main.bounds.width/2 - 50), y: Int(UIScreen.main.bounds.height/5 + 50), width: 100, height: 50))
    var unitLabel = UILabel(frame: CGRect(x: Int(UIScreen.main.bounds.width/2 + 70), y: Int(UIScreen.main.bounds.height/5 + 80), width: 30, height: 30))
    var confirmBtn = UIButton(frame: CGRect(x: 32, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width - 64, height: 50))
    
    override func viewDidLoad() {
        setUpProgressView()
        self.view.backgroundColor = .white
        self.titleLabel.text = "你的身高"
        self.titleLabel.font  = UIFont(name: "PingFangSC-Medium", size: 20)
        self.titleLabel.textAlignment = .center
        
        unitLabel.text = "cm"
        unitLabel.font = UIFont(name: "PingFangSC-Regular", size: 14)
        heightTextField.font = UIFont(name: "PingFangSC-Regular", size: 30)
        heightTextField.textAlignment = .center
        heightTextField.keyboardType = .decimalPad
        self.addBottomLine(targetTextField: heightTextField)
        
        confirmBtn.setTitle("下一步", for: .normal)
        confirmBtn.layer.cornerRadius = 10
        confirmBtn.layer.masksToBounds = true
        confirmBtn.backgroundColor = UIColor(red: 252/255, green: 200/255, blue: 45/255, alpha: 1)
        confirmBtn.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        self.view.addSubview(progressBar)
        self.view.addSubview(titleLabel)
        self.view.addSubview(heightTextField)
        self.view.addSubview(unitLabel)
        self.view.addSubview(confirmBtn)
    }
    
    func addBottomLine(targetTextField: UITextField){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x:0.0, y: 60, width:100, height:1.0)
        bottomLine.backgroundColor = UIColor.black.cgColor
        targetTextField.borderStyle = .none
        targetTextField.layer.addSublayer(bottomLine)
    }
    
    func setUpProgressView() {
        self.title = "4/7"
        progressBar.frame = CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width, height: 6)
        progressBar.progress = 4/7
        progressBar.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        progressBar.progressTintColor = UIColor(red: 252/255, green: 200/255, blue: 45/255, alpha: 1)
    }
    
    @objc func nextStep(){
        let targetVC = WeightViewController()
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
}
