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
    
    override func viewDidLoad() {
        self.loginForTokenRequest()
        self.view.backgroundColor = .white
    }
    
    func loginForTokenRequest(){
        do {
            try LoginDataManager.shared.anonymousLogin(){ isSuccess in
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
