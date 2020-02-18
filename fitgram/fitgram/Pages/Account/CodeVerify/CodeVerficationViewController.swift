//
//  CodeVerficationViewController.swift
//  fitgram
//
//  Created by boyuan lin on 19/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import KWVerificationCodeView

class CodeVerficationViewController: UIViewController {
    public var rootView: CodeVerificationView!
    
    public var phoneNum:String = ""
    public var phonePrefix:String = ""
    
    public var isExist:Bool = false //judge the redirection of the page
    private var verificationCode = ""
    
    
    override func viewDidLoad() {
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
        self.rootView.verficationCodeTextField.delegate = self
    }
    
    override func loadView() {
        rootView = CodeVerificationView()
        if !phoneNum.isEmpty && !phonePrefix.isEmpty {
            self.rootView.DescLabel.text = "Please enter the verification code via \(phonePrefix) \(phoneNum)"
        }
        view = rootView
        self.rootView.confirmBtn.addTarget(self, action: #selector(sendToVerification), for: .touchUpInside)
    }

    @objc func sendToVerification(){
        LoginDataManager.shared.phoneSMSLogin(phone: (phonePrefix+phoneNum), otp: verificationCode, completition: { (isNewUser) in
            DispatchQueue.main.async {
                if isNewUser {
                    let targetVC = GoalViewController()
                    self.navigationController?.pushViewController(targetVC, animated: true)
                } else {
                    let naviVC = UINavigationController()
                    naviVC.modalPresentationStyle = .fullScreen
                    naviVC.viewControllers = [HomeTabViewController()]
                    self.present(naviVC, animated: true, completion: nil)
                }
            }
        }) { (errMsg) in
            print(errMsg)
        }
    }
}

extension CodeVerficationViewController:KWVerificationCodeViewDelegate {
    
    func didChangeVerificationCode() {
        if self.rootView.verficationCodeTextField.getVerificationCode().count == Int(self.rootView.verficationCodeTextField.digits){
            self.verificationCode = self.rootView.verficationCodeTextField.getVerificationCode()
        }
    }
}
