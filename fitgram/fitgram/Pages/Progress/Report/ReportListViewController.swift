//
//  ReportListViewController.swift
//  fitgram
//
//  Created by boyuan lin on 18/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import SwiftGRPC

class ReportListViewController: UIViewController {
    var reportDataList = [Apisvr_WeeklyReport]()
    var reportTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
    
    override func viewDidLoad() {
        self.title = "全部报告"
        self.view.backgroundColor = .white
        self.view.addSubview(reportTableView)
        initMockUpReportData()
        reportTableView.register(ReportListCell.self, forCellReuseIdentifier: "ReportListCell")
        reportTableView.separatorStyle = .none
        reportTableView.delegate = self
        reportTableView.dataSource = self
        self.requestReports()
    }
    
    func initMockUpReportData(){
        for _ in 0...3 {
            var report = Apisvr_WeeklyReport()
            report.coachName = "lucy"
            report.reportURL = ""
            reportDataList.append(report)
        }
    }
    
    func requestReports(){
        let req = Apisvr_GetWeeklyReportReq()
        guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
            return
        }
        do{
            let metadata = try Metadata(["authorization": "Token " + token])
            try ProgressDataManager.shared.client.getWeeklyReport(req, metadata: metadata) { (resp, result) in
                if result.statusCode == .ok {
                    DispatchQueue.main.async {
                        self.reportDataList = resp!.weeklyReport
                        self.reportTableView.reloadData()
                    }
                }
            }
        } catch {
            print(error)
        }
    }
    
    
    
    
    
}

extension ReportListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReportListCell", for: indexPath) as? ReportListCell else{
            return UITableViewCell()
        }
        let report = reportDataList[indexPath.row]
        cell.coachWeeklyLabel.text = "教练"+report.coachName+"本周的总结报告"
        let startDateStr = DateUtil.CNDateFormatter(date: Date(timeIntervalSince1970: TimeInterval(report.startDate)))
        let endDateStr = DateUtil.CNDateFormatter(date: Date(timeIntervalSince1970: TimeInterval(report.endDate)))
        cell.dateLabel.text = startDateStr + "至" + endDateStr
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let targetUrl = reportDataList[indexPath.row].reportURL
        let targetVC = WebViewController()
        targetVC.urlString = targetUrl
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
}
