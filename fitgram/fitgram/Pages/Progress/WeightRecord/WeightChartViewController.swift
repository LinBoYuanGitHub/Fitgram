//
//  weightChart.swift
//  fitgram
//
//  Created by boyuan lin on 18/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import SwiftGRPC
import Charts

class WeightChartViewController: BaseViewController {
    var rootView:WeightChartView!
    var bodyShapes = [Apisvr_BodyShape]()
    var currentTimeType:Apisvr_TimeType = .week
    var weightDatas = [Apisvr_WeightDataPoint]()
    
    override func viewDidLoad() {
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
        self.title = "Weight"
        self.requestForWeightChartData()
        self.requestForBodyShapePhoto()
    }
    
    override func loadView() {
        self.rootView = WeightChartView()
        self.view = self.rootView
        self.rootView.weightRecordBtn.addTarget(self, action: #selector(onWeightRecordBtnPressed), for: .touchUpInside)
        self.rootView.dateTab.addTarget(self, action: #selector(onTimeTabChange), for: .valueChanged)
        self.rootView.weightCollectionView.delegate = self
        self.rootView.weightCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func onTimeTabChange(sender:UISegmentedControl){
        let index = sender.selectedSegmentIndex
        switch index {
        case 0:
            currentTimeType = .day
            break
        case 1:
            currentTimeType = .week
            break
        case 2:
            currentTimeType = .month
            break
        default:
            break
        }
        self.requestForWeightChartData()
    }
    
    @objc func onWeightRecordBtnPressed(){
        let targetVC = WeightInputAlertViewController()
        targetVC.modalPresentationStyle = .overCurrentContext
        targetVC.confirmInputEvent = { weight,imageKey in
            if !imageKey.isEmpty{
                self.sendBodyShapeImage(imageKey:imageKey)
            }
            if weight != 0 {
                self.requestAddWeight(weight: weight)
            }
        }
        self.present(targetVC, animated: true, completion: nil)
    }
    
    func requestAddWeight(weight:Float){
        var req = Apisvr_AddWeightLogReq()
        req.weight = weight
        req.date = Int64(Date().timeIntervalSince1970)
        do{
            guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                return
            }
            let metadata = try Metadata(["authorization": "Token " + token])
            try ProgressDataManager.shared.client.addWeightLog(req, metadata: metadata, completion: { (resp, result) in
                if result.statusCode == .ok {
                    self.requestForWeightChartData()
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
    
    func requestForWeightChartData(){
        do{
            var req = Apisvr_GetWeightLogsReq()
            let calendar = Calendar(identifier: .chinese)
            let components = calendar.dateComponents([.year,.month,.day],from: Date())
            req.date = Int64(calendar.date(from: components)!.timeIntervalSince1970)
            req.timeType = currentTimeType
            guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                return
            }
            let metadata = try Metadata(["authorization": "Token " + token])
            try ProgressDataManager.shared.client.getWeightLogs(req, metadata: metadata) { (resp, result) in
                DispatchQueue.main.async {
                    if result.statusCode == .ok {
                        self.weightDatas = resp!.weightDataPoints
                        self.updateData()
                    } else {
                        self.showAlertMessage(msg: result.statusMessage!)
                    }
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.showAlertMessage(msg: error.localizedDescription)
            }
            print(error)
        }
       
    }
    
    
    func updateData(){
        //chartData part
        var valueColors = [UIColor]()
        var values = [ChartDataEntry]()
        for data in weightDatas {
            if data.value != 0 {
                let val = Int(data.value)
//                let date = data.time
//                let dayFormatter = DateFormatter()
//                dayFormatter.dateFormat = "dd"
//                let day = dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(date)))
                valueColors.append(.white)
                values.append(ChartDataEntry(x: Double(data.time), y: Double(val)))
            }
        }
//        let values = (0..<weightDatas.count).map { (i) -> ChartDataEntry in
//            let val = Int(weightDatas[i].value)
//            let date = weightDatas[i].time
//            let dayFormatter = DateFormatter()
//            dayFormatter.dateFormat = "dd"
//            let day = dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(date)))
//            valueColors.append(.white)
//            return ChartDataEntry(x: Double(day)!, y: Double(val))
//        }
        let chartDataSet = LineChartDataSet(entries: values, label: "weight")
        chartDataSet.setColor(.black)
        chartDataSet.valueColors = valueColors
        chartDataSet.valueFont = UIFont(name: "PingFangSC-Light", size: 10)!
        chartDataSet.setCircleColor(.black)
        chartDataSet.mode = .cubicBezier
        chartDataSet.lineDashLengths = []
        let data = LineChartData(dataSet: chartDataSet)
        self.rootView.weightChart.data = data
    }
    
    func requestForBodyShapePhoto(){
        do{
            var req = Apisvr_GetBodyShapeReq()
            req.timeType = currentTimeType
            let calendar = Calendar(identifier: .chinese)
            let components = calendar.dateComponents([.year,.month,.day],from: Date())
            req.date = Int64(calendar.date(from: components)!.timeIntervalSince1970)
            guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                return
            }
            let metadata = try Metadata(["authorization": "Token " + token])
            try ProgressDataManager.shared.client.getBodyShape(req, metadata: metadata) { (resp, result) in
                if result.statusCode == .ok{
                    self.bodyShapes = resp!.bodyShapes
                    DispatchQueue.main.async {
                         self.rootView.weightCollectionView.reloadData()
                    }
                }
            }
        } catch {
            print(error)
        }
    }
    
}

extension WeightChartViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bodyShapes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PicCollectionCell", for: indexPath) as? PicCollectionCell else {
            return UICollectionViewCell()
        }
        cell.bodyShapePicImageView.kf.setImage(with: URL(string: bodyShapes[indexPath.row].photoURL), placeholder: UIImage(named: "coachSamplePortrait"))
        let dateStr = DateUtil.EnDateFormatter(date: Date(timeIntervalSince1970: TimeInterval(bodyShapes[indexPath.row].date)))
        cell.dateLabel.text = String(dateStr)
        return cell
    }
    
    
}
