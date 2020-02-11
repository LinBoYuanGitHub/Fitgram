//
//  coachInfoViewController.swift
//  fitgram
//
//  Created by boyuan lin on 20/1/20.
//  Copyright © 2020 boyuan lin. All rights reserved.
//

import UIKit
import SwiftGRPC

class CoachInfoViewController: BaseViewController {
    public var rootView:CoachInfoView!
    var coachId:Int32 = 0
    
    override func viewDidLoad() {
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
        self.requestCoachInfoDetail()
    }
    
    override func loadView() {
        rootView = CoachInfoView()
        view = rootView
    }
    
    func requestCoachInfoDetail(){
        do{
            var req = Apisvr_GetTrainerDetailsReq()
            req.coachID = Int32(coachId)
            guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                return
            }
            let metaData = try Metadata(["authorization": "Token " + token])
            try ProfileDataManager.shared.client.getTrainerDetails(req, metadata: metaData, completion: { (resp, result) in
                if result.statusCode == .ok {
                    DispatchQueue.main.async {
                        self.rootView.expTextLabel.text = "行业经验"
                        self.rootView.certificationLabel.text = "资质"
                        self.rootView.coachPortraitImageView.kf.setImage(with: URL(string: resp!.avatarURL))
                        self.rootView.coachNameLabel.text = resp!.name
                        self.rootView.gymInfoLabel.text = resp!.gymClubName
                        self.rootView.expYearLabel.text = "\(resp!.yearsOfExp)年"
                        var qualificationText = ""
                        for qualification in resp!.qualifications{
                            qualificationText += qualification + "\n"
                        }
                        self.rootView.certificationCourseLabel.text = qualificationText
                        self.rootView.startDateLabel.text = DateUtil.CNDateFormatter(date: Date(timeIntervalSince1970: TimeInterval(resp!.startServiceDate)))
                        self.rootView.endDateLabel.text = DateUtil.CNDateFormatter(date: Date(timeIntervalSince1970: TimeInterval(resp!.endServiceDate)))
                    }
                  }
              })
          } catch {
              print(error)
          }
      }
}
