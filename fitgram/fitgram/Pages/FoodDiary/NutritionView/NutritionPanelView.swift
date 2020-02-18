//
//  NutritionPanelView.swift
//  fitgram
//
//  Created by boyuan lin on 4/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class NutritionPanelView: UIView{
    public var nutritionCollectionView = UICollectionView.init(frame: CGRect(x: 0, y: 8, width: UIScreen.main.bounds.width - 32, height: 100),  collectionViewLayout: UICollectionViewFlowLayout())
    public var nutrientObj = Apisvr_FoodDiaryNutrient()
    public var shadowContainer:UIView!
   
    convenience init(){
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 120))
//        self.backgroundColor = .white
        nutritionCollectionView.backgroundColor = UIColor.white
        nutritionCollectionView.delegate = self
        nutritionCollectionView.dataSource = self
        nutritionCollectionView.register(SingleNutritionCell.self, forCellWithReuseIdentifier: "SingleNutritionCell")
        nutritionCollectionView.layer.cornerRadius = 10
        nutritionCollectionView.alwaysBounceVertical = false
        shadowContainer = UIView(frame: CGRect(x: 8, y: 8, width: UIScreen.main.bounds.width - 32, height: CGFloat(110)))
        shadowContainer.layer.shadowOffset = CGSize(width: 0, height: 0) //no shadow direction
        shadowContainer.layer.cornerRadius = 10
        shadowContainer.layer.shadowColor = UIColor.black.cgColor
        shadowContainer.layer.shadowOpacity = 0.2
        shadowContainer.layer.shadowRadius = 10
        shadowContainer.backgroundColor = UIColor.white
        shadowContainer.addSubview(nutritionCollectionView)
        addSubview(shadowContainer)
       
    }
    
}

extension NutritionPanelView: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleNutritionCell", for: indexPath) as? SingleNutritionCell else {
            return UICollectionViewCell()
        }
        switch indexPath.row {
        case 0:
            cell.nutriTextLabel.text = "Energy"
            cell.statsLabel.text = String(Int(nutrientObj.energyIntake))+"/"+String(Int(nutrientObj.energyRecommend)) + "kCal"
            if nutrientObj.energyRecommend == 0{
                 cell.percentageLabel.text = "0%"
            } else {
                 cell.percentageLabel.text = String(Int(nutrientObj.energyIntake/nutrientObj.energyRecommend * 100)) + "%"
            }
            break;
        case 1:
            cell.nutriTextLabel.text = "Fat"
            cell.statsLabel.text = String(Int(nutrientObj.fatIntake))+"/"+String(Int(nutrientObj.fatRecommend)) + "g"
            if nutrientObj.fatRecommend == 0{
                cell.percentageLabel.text = "0%"
            } else {
                cell.percentageLabel.text = String(Int(nutrientObj.fatIntake/nutrientObj.fatRecommend * 100)) + "%"
            }
            break;
        case 2:
            cell.nutriTextLabel.text = "Carbs"
            cell.statsLabel.text = String(Int(nutrientObj.carbohydrateIntake))+"/"+String(Int(nutrientObj.carbohydrateRecommend)) + "g"
            if nutrientObj.carbohydrateRecommend == 0{
                cell.percentageLabel.text = "0%"
            } else {
                cell.percentageLabel.text = String(Int(nutrientObj.carbohydrateIntake/nutrientObj.carbohydrateRecommend * 100)) + "%"
            }
            break;
        case 3:
            cell.nutriTextLabel.text = "Protein"
            cell.statsLabel.text = String(Int(nutrientObj.proteinIntake))+"/"+String(Int(nutrientObj.proteinRecommend)) + "g"
            if nutrientObj.proteinRecommend == 0{
                cell.percentageLabel.text = "0%"
            } else {
                cell.percentageLabel.text = String(Int(nutrientObj.proteinIntake/nutrientObj.proteinRecommend * 100)) + "%"
            }
            break;
        default: break;
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 84, height: 105)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
}
