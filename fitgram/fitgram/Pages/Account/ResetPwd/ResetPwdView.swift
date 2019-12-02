//
//  ResetPwdView.swift
//  fitgram
//
//  Created by boyuan lin on 19/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia


class ResetPwdView: UIView {
    public var resetPwdLabel = UILabel()
    public var newPwdTextField = UITextField()
    public var confirmPwdTextField = UITextField()
    public var confirmBtn = UIButton()
    
    convenience init(){
        self.init(frame: .zero)
        self.backgroundColor = UIColor(red: 138/255, green: 97/255, blue: 22/255, alpha: 1)
        sv(
            resetPwdLabel,
            newPwdTextField,
            confirmPwdTextField,
            confirmBtn
        )
        layout(
            200,
            |-32-resetPwdLabel-32-|,
            20,
            |-32-newPwdTextField-32-| ~ 50,
            20,
            |-32-confirmPwdTextField-32-| ~ 50,
            20,
            |-32-confirmBtn-32-| ~ 50
        )
        resetPwdLabel.font = UIFont(name: "PingFangSC-Medium", size: 30)
        resetPwdLabel.text = "重置密码"
        let paddingView_1: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let paddingView_2: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        newPwdTextField.attributedPlaceholder = NSAttributedString(string: "请输入至少6位密码", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        newPwdTextField.layer.cornerRadius = 20
        newPwdTextField.layer.masksToBounds = true
        newPwdTextField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.35)
        newPwdTextField.textColor = .white
        newPwdTextField.leftView = paddingView_1
        newPwdTextField.leftViewMode = .always
        confirmPwdTextField.attributedPlaceholder = NSAttributedString(string: "再次确认", attributes:  [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        confirmPwdTextField.layer.cornerRadius = 20
        confirmPwdTextField.layer.masksToBounds = true
        confirmPwdTextField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.35)
        confirmPwdTextField.textColor = .white
        confirmPwdTextField.leftView = paddingView_2
        confirmPwdTextField.leftViewMode = .always
        
        confirmBtn.setTitle("保存", for: .normal)
        confirmBtn.backgroundColor  = UIColor(red: 80/255, green: 184/255, blue: 60/255, alpha: 0.5)
        confirmBtn.layer.cornerRadius = 20
        confirmBtn.layer.masksToBounds = true
        confirmBtn.titleLabel?.textColor = .white
    }
    
    
}
