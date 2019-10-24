//
//  launchPageViewControler.swift
//  fitgram
//
//  Created by boyuan lin on 21/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class LaunchPageViewController: UIViewController {
    //set it as launch screen
    let loginManager = LoginDataManager()
    
    override func viewDidLoad() {
        self.loginForTokenRequest()
//        DispatchQueue.main.async {
//            let naviVC = UINavigationController()
//            naviVC.viewControllers = [HomeTabViewController()]
//            self.present(naviVC, animated: true, completion: nil)
//        }
        self.view.backgroundColor = .white
    }
    
    func loginForTokenRequest(){
        do {
            try loginManager.anonymousLogin(){ isSuccess in
                if isSuccess {
                    //redirect to home navi controller
                    DispatchQueue.main.async {
                        let naviVC = UINavigationController()
                        naviVC.viewControllers = [HomeTabViewController()]
                        self.present(naviVC, animated: true, completion: nil)
                    }
                } else {
                    print("login failed")
                }
            }
        } catch {
            print(error)
        }
        
    }
}
