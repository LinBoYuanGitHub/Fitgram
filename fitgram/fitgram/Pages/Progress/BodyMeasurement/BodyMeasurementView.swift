//
//  BodyMeasurementView.swift
//  fitgram
//
//  Created by boyuan lin on 19/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class BodyMeasurementView: UIView {
    public var bodyMeasurementTableView = UITableView.init()
    public var inputBtn = UIButton()
    
    public var onInputBtnPresssedAction: () -> Void = {}
    
    convenience init(){
        self.init(frame:.zero)
        self.backgroundColor = .white
        bodyMeasurementTableView.register(BodyMeasurementCell.self, forCellReuseIdentifier: "BodyMeasurementCell")
        sv(
            inputBtn,
            bodyMeasurementTableView
        )
        layout(
            20,
            |-inputBtn-16-|,
            20,
            |-16-bodyMeasurementTableView-16-|,
            0
        )
        inputBtn.setTitle("输入全部", for: .normal)
        inputBtn.backgroundColor = .black
        inputBtn.setTitleColor(.white, for: .normal)
        inputBtn.layer.cornerRadius = 15
        inputBtn.layer.masksToBounds = true
        inputBtn.width(120)
        inputBtn.addTarget(self, action: #selector(onInputBtnPressed), for: .touchUpInside)
        //table cell
        bodyMeasurementTableView.register(BodyMeasurementCell.self, forCellReuseIdentifier: "BodyMeasurementCell")
        bodyMeasurementTableView.allowsSelection = false
        bodyMeasurementTableView.separatorStyle = .none
    }
    
    @objc func onInputBtnPressed(){
        self.onInputBtnPresssedAction()
    }
    
    
    
}
