//
//  RecipeDetailCell.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 11/9/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class RecipeDetailTableCell:UITableViewCell{
    public let recipeStepLabel = UILabel()
//    public let recipeStepImage = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        sv(
//            recipeStepImage,
            recipeStepLabel
        )
        layout(
            8,
            |-16-recipeStepLabel-16-|,
            0
        )
        recipeStepLabel.textColor = .black
        recipeStepLabel.numberOfLines = 0
        recipeStepLabel.centerVertically()
        recipeStepLabel.centerHorizontally()
        //image setting
//        recipeStepImage.contentMode = .scaleAspectFit
    }
}

