//
//  LoginViewController.swift
//  fitgram
//
//  Created by boyuan lin on 17/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

public enum LoginType {
    case sms
    case Password
}

class LoginViewController: BaseViewController{
    public var rootView: LoginView?
    private var phonePrefix = ""
    private var loginType:LoginType = .sms
    
    
    override func viewDidLoad() {
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
        phonePrefix = String((self.rootView?.phonePrefixTextField.text)!)
        phonePrefix.removeFirst()//remove the + string
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.backBarButtonItem?.title = ""
    }
    
    override func loadView() {
        rootView = LoginView(isPasswordShow: false)
        rootView?.loginBtn.addTarget(self, action: #selector(onSMSLoginBtnPressed), for: .touchUpInside)
//        if loginType == .Password {
//            rootView = LoginView(isPasswordShow: true)
//            let rightView = UIBarButtonItem(title: "验证码登陆", style: .plain, target: self, action: #selector(toggleLoginType))
//            rightView.tintColor = .black
//            let font = UIFont(name: "PingFangSC-Regular", size: 14)
//            let attribute = [NSAttributedString.Key.font: font]
//            rightView.setTitleTextAttributes(attribute as [NSAttributedString.Key : Any], for: .normal)
//            self.navigationItem.rightBarButtonItem = rightView
//            rootView?.loginBtn.addTarget(self, action: #selector(onPasswordLoginPressed), for: .touchUpInside)
//        } else {
//            rootView = LoginView(isPasswordShow: false)
//            let rightView = UIBarButtonItem(title: "账号登陆", style: .plain, target: self, action: #selector(toggleLoginType))
//            rightView.tintColor = .black
//            let font = UIFont(name: "PingFangSC-Regular", size: 14)
//            let attribute = [NSAttributedString.Key.font: font]
//            rightView.setTitleTextAttributes(attribute as [NSAttributedString.Key : Any], for: .normal)
//            self.navigationItem.rightBarButtonItem = rightView
//            rootView?.loginBtn.addTarget(self, action: #selector(onSMSLoginBtnPressed), for: .touchUpInside)
//        }
        view = rootView
        self.rootView?.forgetPwdBtn.isHidden = true
//        self.rootView?.onForgetPwdBtnPressedEvent = {
//            let targetVC = ForgetPwdViewController()
//            self.navigationController?.pushViewController(targetVC, animated: true)
//        }
    }
    
    @objc func toggleLoginType(){
        if self.loginType == .sms {
            self.loginType = .Password
            self.loadView()
        } else {
            self.loginType = .sms
            self.loadView()
        }
    }
    
    @objc func onPasswordLoginPressed() {
        let phoneNum = String((self.rootView?.phonePrefixTextField.text)!) + String((self.rootView?.phoneNumTextField.text)!)
        let password = String((self.rootView?.phonePwdTextField.text)!)
        LoginDataManager.shared.phonePwdLogin(phone: phoneNum, password: password, completition: { (isSuccess) in
            if isSuccess {
                DispatchQueue.main.async {
                    let targetVC = HomeTabViewController()
                    self.navigationController?.pushViewController(targetVC, animated: true)
                }
            }
        }) { (errMsg) in
            DispatchQueue.main.async {
                self.showAlertMessage(msg: errMsg)
            }
        }
    }
    
    @objc func onSMSLoginBtnPressed() {
        var prefix = String((self.rootView?.phonePrefixTextField.text)!)
        prefix.removeFirst() //remove "+" char
        let phoneNum = prefix + String((self.rootView?.phoneNumTextField.text)!)
        LoginDataManager.shared.phoneVerification(phone: phoneNum, completition: { (isExist) in
//            let purpose:Apisvr_OtpType = isExist ?.loginOtp: .registerOtp
            LoginDataManager.shared.sendVerificationCode(phone: phoneNum, purpose: .loginOtp, completion: { (isSuccess) in
                DispatchQueue.main.async {
                    if isSuccess {
                        let targetVC = CodeVerficationViewController()
                        targetVC.isExist = isExist
                        targetVC.phoneNum = (self.rootView?.phoneNumTextField.text)!
                        targetVC.phonePrefix = prefix
                        self.navigationController?.pushViewController(targetVC, animated: true)
                    }
                }
            }, failureCompletion: { (errMsg) in
                DispatchQueue.main.async {
                    self.showAlertMessage(msg:errMsg)
                }
            })
        }) { (errMsg) in
            DispatchQueue.main.async {
                self.showAlertMessage(msg:errMsg)
            }
        }
    }
    
    func passwordLogin(){
        let phoneNum = String((self.rootView?.phonePrefixTextField.text)!) + String((self.rootView?.phoneNumTextField.text)!)
        var req = Apisvr_AppLoginReq()
        req.phone = phoneNum
        req.password = (self.rootView?.phonePwdTextField.text)!
        do{
            try LoginDataManager.shared.client.appLogin(req, completion: { (resp, result) in
                DispatchQueue.main.async {
                    if result.statusCode == .ok {
                        let targetVC = HomeTabViewController()
                        guard let token = resp?.token else {
                            return
                        }
                        UserDefaults.standard.set(token, forKey: Constants.tokenKey)
                        self.navigationController?.pushViewController(targetVC, animated: true)
                    } else {
                        self.showAlertMessage(msg:result.statusMessage!)
                    }
                }
            })
        } catch {
            DispatchQueue.main.async {
                self.showAlertMessage(msg: error.localizedDescription)
            }
        }
    }
    
    
    
    
}
