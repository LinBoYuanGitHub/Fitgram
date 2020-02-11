//
//  coachDetaiViewController.swift
//  fitgram
//
//  Created by boyuan lin on 10/1/20.
//  Copyright © 2020 boyuan lin. All rights reserved.
//

import UIKit
import Stevia
import SwiftGRPC

class CoachContractViewController: UIViewController{
    public var rootView: CoachContractView!
    public var coachId = 0
    
    override func viewDidLoad() {
        self.title = "教练"
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
        self.requestCoachInfoDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func loadView() {
        rootView = CoachContractView()
        view = rootView
        rootView.expTextLabel.text = "行业经验"
        rootView.certificationLabel.text = "资质"
        rootView.termsConditionTextView.text = "您的教练会对您的饮食和健身情况进行管理，添加教练意味着您同意将身体数据、饮食数据及健身数据权限开放给您的教练。"
        rootView.confirmBtn.addTarget(self, action: #selector(confirmContract), for: .touchUpInside)
        mockUpCoachData()
    }
    
    func mockUpCoachData(){
        rootView.coachPortraitImageView.image = UIImage(named: "coachSamplePortrait")
        rootView.coachNameLabel.text = "Sophia May"
        rootView.locationNameLabel.text = "新加坡"
        rootView.gymInfoLabel.text = "裕廊随时健身俱乐部的私人教练"
        rootView.expYearLabel.text = "1年"
        rootView.certificationCourseLabel.text = "ISA认证的私人教练课程"
    }
    
    
    func requestCoachInfoDetail(){
        do{
            var req = Apisvr_GetTrainerInfoReq()
            req.coachID = Int32(coachId)
            guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                return
            }
            let metaData = try Metadata(["authorization": "Token " + token])
            try ProfileDataManager.shared.client.getTrainerInfo(req, metadata: metaData, completion: { (resp, result) in
                if result.statusCode == .ok {
                    DispatchQueue.main.async {
                        self.rootView.coachPortraitImageView.kf.setImage(with: URL(string: resp!.avatarURL))
                        self.rootView.coachNameLabel.text = resp!.name
                        self.rootView.gymInfoLabel.text = resp!.gymClubName
                        self.rootView.expYearLabel.text = "\(resp!.yearsOfExp)年"
                        for qualification in resp!.qualifications{
                            self.rootView.certificationCourseLabel.text! += qualification + "\n"
                        }
                    }
                }
            })
        } catch {
            print(error)
        }
    }
    
    @objc func confirmContract(){
        do{
            guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                return
            }
            let metaData = try Metadata(["authorization": "Token " + token])
            var req = Apisvr_LinkPersonalTrainerReq()
            req.coachID = Int32(self.coachId)
            try ProfileDataManager.shared.client.linkPersonalTrainer(req, metadata: metaData, completion: { (resp, result) in
                if result.statusCode == .ok {
//                    self.navigationController?.pushViewController(targetVC, animated: true)
                    self.navigationController?.popViewController(animated: true)
                }
            })
        } catch {
            print(error)
        }
    }

    
}
