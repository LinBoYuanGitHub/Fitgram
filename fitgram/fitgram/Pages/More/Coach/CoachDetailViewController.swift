//
//  CoachDetailViewController.swift
//  fitgram
//
//  Created by boyuan lin on 17/1/20.
//  Copyright © 2020 boyuan lin. All rights reserved.
//

import UIKit
import Stevia
import SwiftGRPC

class CoachDetailViewController: BaseViewController {
    public var planList = [Apisvr_Plan]()
    public var coach = Apisvr_TrainerInfo()
    
    public var rootView:CoachDetailView!
    
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Scan", style: .plain, target: self, action: #selector(naviToScannerView))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.requestMyCoach()
        self.requestMyExercise()
    }
    
    @objc func naviToScannerView(){
        let targetVC = ScannerViewController()
        targetVC.delegate = self
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    override func loadView() {
        rootView = CoachDetailView()
        view = rootView
        rootView.exerciseCollectionView.delegate = self
        rootView.exerciseCollectionView.dataSource = self
        let tapEvent = UITapGestureRecognizer(target: self, action: #selector(naviToCoachDetailVC))
        rootView.coachViewContainer.isUserInteractionEnabled = true
        rootView.coachViewContainer.addGestureRecognizer(tapEvent)
    }
    
    @objc func naviToCoachDetailVC(){
        let targetVC = CoachInfoViewController()
        targetVC.coachId = self.coach.coachID
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    func requestMyCoach(){
        do{
            let req = Apisvr_GetMyTrainersReq()
            guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                return
            }
            let metaData = try Metadata(["authorization": "Token " + token])
            try ProfileDataManager.shared.client.getMyTrainers(req, metadata: metaData) { (resp, result) in
                if result.statusCode == .ok && resp!.trainers.count > 0{
                    DispatchQueue.main.async {
                        self.coach = resp!.trainers[0]
                        self.rootView.coachNameLabel.text = self.coach.name
                        self.rootView.coachClubLabel.text = self.coach.gymClubName
//                        self.rootView.coachPortraitImageView.kf.setImage(with: URL(string: self.coach))
                    }
                }
            }
        } catch {
            print(error)
        }
        
    }
    
    func requestMyExercise(){
        do{
            var req = Apisvr_GetMyExercisePlansReq()
            let calendar = Calendar(identifier: .chinese)
            let components = calendar.dateComponents([.year,.month,.day],from: Date())
            req.date = Int64(calendar.date(from: components)!.timeIntervalSince1970)
            guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                return
            }
            let metaData = try Metadata(["authorization": "Token " + token])
            try ProfileDataManager.shared.client.getMyExercisePlans(req, metadata: metaData) { (resp, result) in
                if result.statusCode == .ok{
                    DispatchQueue.main.async {
                        self.planList = resp!.plans
                        self.rootView.exerciseCollectionView.reloadData()
                    }
                }
            }
        } catch {
            print(error)
        }
       
    }
}

extension CoachDetailViewController:UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        planList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExerciseItemCell", for: indexPath) as? ExerciseItemCell else {
            return UICollectionViewCell()
        }
        let plan = self.planList[indexPath.row]
        cell.dateLabel.text = DateUtil.EnDateFormatter(date: Date(timeIntervalSince1970: TimeInterval(plan.date)))
        cell.exerciseImage.kf.setImage(with: URL(string: plan.planCover.imageKey),placeholder: UIImage(named: "exerciseSample_image"))
        if plan.hasPlanCover{
            cell.exerciseNameLabel.text =  plan.planCover.exerciseName
            cell.exerciseTimesLabel.text = String(plan.planCover.sets) + "Set"
            cell.exerciseDesLabel.text = "Duration \(plan.planCover.duration)min"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let plan = self.planList[indexPath.row]
        let targetVC = WebViewController()
        targetVC.urlString = plan.planURL
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
}

extension CoachDetailViewController: BarcodeScannerDelegate {
    
    func onDectect(barcode: String) {
        let alertView = UIAlertController(title: "", message: barcode, preferredStyle: .alert)
               let okAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
                    print( barcode.components(separatedBy: "coach_id=").count)
                    if barcode.components(separatedBy: "coach_id=").count > 1{
                       DispatchQueue.main.async {
                            let coachId = Int(barcode.components(separatedBy: "coach_id=")[1])
                            let targetVC = CoachContractViewController()
                            targetVC.coachId = coachId!
                            self.navigationController?.pushViewController(targetVC, animated: true)
                       }
                      
            }
        }
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
}
