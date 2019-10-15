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
    public let recipeStepLabel = UILabel(frame: CGRect(x: 16, y: UIScreen.main.bounds.width+16, width: UIScreen.main.bounds.width, height:8))
    public let recipeStepImage = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        sv(
//            recipeStepImage,
//            recipeStepLabel
//        )
//        layout(
//            8,
//            |recipeStepImage| ~ UIScreen.main.bounds.width,
//            8,
//            |recipeStepLabel|
//        )
        self.addSubview(recipeStepImage)
        self.addSubview(recipeStepLabel)
        recipeStepLabel.textColor = .black
        recipeStepLabel.centerVertically()
        recipeStepLabel.centerHorizontally()
        //image setting
        recipeStepImage.contentMode = .scaleAspectFit
    }
}

