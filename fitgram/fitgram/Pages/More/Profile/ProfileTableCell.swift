//
//  ProfileTableCell.swift
//  fitgram
//
//  Created by boyuan lin on 18/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class ProfileTableCell:UITableViewCell {
    let profileInfoLabel = UILabel()
    let profileInfoTextField = UITextField()
    let profileUnitLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       sv(
            profileInfoLabel,
            profileInfoTextField,
            profileUnitLabel
        )
        layout(
            |-32-profileInfoLabel-profileInfoTextField-1-profileUnitLabel-32-|
        )
        self.backgroundColor = .white
        profileInfoLabel.centerVertically()
        profileInfoLabel.font = UIFont(name: "PingFangSC-Regular", size: 17)
        profileInfoLabel.textColor = .black
        profileInfoLabel.sizeToFit()
        
        profileInfoTextField.width(self.frame.width/2)
        profileInfoTextField.height(self.frame.height)
        profileInfoTextField.textAlignment = .right
        profileInfoTextField.textColor = .gray
        let cancelToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        cancelToolbar.barStyle = .default
        let finishButtonItem = UIBarButtonItem(title: "Confirm", style: .plain, target: self, action: #selector(dismissPad))
        finishButtonItem.setTitleTextAttributes([.font:UIFont.systemFont(ofSize: 16, weight: .bold), .foregroundColor : UIColor(red: 68/255, green: 173/255, blue: 47/255, alpha: 1)], for: .normal)
        finishButtonItem.setTitleTextAttributes([.font:UIFont.systemFont(ofSize: 16, weight: .light), .foregroundColor : UIColor(red: 68/255, green: 173/255, blue: 47/255, alpha: 0.8)], for: .selected)
        cancelToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            finishButtonItem]
        cancelToolbar.sizeToFit()
        profileInfoTextField.inputAccessoryView = cancelToolbar
        profileInfoTextField.addTarget(self, action: #selector(dismissPad), for: .touchUpOutside)
        
        profileUnitLabel.font = UIFont(name: "PingFangSC-Light", size: 13)
        profileUnitLabel.textColor = .gray
    }
    
    @objc func dismissPad(){
        profileInfoTextField.endEditing(true)
    }
}
