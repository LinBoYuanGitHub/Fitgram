//
//  NutritionCardView.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 2/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia
import ASPCircleChart

class NutritionCardView: UIView {
    
    let shadowContainer = UIView(frame: CGRect(x: 16, y: 0, width: UIScreen.main.bounds.width - 32, height: 105))
    var dataSource = DataSource(items: [27, 54, 19])
    
    var circleChart = ASPCircleChart(frame: CGRect(x: 0, y: 0, width: 76, height: 70))
    
    public var nutrientData = Apisvr_Nutrient()
    
    
    convenience init (nutrientData:Apisvr_Nutrient){
        self.init(frame: CGRect.zero)
        self.nutrientData = nutrientData
        self.calculateDataSource()
        let circleView = createCircleGraph()
        //mock up data for card
        let fatDataView = createNutriDataSet(dataSetFrame:CGRect(x: 120, y: 24, width: 66, height: 60),percentageText: String(dataSource.items[0]) + "%", percentageTextColor: UIColor.black, gramText:  String(Int(nutrientData.fat)) + "克", gramTextColor: UIColor.black, nutriNameText: "脂肪", nutriNameTextColor:  UIColor.fatNutriPurple)
        let carbDataView = createNutriDataSet(dataSetFrame:CGRect(x: 200, y: 24, width: 66, height: 60),percentageText:  String(dataSource.items[1]) + "%", percentageTextColor: UIColor.black, gramText: String(Int(nutrientData.carbohydrate)) + "克", gramTextColor: UIColor.black, nutriNameText: "碳水化合物", nutriNameTextColor:  UIColor.carbNutriEmerald)
        let proteinDataView = createNutriDataSet(dataSetFrame:CGRect(x: 273, y: 24, width: 66, height: 60),percentageText:  String(dataSource.items[2]) + "%", percentageTextColor: UIColor.black, gramText: String(Int(nutrientData.protein)) + "克", gramTextColor: UIColor.black, nutriNameText: "蛋白质", nutriNameTextColor: UIColor.proteinNutriIndigo)
        //shadow setting
        shadowContainer.layer.shadowOffset = CGSize(width: 0, height: 0) //no shadow direction
        shadowContainer.layer.cornerRadius = 4
        shadowContainer.layer.shadowColor = UIColor.black.cgColor
        shadowContainer.layer.shadowOpacity = 0.2
        shadowContainer.layer.shadowRadius = 10
        shadowContainer.backgroundColor = UIColor.white
        shadowContainer.addSubview(circleView)
        self.addSubview(shadowContainer)
        self.addSubview(fatDataView)
        self.addSubview(carbDataView)
        self.addSubview(proteinDataView)
    }
    
    func createNutriDataSet(dataSetFrame: CGRect,percentageText:String,percentageTextColor:UIColor,gramText:String,gramTextColor:UIColor,nutriNameText:String,nutriNameTextColor:UIColor) -> UIView {
        let nutriDataContainer = UIView(frame: dataSetFrame)
        let percentageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 66, height: 16))
        let gramLabel = UILabel(frame: CGRect(x: 0, y: 17, width: 66, height: 25))
        let nutriNameLabel = UILabel(frame: CGRect(x: 0, y: 41, width: 66, height: 16))
        //label part
        percentageLabel.text = percentageText
        gramLabel.text = gramText
        nutriNameLabel.text = nutriNameText
        //color setting part
        percentageLabel.textColor = percentageTextColor
        gramLabel.textColor = gramTextColor
        nutriNameLabel.textColor = nutriNameTextColor
        //text alignment setting
        percentageLabel.textAlignment = .center
        gramLabel.textAlignment = .center
        nutriNameLabel.textAlignment = .center
        //text font setting
        percentageLabel.font = UIFont(name: "PingFangSC-Regular", size: 11)
        gramLabel.font = UIFont(name: "PingFangSC-Regular", size: 18)
        nutriNameLabel.font = UIFont(name: "PingFangSC-Regular", size: 11)
        //add subview
        nutriDataContainer.addSubview(percentageLabel)
        nutriDataContainer.addSubview(gramLabel)
        nutriDataContainer.addSubview(nutriNameLabel)
        return nutriDataContainer
    }
    
    func createCircleGraph() -> UIView {
        let cicleContainer = UIView(frame: CGRect(x: 16, y: 16, width: 76, height: 70))
        circleChart.lineCapStyle = .straight
        circleChart.circleWidth = 6
        circleChart.latestSliceOnTop = false
        circleChart.dataSource = dataSource
        //center text part
        let calorieLabel = UILabel(frame: CGRect(x: 0, y: 16, width: 76, height: 25))
        calorieLabel.text = String(Int(nutrientData.energy))
        calorieLabel.font = UIFont(name: ":PingFangSC-Regular", size: 18)
        calorieLabel.textAlignment = .center
        cicleContainer.addSubview(circleChart)
        let unitLabel = UILabel(frame: CGRect(x: 0, y: 40, width: 76, height: 18))
        unitLabel.text = "千卡"
        unitLabel.textAlignment = .center
        unitLabel.font = UIFont(name: "PingFangSC-Regular", size: 13)
        unitLabel.textColor = UIColor.lightGray
        cicleContainer.addSubview(calorieLabel)
        cicleContainer.addSubview(unitLabel)
        return cicleContainer
    }
    
    func calculateDataSource() {
        //datasource caclulation
        let totalValue = nutrientData.fat + nutrientData.carbohydrate + nutrientData.protein
        if totalValue == 0 {
            dataSource = DataSource(items: [0,0,0])
        } else {
            let faPercentage = Double(Int(nutrientData.fat*100/totalValue))
            let carboPercentage = Double(Int(nutrientData.carbohydrate*100/totalValue))
            let proteinPercentage = Double(Int(nutrientData.protein*100/totalValue))
            dataSource = DataSource(items: [faPercentage,carboPercentage,proteinPercentage])
        }
    }
    
}


class DataSource: ASPCircleChartDataSource {
    var items: [Double] = [27, 54, 19]
    
    init(items:[Double]) {
        self.items = items
    }
    
    @objc func numberOfDataPoints() -> Int {
        return items.count
    }
    
    @objc func dataPointsSum() -> Double {
        return items.reduce(0.0, { (initial, new) -> Double in
            return initial + new
        })
    }
    
    @objc func dataPointAtIndex(_ index: Int) -> Double {
        return items[index]
    }
    
    
    @objc func colorForDataPointAtIndex(_ index: Int) -> UIColor {
        switch index {
        case 0:
            return UIColor.fatNutriPurple
        case 1:
            return UIColor.carbNutriEmerald
        case 2:
            return UIColor.proteinNutriIndigo
        default:
            return UIColor(red: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), green: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), blue: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), alpha: 1.0)
        }
    }
}

extension UIColor {
    static let fatNutriPurple = UIColor(red: 156/255.0, green: 106/255.0, blue: 222/255.0, alpha: 1.0)
    static let carbNutriEmerald = UIColor(red: 71/255.0, green: 193/255.0, blue: 191/255.0, alpha: 1.0)
    static let proteinNutriIndigo = UIColor(red: 0/255.0, green: 111/255.0, blue: 187/255.0, alpha: 1.0)
}
