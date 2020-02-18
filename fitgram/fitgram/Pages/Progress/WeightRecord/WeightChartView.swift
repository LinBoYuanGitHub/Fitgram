//
//  WeightChartView.swift
//  fitgram
//
//  Created by boyuan lin on 18/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Charts
import Stevia

class WeightChartView: UIView {
    public let dateTab = UISegmentedControl(frame: CGRect.zero)
    public var weightChart = LineChartView()
    public var weightRecordBtn = UIButton()
    public var currentDate = Date()
    public var weightCollectionView =  UICollectionView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40), collectionViewLayout: UICollectionViewFlowLayout())
    
    public var onRecordWeightBtnPressedEvent: () -> Void = { }
    
    convenience init(){
        self.init(frame:CGRect.zero)
        self.backgroundColor = .white
        sv(
            dateTab,
            weightChart,
            weightRecordBtn,
            weightCollectionView
        )
        layout(
            20,
            |-16--dateTab-16-|,
            20,
            |-16-weightChart-16-| ~ 230,
            20,
            |-weightRecordBtn-| ~ 50,
            30,
            |-weightCollectionView-| ~ 170
        )
        dateTab.centerHorizontally()
        dateTab.insertSegment(withTitle: "Month", at: 0, animated: false)
        dateTab.insertSegment(withTitle: "Week", at: 0, animated: false)
        dateTab.insertSegment(withTitle: "Day", at: 0, animated: false)
        dateTab.selectedSegmentIndex = 0
        dateTab.tintColor = .black
        dateTab.backgroundColor = .white
        weightChart.xAxis.labelPosition = .bottom
        weightChart.xAxis.valueFormatter = DateXAxisFormatter()//NoStyleFormatter
        weightChart.leftAxis.valueFormatter = NoZeroValueFormatter()
        weightChart.rightAxis.valueFormatter = NoZeroValueFormatter()
        weightRecordBtn.setTitle("Record Weight", for: .normal)
        weightRecordBtn.width(125)
        weightRecordBtn.centerHorizontally()
        weightRecordBtn.backgroundColor = .black
        weightRecordBtn.layer.cornerRadius = 15
        weightRecordBtn.layer.masksToBounds = true
        weightRecordBtn.addTarget(self, action: #selector(onRecordWeightBtnPressed), for: .touchUpInside)
        weightCollectionView.backgroundColor = .white
        weightCollectionView.register(PicCollectionCell.self, forCellWithReuseIdentifier: "PicCollectionCell")
        weightCollectionView.showsHorizontalScrollIndicator = false
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 170)
        layout.scrollDirection = .horizontal
        weightCollectionView.collectionViewLayout = layout
    }
    
    @objc func onRecordWeightBtnPressed(){
        self.onRecordWeightBtnPressedEvent()
    }
    
    
    
    
    
    
}
