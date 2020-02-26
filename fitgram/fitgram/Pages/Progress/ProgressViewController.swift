//
//  ProgressViewController.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 1/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Charts
import Stevia
import SwiftGRPC

class ProgressViewController: UIViewController {
    public var rootView = ProgressView()
    public var progressData = Apisvr_GetProgressHomeResp()
    private let chartData = ChartData()
    
    override func viewDidLoad() {
        self.rootView.lineChartView.delegate = self
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
    }
    
    override func loadView() {
        rootView = ProgressView()
        self.view = rootView
        rootView.progressHomeTableView.delegate = self
        rootView.progressHomeTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        requestForProgressHomeData()
//        initMockUpData()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func initMockUpData(){
        self.progressData.targetWeight = 60
        self.progressData.initialWeight = 70
        for i in 0...2 {
            var log = Apisvr_Log()
            log.date = 0
            log.value = Float(65 - i)
            self.progressData.weightLogs.append(log)
        }
        for i in 0...3 {
            var log = Apisvr_BodyMeasurementLog()
            log.title = "bodyMeasurement"
            log.unit = "cm"
            log.value = Float(50 - i)
            self.progressData.bodyMeasurementLog.append(log)
        }
        self.progressData.goal = "Lose Weight"
        self.updateData()
    }
    
    func requestForProgressHomeData() {
        do{
            var req = Apisvr_GetProgressHomeReq()
            guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                return
            }
            let metadata = try Metadata(["authorization": "Token " + token])
            let calendar = Calendar(identifier: .chinese)
            let components = calendar.dateComponents([.year,.month,.day],from: Date())
            req.date = Int64(calendar.date(from: components)!.timeIntervalSince1970)
            try ProgressDataManager.shared.client.getProgressHome(req, metadata: metadata) { (resp, result) in
                if result.statusCode == .ok {
                    self.progressData = resp!
                    DispatchQueue.main.async {
                        self.updateData()
                        self.rootView.progressHomeTableView.reloadData()
                    }
                }
            }
        } catch {
            print(error)
        }
    }
    
    func updateData(){
        //chartData part
        var valueColors = [UIColor]()
//        let values = (0..<progressData.weightLogs.count).map { (i) -> ChartDataEntry in
//            let val = progressData.weightLogs[i].value
//            let date = progressData.weightLogs[i].date
//            let dayFormatter = DateFormatter()
//            dayFormatter.dateFormat = "dd"
//            let day = dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(date)))
//            valueColors.append(.white)
//            return ChartDataEntry(x: Double(day)!, y: Double(val))
//        }
        var values = [ChartDataEntry]()
        for i in 0...6 {
            if progressData.weightLogs.count == 0 {
                return
            }
            valueColors.append(.white)
            if i >= progressData.weightLogs.count {
                let previousDay = values[i-1].x
                let date = previousDay + 86400//add 1 day time
                values.append(ChartDataEntry(x: date, y: 0))
            } else {
                let val = progressData.weightLogs[i].value
                let calendar = Calendar(identifier: .chinese)
                let components = calendar.dateComponents([.year,.month,.day],from: Date(timeIntervalSince1970:TimeInterval(progressData.weightLogs[i].date)))
//                components.timeZone = TimeZone(abbreviation: "UTC")
                let date = Double(calendar.date(from: components)!.timeIntervalSince1970)
                let data = ChartDataEntry(x: date, y: Double(val))
                values.append(data)
            }
        }
        let chartDataSet = LineChartDataSet(entries: values, label: "weight")
        chartDataSet.setColor(.white)
        chartDataSet.valueColors = valueColors
        chartDataSet.valueFont = UIFont(name: "PingFangSC-Light", size: 10)!
        chartDataSet.setCircleColor(.white)
//        chartDataSet.mode = .cubicBezier
        chartDataSet.lineDashLengths = []
        let data = LineChartData(dataSet: chartDataSet)
        rootView.lineChartView.data = data
    }
}

extension ProgressViewController: ChartViewDelegate{
    
}

extension ProgressViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 //weight,goal,measurement,weeklyReport
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProgressHomeWeightCell", for: indexPath) as? ProgressHomeWeightCell else {
                return UITableViewCell()
            }
            let last = self.progressData.weightLogs.count
            if self.progressData.weightLogs.count > 0 {
                cell.weightLabel.text = String(self.progressData.weightLogs[last-1].value)
                cell.recordTimeLabel.text = "Last Record \(DateUtil.EnDateFormatter(date: Date(timeIntervalSince1970: TimeInterval(self.progressData.weightLogs[last-1].date))))"
            } else {
                cell.weightLabel.text = "0"
                cell.recordTimeLabel.text = "Last Record "
            }
            
            cell.onWeightRecordBtnPressed = {
                let targetVC = WeightInputAlertViewController()
                targetVC.modalPresentationStyle = .overCurrentContext
                targetVC.confirmInputEvent = { weight,imageKey in
                    if !imageKey.isEmpty{
                        self.sendBodyShapeImage(imageKey:imageKey)
                    }
                    self.requestAddWeight(weight: weight)
                }
//                targetVC.modalTransitionStyle = .crossDissolve
                self.present(targetVC, animated: true, completion: nil)
//                self.navigationController?.pushViewController(targetVC, animated: true)
            }
            let tapEvent = UITapGestureRecognizer(target: self, action: #selector(onWeightTapEvent))
            cell.isUserInteractionEnabled = true
            cell.addGestureRecognizer(tapEvent)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProgressHomeGoalCell", for: indexPath) as? ProgressHomeGoalCell else {
                return UITableViewCell()
            }
            let count = self.progressData.weightLogs.count - 1
            let currentWeight = count >= 0 ?self.progressData.weightLogs[count].value:0
            cell.titleLabel.text = "goal: \(self.progressData.goal)"
            let initialWeightStr = String(format: "%.1f", self.progressData.initialWeight)
            let targetWeightStr = String(format: "%.1f", self.progressData.targetWeight)
            cell.initialWeightLabel.text = "Initial Weight:\(initialWeightStr)kg"
            cell.targetWeightLabel.text = "Target Goal: \(targetWeightStr)kg"
            cell.expctedDateLable.text = "\(self.progressData.remainingDays) days left to reach goal"
            switch self.progressData.goal {
            case "LOSE WEIGHT":
                cell.goalLabel.text = "Currently lost \(self.progressData.initialWeight-currentWeight)kg"
            case "GAIN MUSCLE":
                cell.goalLabel.text = "Currently gain \(currentWeight-self.progressData.initialWeight)kg"
            case "STAY FIT":
                cell.goalLabel.text = "Keep Exercise, Stay fit"
            default: break
            }
            cell.goalProgressBar.progress = (currentWeight - progressData.initialWeight)/(progressData.targetWeight - progressData.initialWeight)
            cell.onArrowPressedAction = {
                let targetVC = PhotoRecordHomeViewController()
                self.navigationController?.pushViewController(targetVC, animated: true)
            }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProgressHomeMeasureCell", for: indexPath) as? ProgressHomeMeasureCell else {
                return UITableViewCell()
            }
            cell.measurementDataList = progressData.bodyMeasurementLog
            cell.measurementCollectionView.reloadData()
            let tapEvent = UITapGestureRecognizer(target: self, action: #selector(oMeasurementTapEvent))
            cell.isUserInteractionEnabled = true
            cell.addGestureRecognizer(tapEvent)
//            cell.onArrowPressedAction = {
//                let targetVC = BodyMeasurementViewController()
//                self.navigationController?.pushViewController(targetVC , animated: true)
//            }
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProgressReportCell", for: indexPath) as? ProgressReportCell else {
                return UITableViewCell()
            }
            cell.onReportPressed = {
                let targetVC = ReportListViewController()
                self.navigationController?.pushViewController(targetVC , animated: true)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    @objc func onWeightTapEvent(){
        let targetVC = WeightChartViewController()
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    @objc func oMeasurementTapEvent(){
         let targetVC = BodyMeasurementViewController()
         self.navigationController?.pushViewController(targetVC , animated: true)
    }
    
    func requestAddWeight(weight:Float){
        var req = Apisvr_AddWeightLogReq()
        req.weight = weight
        let calendar = Calendar(identifier: .chinese)
        let components = calendar.dateComponents([.year,.month,.day],from: Date())
//        let timezoneOffset =  TimeZone.current.secondsFromGMT()
        req.date = Int64(calendar.date(from: components)!.timeIntervalSince1970)
        do{
            guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                return
            }
            let metadata = try Metadata(["authorization": "Token " + token])
            try ProgressDataManager.shared.client.addWeightLog(req, metadata: metadata, completion: { (resp, result) in
                if result.statusCode == .ok {
                    self.requestForProgressHomeData()
                }
            })
        } catch {
            print(error)
        }
    }
    
    func sendBodyShapeImage(imageKey:String){
        var req = Apisvr_AddBodyShapeReq()
        req.photoURL = imageKey
        req.date = Int64(Date().timeIntervalSince1970)
        do{
            guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                return
            }
            let metadata = try Metadata(["authorization": "Token " + token])
            try ProgressDataManager.shared.client.addBodyShape(req, metadata: metadata, completion: { (resp, result) in
                if result.statusCode == .ok {
                    print("upload body photo success")
                }
            })
            } catch {
                   print(error)
            }
    }
    
    
    
}
