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
    //constant labels
    public var titleLabel = UILabel()
    public var descLabel = UILabel()
    
    convenience init(){
        self.init(frame: .zero)
        self.backgroundColor = UIColor(red: 138/255, green: 97/255, blue: 22/255, alpha: 1)
        sv(
            titleLabel,
            descLabel,
            phoneContainer.sv(
                phonePrefixTextField,
                phoneNumTextField
            ),
            loginBtn
        )
        layout(
            200,
            |-32-titleLabel-32-|,
            20,
            |-32-descLabel-32-|,
            10,
            |-32-phoneContainer-32-| ~ 50,
            20,
            |-32-loginBtn-32-| ~ 50
        )
        layout(
            |-16-phonePrefixTextField.width(50)-32-phoneNumTextField-16-| ~ 50
        )
        //attribute setting
        titleLabel.font = UIFont(name: "PingFangSC-Regular", size: 36)
        titleLabel.textColor = .white
        titleLabel.text = "手机登录"
        
        phoneContainer.backgroundColor = .lightGray
        phoneContainer.layer.cornerRadius = 20
        phoneContainer.layer.masksToBounds = true
        phoneContainer.alpha = 0.35
        
        loginBtn.setTitle("登陆", for: .normal)
        loginBtn.backgroundColor  = UIColor(red: 80/255, green: 184/255, blue: 60/255, alpha: 0.5)
        loginBtn.layer.cornerRadius = 20
        loginBtn.layer.masksToBounds = true
        loginBtn.titleLabel?.textColor = .white
        loginBtn.setBackgroundColor(color:  UIColor(red: 80/255, green: 184/255, blue: 60/255, alpha: 0.5), forState: .disabled)
        loginBtn.setBackgroundColor(color:  UIColor(red: 80/255, green: 184/255, blue: 60/255, alpha: 1), forState: .normal)
        loginBtn.isEnabled = true
        
        phoneNumTextField.font = UIFont(name: "PingFangSC-Regular", size: 17)
        phoneNumTextField.attributedPlaceholder =  NSAttributedString(string: "输入手机号码", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        phoneNumTextField.textAlignment = .left
        phoneNumTextField.textColor = .white
        phoneNumTextField.keyboardType = .decimalPad
        phonePrefixTextField.text = "+65"
        phoneNumTextField.rightView = UIImageView(image: UIImage(named: ""))
        phonePrefixTextField.textColor = .white
        phonePrefixTextField.rightView = UIImageView(image: UIImage(named: "phone_arrow_down"))
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

