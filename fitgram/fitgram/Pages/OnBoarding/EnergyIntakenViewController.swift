//
//  EnergyIntakenViewController.swift
//  fitgram
//
//  Created by boyuan lin on 19/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

public enum TargetTrend{
    case increase
    case decrease
    case netrual
}

class EnergyIntakenViewController: UIViewController {
    
    var titleLabel = UILabel(frame: CGRect(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 20))
    var energyLabel = UILabel(frame: CGRect(x: 0, y: 250, width: UIScreen.main.bounds.width, height: 40))
    var graphImageView = UIImageView(frame: CGRect(x: 32, y: UIScreen.main.bounds.height/2 - 100, width: UIScreen.main.bounds.width - 64, height: 200))
    var descLabel = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.height/2 + 150, width: UIScreen.main.bounds.width, height: 30))
    var initialWeight = UILabel()
    var targetWeight = UILabel()
    
    var confirmBtn = UIButton(frame: CGRect(x: 32, y:  UIScreen.main.bounds.height - 150, width: UIScreen.main.bounds.width - 64, height: 50))
    
    public var targetTrend:TargetTrend  = .increase
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        titleLabel.text = "每日膳食能量推荐摄入量:"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1)
        titleLabel.font = UIFont(name: "PingFangSC-Light", size: 14)
        titleLabel.textColor = UIColor.lightGray
        energyLabel.text = "1200kcal"
        energyLabel.font = UIFont(name: "PingFangSC-Medium", size: 40)
        energyLabel.textAlignment = .center
        descLabel.text = "坚持28天，您可减脂4公斤"
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
        self.view.addSubview(titleLabel)
        self.view.addSubview(energyLabel)
        self.view.addSubview(descLabel)
        self.view.addSubview(confirmBtn)
    }
    
    func buildTrendGraph(){
        switch targetTrend {
        case .increase:
            graphImageView.image = UIImage(named: "weight_increase")
            break
        case .decrease:
            graphImageView.image = UIImage(named: "weight_decrease")
            break
        case .netrual:
            graphImageView.image = UIImage(named: "weight_neutral")
            break
        }
        graphImageView.contentMode = .scaleAspectFit
        self.view.addSubview(graphImageView)
    }
    
    @objc func onConfirmBtnPressed(){
        //TODO upload profile data to backend
        let naviVC = UINavigationController()
        naviVC.viewControllers = [HomeTabViewController()]
        self.present(naviVC, animated: true, completion: nil)
    }
}
