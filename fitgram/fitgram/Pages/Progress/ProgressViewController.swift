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
//        requestForProgressHomeData()
        initMockUpData()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
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
            log.title = "围度"
            log.unit = "厘米"
            log.value = Float(50 - i)
            self.progressData.bodyMeasurementLog.append(log)
        }
        self.progressData.goal = "减脂"
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
                    self.updateData()
                }
            }
        } catch {
            print(error)
        }
    }
    
    func updateData(){
        //chartData part
        var valueColors = [UIColor]()
        let values = (0..<progressData.weightLogs.count).map { (i) -> ChartDataEntry in
            let val = progressData.weightLogs[i].value
//            let date = progressData.weightLogs[i].date
            valueColors.append(.white)
            return ChartDataEntry(x: Double(i), y: Double(val))
        }
        let chartDataSet = LineChartDataSet(entries: values, label: "weight")
        chartDataSet.setColor(.white)
        chartDataSet.valueColors = valueColors
        chartDataSet.valueFont = UIFont(name: "PingFangSC-Light", size: 10)!
        chartDataSet.setCircleColor(.white)
        chartDataSet.mode = .cubicBezier
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
            cell.onWeightRecordBtnPressed = {
                let targetVC = WeightChartViewController()
                self.navigationController?.pushViewController(targetVC, animated: true)
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProgressHomeGoalCell", for: indexPath) as? ProgressHomeGoalCell else {
                return UITableViewCell()
            }
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
            cell.onArrowPressedAction = {
                let targetVC = BodyMeasurementViewController()
                self.navigationController?.pushViewController(targetVC , animated: true)
            }
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
            return UITableViewCell();
        }
    }
    
    
    
    
    
}
