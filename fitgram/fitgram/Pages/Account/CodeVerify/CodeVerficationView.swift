//
//  CodeVerficationView.swift
//  fitgram
//
//  Created by boyuan lin on 19/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia
import KWVerificationCodeView

class CodeVerificationView: UIView{
    public var confirmBtn =  UIButton()
    public var verficationLabel = UILabel()
    public var DescLabel = UILabel()
    public var verficationCodeTextField = KWVerificationCodeView()
    public var countDownLabel = UILabel()
    
    convenience init(){
        self.init(frame: .zero)
        self.backgroundColor = UIColor(red: 138/255, green: 97/255, blue: 22/255, alpha: 1)
        sv(
            verficationLabel,
            DescLabel,
            verficationCodeTextField,
            confirmBtn,
            countDownLabel
        )
        layout(
            200,
            |-32-verficationLabel-32-|,
            20,
            |-32-DescLabel-32-| ~ 50,
            20,
            |-32-verficationCodeTextField-32-| ~ 60,
            20,
            |-32-confirmBtn-32-| ~ 50,
            20,
            |-32-countDownLabel-32-|
        )
        verficationCodeTextField.frame.size = CGSize(width: UIScreen.main.bounds.width - 64, height: 60)
        verficationCodeTextField.digits = 4
        verficationCodeTextField.textFont = "PingFangSC-Regualr"
        verficationCodeTextField.textSize = 22
        verficationCodeTextField.keyboardType = .numberPad
        verficationCodeTextField.isTappable = true
        verficationCodeTextField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.35)
        verficationCodeTextField.layer.cornerRadius = 10
        verficationCodeTextField.layer.masksToBounds = true
        verficationCodeTextField.textColor = .white
        verficationCodeTextField.focus()
        verficationLabel.font = UIFont(name: "PingFangSC-Medium", size: 30)
        verficationLabel.textColor = .white
        verficationLabel.text = "输入验证码"
        DescLabel.font = UIFont(name: "PingFangSC-Medium", size: 14)
        DescLabel.textColor = .white
        confirmBtn.setTitle("确认", for: .normal)
        confirmBtn.backgroundColor  = UIColor(red: 80/255, green: 184/255, blue: 60/255, alpha: 0.5)
        confirmBtn.layer.cornerRadius = 20
        confirmBtn.layer.masksToBounds = true
        confirmBtn.titleLabel?.textColor = .white
    }
    
}
