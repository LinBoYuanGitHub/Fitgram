//
//  ForgetPasswordViewController.swift
//  fitgram
//
//  Created by boyuan lin on 19/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class ForgetPwdViewController: UIViewController {
    public var rootView: ForgetPwdView?
    
    override func viewDidLoad() {
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
    }
    
    override func loadView() {
        rootView = ForgetPwdView()
        view = rootView
    }
}
