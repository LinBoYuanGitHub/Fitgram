//
//  FoodDiaryView.swift
//  fitgram
//
//  Created by boyuan lin on 4/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class FoodDiaryView: UIView{
    let foodDiaryTableView = UITableView.init()
    let nutrientPanel = NutritionPanelView()
    //calendar part
    let dateBtn = UIButton()
    let leftDateArrow = UIButton()
    let rightDateArrow = UIButton()
    let dateContainer = UIView()
    let seperatorView = UIView()
    //foodDiary date delegate part
    @objc public var onDateBtnPressedEvent: () -> Void = {}
    @objc public var onLeftArrowPressedEvent: () -> Void = {}
    @objc public var onRightArrowPressedEvent: () -> Void = {}
    
    convenience init(){
        self.init(frame: CGRect.zero)
        self.backgroundColor = .white
        foodDiaryTableView.register(FoodDiaryMainCell.self, forCellReuseIdentifier: "FoodDiaryMainCell")
        foodDiaryTableView.allowsSelection = false
        foodDiaryTableView.showsVerticalScrollIndicator = false
        foodDiaryTableView.tableHeaderView = nutrientPanel
        //date btn
        dateBtn.setTitleColor(.white, for: .normal)
        dateBtn.backgroundColor = .black
        dateBtn.layer.cornerRadius = 15
        dateBtn.layer.masksToBounds = true
        dateBtn.addTarget(self, action: #selector(onDateBtnPressed), for: .touchUpInside)
        leftDateArrow.addTarget(self, action: #selector(onLeftArrowPressed), for: .touchUpInside)
        rightDateArrow.addTarget(self, action: #selector(onRightArrowPressed), for: .touchUpInside)
        //get today
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        let title = dateFormatter.string(from: Date())
        dateBtn.setTitle(title, for: .normal)
        leftDateArrow.setImage(UIImage(named: "backbutton_black"), for: .normal)
        rightDateArrow.setImage(UIImage(named: "rightArrow_black"), for: .normal)
        sv(
            dateContainer.sv(
                leftDateArrow,
                dateBtn,
                rightDateArrow
            ),
            seperatorView,
            foodDiaryTableView
        )
        layout(
            60,
            |-dateContainer.width(185)-| ~ 40,
            10,
            |-0-seperatorView-0-| ~ 0.5,
            |-8-foodDiaryTableView-8-|,
            0
        )
        layout(
            |-leftDateArrow.width(20)-10-dateBtn.width(125)-10-rightDateArrow.width(20)-|
        )
        seperatorView.width(UIScreen.main.bounds.width)
        seperatorView.backgroundColor = .black
        seperatorView.alpha = 0.2
        dateContainer.centerHorizontally()
    }
    
    @objc private func onDateBtnPressed(){
        self.onDateBtnPressedEvent()
    }
    
    @objc private func onLeftArrowPressed(){
        self.onLeftArrowPressedEvent()
    }
    
    @objc private func onRightArrowPressed(){
        self.onRightArrowPressedEvent()
    }
    
    
}




