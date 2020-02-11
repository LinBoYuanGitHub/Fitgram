//
//  BodyMeasurementInputViewController.swift
//  fitgram
//
//  Created by boyuan lin on 20/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import SwiftGRPC

class BodyMeasurementInputViewController: BaseViewController {
    public var inputTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
    public var bodyMeasurementList = [Apisvr_MeasurementChart]()
    
    override func viewDidLoad() {
        self.view.addSubview(inputTableView)
        inputTableView.register(BodyMeasurementInputCell.self, forCellReuseIdentifier: "BodyMeasurementInputCell")
        inputTableView.allowsSelection = false
        inputTableView.delegate = self
        inputTableView.dataSource = self
        inputTableView.tableFooterView = UIView()
        self.title = "围度记录"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "确认", style: .plain, target: self, action: #selector(onMeasurementBatchRecord))
    }
    
    @objc func onMeasurementBatchRecord(){
        //get textfield value
        var measurementInputLogs = [Apisvr_BodyMeasurement]()
        for index in 0...bodyMeasurementList.count-1 {
            var log = Apisvr_BodyMeasurement()
            log.bodyMeasurementType = bodyMeasurementList[index].bodyMeasurementType
            let cell = self.inputTableView.cellForRow(at: IndexPath(row: index, section: 0)) as! BodyMeasurementInputCell
            if (cell.valTextField.text != nil && !cell.valTextField.text!.isEmpty ){
                log.value = Float(cell.valTextField.text!)!
                measurementInputLogs.append(log)
            }
        }
        do{
            var req = Apisvr_AddBodyMeasurementLogReq()
            let calendar = Calendar(identifier: .chinese)
            let components = calendar.dateComponents([.year,.month,.day],from: Date())
            req.date = Int64(calendar.date(from: components)!.timeIntervalSince1970)
            req.bodyMeasurements = measurementInputLogs
            guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                return
            }
            let metadata = try Metadata(["authorization": "Token " + token])
            try ProgressDataManager.shared.client.addBodyMeasurementLog(req, metadata: metadata) { (resp, result) in
                if result.statusCode == .ok {
                    print("upload success")
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }else {
                    DispatchQueue.main.async {
                         self.showAlertMessage(msg: result.statusMessage!)
                    }
                }
            }
        } catch{
            DispatchQueue.main.async {
                 self.showAlertMessage(msg: error.localizedDescription)
            }
            print(error)
        }
    }
    
    
}

extension BodyMeasurementInputViewController: UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bodyMeasurementList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BodyMeasurementInputCell", for: indexPath) as? BodyMeasurementInputCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = bodyMeasurementList[indexPath.row].title
        cell.valTextField.tag = indexPath.row
        cell.valTextField.delegate = self
//        cell.valTextField.text = bodyMeasurementList[indexPath.row].value
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}

