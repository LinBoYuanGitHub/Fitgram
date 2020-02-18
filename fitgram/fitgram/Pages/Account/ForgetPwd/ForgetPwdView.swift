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
        self.backgroundColor = .white
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
        forgetPwdLabel.textColor = .black
        forgetPwdLabel.text = "Forget Password"
        forgetPwdContainer.backgroundColor = .lightGray
        forgetPwdContainer.layer.cornerRadius = 20
        forgetPwdContainer.layer.masksToBounds = true
        forgetPwdContainer.alpha = 0.35
        //phone num textfield
        phoneNumTextField.attributedPlaceholder =  NSAttributedString(string: "Phone number", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        phoneNumTextField.textAlignment = .left
        phoneNumTextField.textColor = .white
        phoneNumTextField.keyboardType = .decimalPad
        //forget password page
        phonePrefixTextField.text = "+65"
        phonePrefixTextField.textColor = .white
        phonePrefixTextField.rightView = UIImageView(image: UIImage(named: ""))
        //button setup
        nextStepBtn.setTitle("Next", for: .normal)
        nextStepBtn.backgroundColor = UIColor(red: 252/255, green: 200/255, blue: 45/255, alpha: 1)
        nextStepBtn.layer.cornerRadius = 20
        nextStepBtn.layer.masksToBounds = true
        nextStepBtn.titleLabel?.textColor = .white
        
        
    }
}
