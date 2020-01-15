//
//  FoodDiaryMealCollectionCell.swift
//  fitgram
//
//  Created by boyuan lin on 5/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class FoodDiaryMeaCollectionCell:UICollectionViewCell {
    public var mealImage = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mealImage)
        mealImage.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        mealImage.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        mealImage.contentMode = .scaleAspectFill
    }
    
    
    
}
