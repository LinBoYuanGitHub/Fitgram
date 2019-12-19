//
//  ReportListViewController.swift
//  fitgram
//
//  Created by boyuan lin on 18/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import Foundation
import UIKit

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
    }
    
    func initMockUpReportData(){
        for _ in 0...3 {
            var report = Apisvr_WeeklyReport()
            report.coachName = "lucy"
            report.dateDuration = "2019年11月30日至2020年1月30日"
            report.reportURL = ""
            reportDataList.append(report)
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
        cell.coachWeeklyLabel.text = "教练"+reportDataList[indexPath.row].coachName+"本周的总结报告"
        cell.dateLabel.text = reportDataList[indexPath.row].dateDuration
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
