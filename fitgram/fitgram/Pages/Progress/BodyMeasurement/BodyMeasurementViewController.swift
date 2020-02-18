//
//  BodyMeasurementViewController.swift
//  fitgram
//
//  Created by boyuan lin on 19/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import SwiftGRPC
import Charts

class BodyMeasurementViewController: BaseViewController {
    public var rootView:BodyMeasurementView!
    private var bodyMeasurementList = [Apisvr_MeasurementChart]()
    
    override func viewDidLoad() {
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
//        self.requestFotBodyMeasurementData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.requestFotBodyMeasurementData()
    }
    
    override func loadView() {
        rootView = BodyMeasurementView()
        self.view = rootView
        rootView.bodyMeasurementTableView.delegate = self
        rootView.bodyMeasurementTableView.dataSource = self
        rootView.onInputBtnPresssedAction = {
            let targetVC = BodyMeasurementInputViewController()
            targetVC.bodyMeasurementList = self.bodyMeasurementList
            self.navigationController?.pushViewController(targetVC, animated: true)
        }
    }
    
    func mockUpBodyMeasurementData(){
        for _ in 0...5 {
            var chart = Apisvr_MeasurementChart()
            chart.title = "Body Measurement"
            chart.logs = []
            bodyMeasurementList.append(chart)
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
            req.bodyMeasurementType = [.waist,.chest,.upperArm,.gluteal,.thigh,.calf]
            try ProgressDataManager.shared.client.getBodyMeasurementLog(req, metadata: metadata) { (resp, result) in
                if result.statusCode == .ok {
                    DispatchQueue.main.async {
                        self.bodyMeasurementList = resp!.measurementCharts
                        self.rootView.bodyMeasurementTableView.reloadData()
                    }
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
        let entity = bodyMeasurementList[indexPath.row]
        cell.bodyMeasurementTitle.text = entity.title
        cell.recordWeightBtn.tag = indexPath.row
        cell.recordWeightBtn.addTarget(self, action: #selector(onRecordBtnPressed), for: .touchUpInside)
        self.updateData(chartView: cell.bodyWeightChart, logs: entity.logs)
        return cell
    }
    
    @objc func onRecordBtnPressed(sender:UIButton){
        let index = sender.tag
        let list = [bodyMeasurementList[index]]
        let targetVC = BodyMeasurementInputViewController()
        targetVC.bodyMeasurementList = list
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    
    func updateData(chartView:LineChartView,logs:[Apisvr_Log]){
        //chartData part
        var valueColors = [UIColor]()
        let values = (0..<logs.count).map { (i) -> ChartDataEntry in
            let val = logs[i].value
            let date = logs[i].date
//            let dayFormatter = DateFormatter()
//            dayFormatter.dateFormat = "dd"
//            let day = dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(date)))
            valueColors.append(.white)
            return ChartDataEntry(x: Double(date), y: Double(val))
        }
        let chartDataSet = LineChartDataSet(entries: values, label: "")
        chartDataSet.setColor(.black)
        chartDataSet.valueColors = valueColors
        chartDataSet.valueFont = UIFont(name: "PingFangSC-Light", size: 10)!
        chartDataSet.setCircleColor(.black)
        chartDataSet.mode = .cubicBezier
        chartDataSet.lineDashLengths = []
        let data = LineChartData(dataSet: chartDataSet)
        chartView.data = data
    }
    
    
}
