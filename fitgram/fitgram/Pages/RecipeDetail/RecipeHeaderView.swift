//
//  RecipeHeaderView.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 2/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class RecipeHeaderView: UIView {
    //empty head view
    public var emptyViewHead = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height:  UIScreen.main.bounds.width))
    public var whiteBoardContainer:UIView!
    //function button part
    public var favoriteBtn = UIButton()
    public var checkedBtn = UIButton()
    public var startCookBtn = UIButton(frame: CGRect(x: 64, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 128, height: 50))
    //nutrition part
    public var nutritionPanel = NutritionCardView()
    //ingredient part
    public var ingredientDataList = [IngredientModel]()
    
    private let heightFactor = 50
    
    convenience init (){
        self.init(frame: CGRect.zero)
        self.ingredientDataList = ingredientDataList
        emptyViewHead.backgroundColor = UIColor.clear
        self.addSubview(emptyViewHead)
        whiteBoardContainer =  UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.width, width:  UIScreen.main.bounds.width, height: CGFloat(600)))
        whiteBoardContainer.backgroundColor = .white
    }
    
    func setData(ingredientDataList:[IngredientModel],nutritionData:Apisvr_Nutrient,duration:Int,difficulity:Apisvr_Difficulty){
        self.ingredientDataList = ingredientDataList
        whiteBoardContainer.frame = CGRect(x: 0, y: UIScreen.main.bounds.width, width:  UIScreen.main.bounds.width, height: CGFloat(300+ingredientDataList.count*heightFactor))
        self.frame =  CGRect(x: 0, y: 0, width:  UIScreen.main.bounds.width, height: CGFloat(Int(UIScreen.main.bounds.width) + ingredientDataList.count*heightFactor + 300))
        self.assembleNutritionPanel(nutrientData:nutritionData)
        self.assembleCookingInfoLabels(duration:duration,difficulity:difficulity)
        self.assembleIngredientList(ingredientDataList:ingredientDataList)
    }
    
    func assembleNutritionPanel(nutrientData:Apisvr_Nutrient) {
        let nutritionPanel = NutritionCardView(nutrientData: nutrientData)
        nutritionPanel.frame.origin.y =  16
        whiteBoardContainer.addSubview(nutritionPanel)
    }
    
    func createDescLabelsContainer(descIcon:UIImage, descTitle:String, descContent: String) -> UIView {
        let descRow = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:  20))
        let iconView = UIImageView(frame: CGRect(x: 16, y: 0, width: 16, height: 16))
        let titleText = UILabel(frame: CGRect(x: 40, y: 0, width: 60, height: 20))
        let contentText = UILabel(frame: CGRect(x: 105, y: 0, width: UIScreen.main.bounds.width - 105, height: 20))
        iconView.image = descIcon
        titleText.text = descTitle
        titleText.font = UIFont(name: "PingFangSC-Medium", size: 14)
        contentText.text = descContent
        contentText.textAlignment = .left
        contentText.font = UIFont(name: "PingFangSC-Light", size: 14)
        descRow.addSubview(iconView)
        descRow.addSubview(titleText)
        descRow.addSubview(contentText)
        return descRow
    }
    
    //ingredient list part
    func assembleIngredientList(ingredientDataList:[IngredientModel]) {
        //ingredient title
        let ingredientsLabel = UILabel(frame: CGRect(x: 32, y: 220, width: CGFloat(UIScreen.main.bounds.width-32), height: 25))
        ingredientsLabel.text = "Ingredients ～ 1  serving"
        ingredientsLabel.font = UIFont(name: ":PingFangSC-Medium", size: 18)
        //ingredient list part
        let ingredientViewContainer = UIView(frame: CGRect(x: 0, y: 270, width: CGFloat(UIScreen.main.bounds.width), height:  CGFloat(ingredientDataList.count * heightFactor)))
        for index in 0..<ingredientDataList.count {
            let ingredientNameLabel = UILabel(frame: CGRect(x: 16, y: index*heightFactor, width:Int((UIScreen.main.bounds.width-16)/2), height: heightFactor))
            let ingredientUnitLabel = UILabel(frame: CGRect(x: Int((UIScreen.main.bounds.width-16)/2), y: index*heightFactor, width:Int((UIScreen.main.bounds.width-16)/2), height: heightFactor))
            ingredientUnitLabel.textAlignment = .right
            let ingredientDashLineView = createDashLine(lineLength: 1,lineSpacing: 1,lineColor: UIColor.black,yValue:(index+1)*heightFactor)
            ingredientNameLabel.text = ingredientDataList[index].ingredientName
            ingredientUnitLabel.text = ingredientDataList[index].portionDesc
            ingredientViewContainer.addSubview(ingredientNameLabel)
            ingredientViewContainer.addSubview(ingredientUnitLabel)
            ingredientViewContainer.addSubview(ingredientDashLineView)
        }
        self.addSubview(whiteBoardContainer)
        whiteBoardContainer.addSubview(ingredientViewContainer)
        whiteBoardContainer.addSubview(ingredientsLabel)
    }
    
    func assembleCookingInfoLabels(duration:Int,difficulity:Apisvr_Difficulty) {
        let timeInfo = createDescLabelsContainer(descIcon: UIImage(named: "clockIcon_gray")!, descTitle: "Duration", descContent: " \(duration)min")
        var difficulityLvl:UIView!
        switch difficulity {
        case .easy:
            difficulityLvl = createDescLabelsContainer(descIcon: UIImage(named: "difficulityIcon_gray")!, descTitle: "Difficulty", descContent: "Easy")
        case .hard:
            difficulityLvl = createDescLabelsContainer(descIcon: UIImage(named: "difficulityIcon_gray")!, descTitle: "Difficulty", descContent: "Hard")
        case .normal:
            difficulityLvl = createDescLabelsContainer(descIcon: UIImage(named: "difficulityIcon_gray")!, descTitle: "Difficulty", descContent: "Normal")
        case .noneDifficulty:
            difficulityLvl = createDescLabelsContainer(descIcon: UIImage(named: "difficulityIcon_gray")!, descTitle: "Difficulty", descContent: "Very Easy")
        case .UNRECOGNIZED(_):
            break
        }
        timeInfo.frame.origin.y = 137
        difficulityLvl.frame.origin.y = 167
        whiteBoardContainer.addSubview(timeInfo)
        whiteBoardContainer.addSubview(difficulityLvl)
    }
    
    func createDashLine(lineLength : Int ,lineSpacing : Int,lineColor : UIColor,yValue:Int) -> UIView {
        let dashLineView = UIView(frame: CGRect(x: 16, y: yValue, width: Int(UIScreen.main.bounds.width - 32), height: 1))
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = dashLineView.bounds
        //        只要是CALayer这种类型,他的anchorPoint默认都是(0.5,0.5)
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
        //        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.strokeColor = lineColor.cgColor
    
        shapeLayer.lineWidth = dashLineView.frame.size.height
        shapeLayer.lineJoin = .round
    
        shapeLayer.lineDashPattern = [NSNumber(value: lineLength),NSNumber(value: lineSpacing)]
    
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: dashLineView.frame.size.width, y: 0))
        
        shapeLayer.path = path
        dashLineView.layer.addSublayer(shapeLayer)
        return dashLineView
    }
    
    func createStartCookButton(){
        //create start cook btn at the bottom
        startCookBtn.backgroundColor = UIColor(red: 252/255, green: 200/255, blue: 45/255, alpha: 1)
        startCookBtn.tintColor = UIColor.white
        startCookBtn.setTitle("Start Cooking!", for: .normal)
        startCookBtn.layer.cornerRadius = 20
        startCookBtn.layer.shadowOffset = CGSize(width: 0, height: 0) //no shadow direction
        startCookBtn.layer.shadowColor = UIColor.black.cgColor
        startCookBtn.layer.shadowOpacity = 0.2
        startCookBtn.layer.shadowRadius = 5
        (UIApplication.shared.delegate?.window!)!.addSubview(startCookBtn)
    }
    
    func showStartCookBtn(){
        UIView.animate(withDuration: 0.5) {
            self.startCookBtn.frame = CGRect(x: 64, y: UIScreen.main.bounds.height-80, width: UIScreen.main.bounds.width - 128, height: 50)
        }
    }
    
    func dismissStartCookBtn(){
        UIView.animate(withDuration: 0.5) {
            self.startCookBtn.frame = CGRect(x: 64, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 128, height: 50)
        }
    }
    
    
    
}
