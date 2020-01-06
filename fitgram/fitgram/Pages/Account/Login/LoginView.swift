//
//  LoginView.swift
//  fitgram
//
//  Created by boyuan lin on 17/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class LoginView:UIView {
    public var phonePrefixTextField = UITextField()
    public var phoneNumTextField = UITextField()
    public var loginBtn = UIButton()
    public var phoneContainer = UIView()
    public var passwordContainer = UIView()
    public var phonePwdTextField = UITextField()
    //constant labels
    public var titleLabel = UILabel()
    public var descLabel = UILabel()
    public var forgetPwdBtn = UIButton()
    
    public var onForgetPwdBtnPressedEvent: () -> Void = {}
    
    convenience init(isPasswordShow:Bool) {
        self.init(frame: .zero)
        self.backgroundColor = .white
        sv(
            titleLabel,
            descLabel,
            phoneContainer.sv(
                phonePrefixTextField,
                phoneNumTextField
            ),
            passwordContainer.sv(
                phonePwdTextField
            ),
            loginBtn,
            forgetPwdBtn
        )
        //password show render
        if isPasswordShow {
            layout(
                200,
                |-32-titleLabel-32-|,
                20,
                |-32-descLabel-32-|,
                10,
                |-32-phoneContainer-32-| ~ 50,
                10,
                |-32-passwordContainer-32-| ~ 50,
                10,
                |-32-loginBtn-32-| ~ 50,
                10,
                |-forgetPwdBtn.width(60)-| ~ 40
            )
        } else {
            layout(
                200,
                |-32-titleLabel-32-|,
                20,
                |-32-descLabel-32-|,
                10,
                |-32-phoneContainer-32-| ~ 50,
                20,
                |-32-loginBtn-32-| ~ 50,
                10,
                |-forgetPwdBtn.width(60)-| ~ 40
            )
        }
        layout(
            |-16-phonePrefixTextField.width(55)-32-phoneNumTextField-16-| ~ 50
        )
        layout(
            |-16-phonePwdTextField-16-| ~ 50
        )
        //attribute setting
        titleLabel.font = UIFont(name: "PingFangSC-Regular", size: 36)
        titleLabel.textColor = .black
        titleLabel.text = "手机登录"
        
        phoneContainer.backgroundColor = .lightGray
        phoneContainer.layer.cornerRadius = 20
        phoneContainer.layer.masksToBounds = true
        phoneContainer.alpha = 0.35
        
        passwordContainer.backgroundColor = .lightGray
        passwordContainer.layer.cornerRadius = 20
        passwordContainer.layer.masksToBounds = true
        passwordContainer.alpha = 0.35
//        passwordContainer.isHidden = true
        
        loginBtn.setTitle("登陆", for: .normal)
        loginBtn.backgroundColor  =  UIColor(red: 252/255, green: 200/255, blue: 45/255, alpha: 1)
        loginBtn.layer.cornerRadius = 20
        loginBtn.layer.masksToBounds = true
        loginBtn.titleLabel?.textColor = .white
        loginBtn.setBackgroundColor(color:  UIColor(red: 252/255, green: 200/255, blue: 45/255, alpha: 0.5), forState: .disabled)
        loginBtn.setBackgroundColor(color:  UIColor(red: 252/255, green: 200/255, blue: 45/255, alpha: 1), forState: .normal)
        loginBtn.isEnabled = true
        
        phoneNumTextField.font = UIFont(name: "PingFangSC-Regular", size: 17)
        phoneNumTextField.attributedPlaceholder =  NSAttributedString(string: "输入手机号码", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        phoneNumTextField.textAlignment = .left
        phoneNumTextField.textColor = .white
        phoneNumTextField.keyboardType = .decimalPad
        phonePrefixTextField.text = "+65"
        phonePrefixTextField.textColor = .white
        phonePrefixTextField.isEnabled = false
        let rightView = UIImageView(image: UIImage(named: "white_dropdown_arrow"))
        rightView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        phonePrefixTextField.rightView = rightView
        phonePrefixTextField.rightViewMode = .always
        
        phonePwdTextField.font = UIFont(name: "PingFangSC-Regular", size: 17)
        phonePwdTextField.attributedPlaceholder =  NSAttributedString(string: "输入密码", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        phonePwdTextField.isSecureTextEntry = true
        phonePwdTextField.textAlignment = .left
        phonePwdTextField.textColor = .white
        
        forgetPwdBtn.centerHorizontally()
        let titleString = NSMutableAttributedString(string: "忘记密码")
        titleString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: 4))
        titleString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: 4))
        forgetPwdBtn.setAttributedTitle(titleString, for: .normal)
        forgetPwdBtn.setTitle("忘记密码", for: .normal)
        forgetPwdBtn.titleLabel?.font = UIFont(name: "PingFangSC-Medium", size: 14)
        forgetPwdBtn.addTarget(self, action: #selector(onForgetPwdBtnPressed), for: .touchUpInside)
    }
    
    @objc func onForgetPwdBtnPressed(){
        self.onForgetPwdBtnPressedEvent()
    }
    
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        let size = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: CGPoint.zero, size: size))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        setBackgroundImage(colorImage, for: forState)
    }
}

