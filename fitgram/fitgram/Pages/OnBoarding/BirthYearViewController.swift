//
//  BirthYearViewController.swift
//  fitgram
//
//  Created by boyuan lin on 19/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class BirthYearViewController: UIViewController {
    
    var progressBar = UIProgressView(progressViewStyle: .bar)
    var titleLabel = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.height/5, width: UIScreen.main.bounds.width, height: 30))
    var yearLabel = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.height/5 + 60, width: UIScreen.main.bounds.width, height: 50))
    var yearPicker = UIPickerView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height/5 + 130, width:  UIScreen.main.bounds.width, height: 300))
    var confirmBtn = UIButton(frame: CGRect(x: 32, y:  Double(UIScreen.main.bounds.height - 150), width: Double(UIScreen.main.bounds.width - 64), height: 50))
    
    var yearList = [Int]()
    var defaultYear = 1990
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        self.titleLabel.text = "你的出生年份?"
        self.titleLabel.font  = UIFont(name: "PingFangSC-Medium", size: 20)
        self.titleLabel.textAlignment = .center
        self.yearLabel.textAlignment = .center
        self.yearLabel.font = UIFont(name: "PingFangSC-Regular", size: 48)
        confirmBtn.setTitle("下一步", for: .normal)
        confirmBtn.layer.cornerRadius = 10
        confirmBtn.layer.masksToBounds = true
        confirmBtn.backgroundColor = UIColor(red: 252/255, green: 200/255, blue: 45/255, alpha: 1)
        confirmBtn.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        
        self.setUpProgressView()
        self.view.addSubview(progressBar)
        self.view.addSubview(titleLabel)
        self.view.addSubview(yearLabel)
        self.view.addSubview(yearPicker)
        self.view.addSubview(confirmBtn)
        self.setUpYearData()
        yearPicker.delegate = self
        yearPicker.dataSource = self
    }
    
    func setUpProgressView() {
        self.title = "3/7"
        progressBar.frame = CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width, height: 6)
        progressBar.progress = 3/7
        progressBar.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        progressBar.progressTintColor = UIColor(red: 252/255, green: 200/255, blue: 45/255, alpha: 1)
    }
    
    func setUpYearData(){
        let date = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: date)
        for year in 1970...currentYear {
            yearList.append(year)
        }
        yearLabel.text = String(defaultYear)
        let rowNum = defaultYear - 1970
        yearPicker.reloadAllComponents()
        DispatchQueue.main.async {
             self.yearPicker.selectRow(rowNum, inComponent: 0, animated: false)
        }
    }
    
    @objc func nextStep(){
        let targetVC = HeightViewController()
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
}

extension BirthYearViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return yearList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(yearList[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.yearLabel.text = String(yearList[row])
    }
    
    
}
