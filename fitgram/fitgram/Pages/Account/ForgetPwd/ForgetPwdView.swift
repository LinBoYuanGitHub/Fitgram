//
//  ForgetPwdView.swift
//  fitgram
//
//  Created by boyuan lin on 19/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class ForgetPwdView:UIView {
    public var forgetPwdLabel = UILabel()
    public var forgetPwdContainer = UIView()
    public var phonePrefixTextField = UITextField()
    public var phoneNumTextField = UITextField()
    public var nextStepBtn = UIButton()
    
    convenience init(){
        self.init(frame: .zero)
        self.backgroundColor = UIColor(red: 138/255, green: 97/255, blue: 22/255, alpha: 1)
        sv(
            forgetPwdLabel,
            forgetPwdContainer.sv(
                phonePrefixTextField,
                phoneNumTextField
            ),
            nextStepBtn
        )
        layout(
            200,
            |-32-forgetPwdLabel-32-|,
            10,
            |-32-forgetPwdContainer-32-| ~ 50,
            20,
            |-32-nextStepBtn-32-| ~ 50
        )
        layout(
            |-16-phonePrefixTextField.width(50)-32-phoneNumTextField-16-| ~ 50
        )
        //attribute setting
        forgetPwdLabel.font = UIFont(name: "PingFangSC-Regular", size: 36)
        forgetPwdLabel.textColor = .white
        forgetPwdLabel.text = "忘记密码"
        forgetPwdContainer.backgroundColor = .white
        forgetPwdContainer.layer.cornerRadius = 20
        forgetPwdContainer.layer.masksToBounds = true
        forgetPwdContainer.alpha = 0.35
        //phone num textfield
        phoneNumTextField.attributedPlaceholder =  NSAttributedString(string: "输入手机号码", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        phoneNumTextField.textAlignment = .left
        phoneNumTextField.textColor = .lightGray
        phoneNumTextField.keyboardType = .decimalPad
        //forget password page
        phonePrefixTextField.text = "+86"
        phonePrefixTextField.textColor = .lightGray
        phonePrefixTextField.rightView = UIImageView(image: UIImage(named: ""))
        //button setup
        nextStepBtn.setTitle("下一步", for: .normal)
        nextStepBtn.backgroundColor  = UIColor(red: 80/255, green: 184/255, blue: 60/255, alpha: 0.5)
        nextStepBtn.layer.cornerRadius = 20
        nextStepBtn.layer.masksToBounds = true
        nextStepBtn.titleLabel?.textColor = .white
        
        
    }
}
