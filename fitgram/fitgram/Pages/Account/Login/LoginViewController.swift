//
//  LoginViewController.swift
//  fitgram
//
//  Created by boyuan lin on 17/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{
    public var rootView: LoginView?
    private var phonePrefix = ""
    
    override func viewDidLoad() {
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
        phonePrefix = String((self.rootView?.phonePrefixTextField.text)!)
        phonePrefix.removeFirst()//remove the + string
    }
    
    override func loadView() {
        rootView = LoginView()
        rootView?.loginBtn.addTarget(self, action: #selector(onLoginBtnPressed), for: .touchUpInside)
        view = rootView
    }
    
    @objc func onLoginBtnPressed() {
        let phoneNum = String((self.rootView?.phonePrefixTextField.text)!) + String((self.rootView?.phoneNumTextField.text)!)
        LoginDataManager.shared.phoneVerification(phone: phoneNum, completition: { (isExist) in
            LoginDataManager.shared.sendVerificationCode(phone: phoneNum, purpose: 1, completion: { (isSuccess) in
                DispatchQueue.main.async {
                    if isSuccess {
                        let targetVC = CodeVerficationViewController()
                        targetVC.isExist = isExist
                        targetVC.phoneNum = (self.rootView?.phoneNumTextField.text)!
                        targetVC.phonePrefix = self.phonePrefix
                        self.navigationController?.pushViewController(targetVC, animated: true)
                    }
                }
            }, failureCompletion: { (errMsg) in
                print(errMsg)
            })
        }) { (errMsg) in
            print(errMsg)
        }
    }
    
    
    
    
}
