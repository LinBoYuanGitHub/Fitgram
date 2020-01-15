//
//  RecipeModel.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 24/9/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import Foundation

struct RecipeModel {
    public var recipeId: Int = 0
    public var recipeTitle: String = ""
    public var recipeCalorie: String = ""
    public var recipeCookingDuration: Int = 0
    public var difficulity:Apisvr_Difficulty = .easy
    public var recipeVideoUrl: String = ""
    public var videoCoverImageUrl: String = ""
    public var isLike = false
    public var ingredientList = [IngredientModel]()
    public var stepList = [StepModel]()
    public var nutrientData = Apisvr_Nutrient()
}

