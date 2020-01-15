//
//  coachDetaiViewController.swift
//  fitgram
//
//  Created by boyuan lin on 10/1/20.
//  Copyright © 2020 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class CoachDetailViewController: UIViewController{
    public var rootView: CoachDetailView!
    
    override func viewDidLoad() {
        self.title = "教练"
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func loadView() {
        rootView = CoachDetailView()
        view = rootView
        mockUpCoachData()
    }
    
    func mockUpCoachData(){
        rootView.coachPortraitImageView.image = UIImage(named: "coachSamplePortrait")
        rootView.coachNameLabel.text = "Sophia May"
        rootView.locationNameLabel.text = "新加坡"
        rootView.gymInfoLabel.text = "裕廊随时健身俱乐部的私人教练"
        rootView.expTextLabel.text = "行业经验"
        rootView.expYearLabel.text = "1年"
        rootView.certificationLabel.text = "资质"
        rootView.certificationCourseLabel.text = "ISA认证的私人教练课程"
        rootView.termsConditionTextView.text = "您的教练会对您的饮食和健身情况进行管理，添加教练意味着您同意将身体数据、饮食数据及健身数据权限开放给您的教练。"
    }
    
    
    func requestCoachInfoDetail(){
        
    }

    
}
