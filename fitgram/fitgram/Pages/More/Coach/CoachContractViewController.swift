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
        self.title = "Coach"
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
        rootView.expTextLabel.text = "Years of experience"
        rootView.certificationLabel.text = "Job qualification"
        rootView.termsConditionTextView.text = "Your coach will manage your diet and fitness. Adding a coach means that you agree to disclose your bodily makeup data, diet data and fitness data to your coach."
        rootView.confirmBtn.addTarget(self, action: #selector(confirmContract), for: .touchUpInside)
        mockUpCoachData()
    }
    
    func mockUpCoachData(){
        rootView.coachPortraitImageView.image = UIImage(named: "coachSamplePortrait")
        rootView.coachNameLabel.text = "Sophia May"
        rootView.locationNameLabel.text = "Singapore"
        rootView.gymInfoLabel.text = "West Coast Anytime Fitness, 154 West Coast Rd, Singapore 127371"
        rootView.expYearLabel.text = "1 year"
        rootView.certificationCourseLabel.text = "Personal Training Course Options (including Level 2 Gym)"
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
