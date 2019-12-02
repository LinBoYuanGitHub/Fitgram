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
    
    override func viewDidLoad() {
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
    }
    
    override func loadView() {
        rootView = LoginView()
        view = rootView
    }
    
    
    
    
    
    
}
