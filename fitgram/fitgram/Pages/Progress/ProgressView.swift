//
//  ProgressView.swift
//  fitgram
//
//  Created by boyuan lin on 11/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Charts
import Stevia

class ProgressView:UIView {
    public var progressHomeTableView = UITableView()
    
    public var lineChartView = LineChartView(frame: CGRect(x: 16, y: 50, width: UIScreen.main.bounds.width - 32, height: 230))
    public var chartContainer = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 32, height: 300))
    
    private let chartBottomColor = UIColor(red: 255/255, green: 227/255, blue: 90/255, alpha: 1)
    private let chartTopColor = UIColor(red: 255/255, green: 207/255, blue: 30/255, alpha: 1)
    
//    public var weightTitleLabel = UILabel()
//    public var weightRecordArrow = UIImageView()
//    public var recordLabel = UILabel()
//    public var weightValueLabel = UILabel()
//    public var weightRecordBtn = UIButton()
//    public var goalTitleLabel = UILabel()
//    public var goalRecordArrow = UILabel()
//    public var goalLabel = UILabel()
//    public var goalDescLabel = UILabel()
//    public var progressBar = UIProgressView()
//    public var initialWeightLabel = UILabel()
//    public var targetWeightLabel = UILabel()
//    public var weightLabel = UILabel()
//    public var measurementLabel = UILabel()
//    public var measurementArrow = UIImageView()
//    public var measurementCollectionView = UICollectionView()
//    public var weeklyReportLabel = UILabel()
   
    convenience init(){
        self.init(frame: CGRect.zero)
        sv(
            progressHomeTableView
        )
        layout(
            -48,
            |progressHomeTableView|,
            0
        )
        self.backgroundColor = chartBottomColor
        progressHomeTableView.backgroundColor = chartBottomColor
        progressHomeTableView.tableHeaderView = chartContainer
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20))
        footerView.backgroundColor = .white
        progressHomeTableView.tableFooterView = footerView
        //line chart config
        lineChartView.gridBackgroundColor = .white
        lineChartView.isUserInteractionEnabled = false
        lineChartView.setVisibleXRangeMaximum(5)
        lineChartView.setVisibleYRange(minYRange: 2, maxYRange: 5, axis: .left)
        lineChartView.setVisibleYRange(minYRange: 2, maxYRange: 5, axis: .right)
        lineChartView.xAxis.gridColor = .white
        lineChartView.xAxis.axisLineColor = .white
        lineChartView.xAxis.labelTextColor = .white
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.labelCount = 7
        lineChartView.xAxis.forceLabelsEnabled = true
        lineChartView.xAxis.centerAxisLabelsEnabled = false
        lineChartView.xAxis.valueFormatter = DateXAxisFormatter()//NoStyleFormatter
        lineChartView.xAxis.avoidFirstLastClippingEnabled = false
        lineChartView.leftAxis.valueFormatter = NoZeroValueFormatter()
        lineChartView.rightAxis.valueFormatter = NoZeroValueFormatter()
//        lineChartView.xAxis.axisMinimum = 5
//        lineChartView.xAxis.axisMaximum = 5
        lineChartView.leftAxis.gridColor = .white
        lineChartView.leftAxis.axisLineColor = .clear
        lineChartView.leftAxis.labelTextColor = .white
//        lineChartView.leftAxis.axisMinimum = 5
        lineChartView.rightAxis.gridColor = .white
        lineChartView.rightAxis.axisLineColor = .clear
        lineChartView.rightAxis.labelTextColor = .white
//        lineChartView.rightAxis.axisMinimum = 5
        lineChartView.legend.textColor = .white
        chartContainer.addSubview(lineChartView)
//        let gardientColor = CAGradientLayer()
//        gardientColor.frame = chartContainer.bounds
//        gardientColor.colors = [chartBottomColor.cgColor,chartTopColor.cgColor]
//        gardientColor.startPoint = CGPoint(x: 0, y: 0)
//        gardientColor.endPoint = CGPoint(x: chartContainer.frame.width, y: chartContainer.frame.height)
//        chartContainer.layer.insertSublayer(gardientColor, at: 0)
        chartContainer.backgroundColor = chartBottomColor
        //set up chart attribute
        progressHomeTableView.register(ProgressHomeWeightCell.self, forCellReuseIdentifier: "ProgressHomeWeightCell")
        progressHomeTableView.register(ProgressHomeGoalCell.self, forCellReuseIdentifier: "ProgressHomeGoalCell")
        progressHomeTableView.register(ProgressHomeMeasureCell.self, forCellReuseIdentifier: "ProgressHomeMeasureCell")
        progressHomeTableView.register(ProgressReportCell.self, forCellReuseIdentifier: "ProgressReportCell")
        progressHomeTableView.allowsSelection = false
        progressHomeTableView.showsVerticalScrollIndicator = false
    }
}
