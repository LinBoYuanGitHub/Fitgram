//
//  NutritionPanelView.swift
//  fitgram
//
//  Created by boyuan lin on 4/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class NutritionPanelView: UIView{
    public var nutritionCollectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 32, height: 120))
    public var nutrientObj = Apisvr_FoodDiaryNutrient()
   
    convenience init(){
        self.init(frame: .zero)
        self.layer.shadowOffset = CGSize(width: 0, height: 0) //no shadow direction
        self.layer.cornerRadius = 4
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 10
        self.backgroundColor = UIColor.white
        nutritionCollectionView.delegate = self
        nutritionCollectionView.dataSource = self
        nutritionCollectionView.register(SingleNutritionCell.self, forCellWithReuseIdentifier: "SingleNutritionCell")
        addSubview(nutritionCollectionView)
    }
    
}

extension NutritionPanelView: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleNutritionCell", for: indexPath) as? SingleNutritionCell else {
            return UICollectionViewCell()
        }
        switch indexPath.row {
        case 0:
            cell.nutriTextLabel.text = "能量"
            cell.statsLabel.text = String(nutrientObj.energyIntake)+"/"+String(nutrientObj.energyRecommend)
            cell.percentageLabel.text = String(nutrientObj.energyIntake/nutrientObj.energyRecommend) + "%"
            break;
        case 1:
            cell.nutriTextLabel.text = "脂肪"
            cell.statsLabel.text = String(nutrientObj.fatIntake)+"/"+String(nutrientObj.fatRecommend)
            cell.percentageLabel.text = String(nutrientObj.fatIntake/nutrientObj.fatRecommend) + "%"
            break;
        case 2:
            cell.nutriTextLabel.text = "碳水化合物"
            cell.statsLabel.text = String(nutrientObj.carbohydrateIntake)+"/"+String(nutrientObj.carbohydrateRecommend)
            cell.percentageLabel.text = String(nutrientObj.carbohydrateIntake/nutrientObj.carbohydrateRecommend) + "%"
            break;
        case 3:
            cell.nutriTextLabel.text = "蛋白质"
            cell.statsLabel.text = String(nutrientObj.proteinIntake)+"/"+String(nutrientObj.proteinRecommend)
            cell.percentageLabel.text = String(nutrientObj.proteinIntake/nutrientObj.proteinRecommend) + "%"
            break;
        default: break;
        }
        return cell
    }
    
    
}
