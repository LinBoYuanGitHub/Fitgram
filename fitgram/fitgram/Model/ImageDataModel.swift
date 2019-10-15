//
//  ImageDataModel.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 3/9/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import Foundation

struct ImageDataModel {
    public var imageIndex: Int = 0
    public var imageName: String = ""
    public var classLabel: String = ""
    public var foodScore: Double = 0.0
    public var nonFoodScore: Double = 0.0
    public var createDate: Date = Date()
    
    init(imageName:String,imageIndex:Int,classLabel:String,foodScore:Double,nonFoodScore:Double,createDate: Date) {
        self.imageIndex = imageIndex;
        self.imageName = imageName;
        self.classLabel = classLabel;
        self.foodScore = foodScore;
        self.nonFoodScore = nonFoodScore;
        self.createDate = createDate;
    }
    
}
