//
//  ReportListViewController.swift
//  fitgram
//
//  Created by boyuan lin on 18/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import SwiftGRPC

class ReportListViewController: BaseViewController {
    var reportDataList = [Apisvr_WeeklyReport]()
    var reportTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
    
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "All Report"
        self.view.backgroundColor = .white
        self.view.addSubview(reportTableView)
        initMockUpReportData()
        reportTableView.register(ReportListCell.self, forCellReuseIdentifier: "ReportListCell")
        reportTableView.separatorStyle = .none
        reportTableView.delegate = self
        reportTableView.dataSource = self
        self.requestReports()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        cell.coachWeeklyLabel.text = "Coach "+report.coachName+" weekly report"
        let startDateStr = DateUtil.EnDateFormatter(date: Date(timeIntervalSince1970: TimeInterval(report.startDate)))
        let endDateStr = DateUtil.EnDateFormatter(date: Date(timeIntervalSince1970: TimeInterval(report.endDate)))
        cell.dateLabel.text = startDateStr + "to" + endDateStr
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
