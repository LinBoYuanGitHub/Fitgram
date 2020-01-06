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
        let token = UserDefaults.standard.string(forKey: Constants.tokenKey)
        if (token == nil || token!.isEmpty) {
            self.loginForTokenRequest()
        } else {
            self.naviToHomeTabPage()
        }
        self.view.backgroundColor = .white
        let logoView = UIImageView(image: UIImage(named: "AppIcon"))
        logoView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        logoView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        logoView.image = UIImage(named: "launchPagePic")
        self.view.addSubview(logoView)
    }
    
    func loginForTokenRequest(){
        do {
            try LoginDataManager.shared.anonymousLogin(){ isSuccess in
                if isSuccess {
                    //redirect to home navi controller
                   self.naviToHomeTabPage()
                } else {
                    print("login failed")
                }
            }
        } catch {
            print(error)
        }
        
    }
    
    func naviToHomeTabPage(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let naviVC = UINavigationController()
            naviVC.viewControllers = [HomeTabViewController()]
            self.present(naviVC, animated: true, completion: nil)
        }
//        DispatchQueue.main.async {
//            let naviVC = UINavigationController()
//            naviVC.viewControllers = [HomeTabViewController()]
//            self.present(naviVC, animated: true, completion: nil)
//        }
    }
}
