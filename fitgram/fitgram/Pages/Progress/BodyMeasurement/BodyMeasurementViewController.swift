//
//  BodyMeasurementViewController.swift
//  fitgram
//
//  Created by boyuan lin on 19/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import SwiftGRPC

class BodyMeasurementViewController: UIViewController {
    public var rootView:BodyMeasurementView!
    private var bodyMeasurementList = [Apisvr_BodyMeasurementLog]()
    
    override func viewDidLoad() {
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
        self.mockUpBodyMeasurementData()
    }
    
    override func loadView() {
        rootView = BodyMeasurementView()
        self.view = rootView
        rootView.bodyMeasurementTableView.delegate = self
        rootView.bodyMeasurementTableView.dataSource = self
        rootView.onInputBtnPresssedAction = {
            let targetVC = BodyMeasurementInputViewController()
            self.navigationController?.pushViewController(targetVC, animated: true)
        }
    }
    
    func mockUpBodyMeasurementData(){
        for _ in 0...5{
            var log = Apisvr_BodyMeasurementLog()
            log.title = "围度"
            log.unit = "cm"
            log.value = 40
            bodyMeasurementList.append(log)
        }
        rootView.bodyMeasurementTableView.reloadData()
    }
    
    func requestFotBodyMeasurementData(){
        do{
            guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                return
            }
            let metadata = try Metadata(["authorization": "Token " + token])
            var req = Apisvr_GetBodyMeasurementLogReq()
            try ProgressDataManager.shared.client.getBodyMeasurementLog(req, metadata: metadata) { (resp, result) in
                if result.statusCode == .ok {
                    
                }
            }
        } catch {
            print(error)
        }
    }
}

extension BodyMeasurementViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bodyMeasurementList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BodyMeasurementCell", for: indexPath) as? BodyMeasurementCell else {
            return UITableViewCell()
        }
        cell.bodyMeasurementTitle.text = "围度"
        return cell
    }
    
    
}
