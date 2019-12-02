//
//  RecommendationDataManager.swift
//  fitgram
//
//  Created by boyuan lin on 17/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import Foundation
import SwiftGRPC

class RecommendationDataManager {
    
    var address: String
    var client: Apisvr_RecommendationServiceServiceClient!
    
    static let shared = RecommendationDataManager()
    
    private init() {
        address = Bundle.main.object(forInfoDictionaryKey: "GRPC_Address") as! String
        gRPC.initialize()
        print("GRPC version \(gRPC.version) - endpoint: \(address)")
        self.client = Apisvr_RecommendationServiceServiceClient(address: address, secure: false)
    }
    
    func retrieveRecommendationList (dateStr:String, completition: @escaping ([RecommendationModel]) -> Void){
        var request = Apisvr_GetRecommendedMealPlanReq()
        request.date = 0
        do{
            guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                return
            }
            let metaData = try Metadata(["authorization": "Token " + token])
            try self.client.getRecommendedMealPlan(request,metadata: metaData, completion: { (resp, result) in
                if(result.statusCode == .ok){
                    guard let mealPlan = resp else {
                        return
                    }
                    var breakFastRecipeList = [RecipeModel]()
                    for item in mealPlan.breakfast{
                        breakFastRecipeList.append(self.mealPlanItem2RecipeItem(item:item))
                    }
                    let breakfastEntity = RecommendationModel(mealTitle: "早餐", recipeList: breakFastRecipeList, selected_Pos: 0)
                    var lunchRecipeList = [RecipeModel]()
                    for item in mealPlan.lunch {
                        lunchRecipeList.append(self.mealPlanItem2RecipeItem(item:item))
                    }
                    let lunchEntity = RecommendationModel(mealTitle: "午餐", recipeList: lunchRecipeList, selected_Pos: 0)
                    var dinnerRecipeList = [RecipeModel]()
                    for item in mealPlan.dinner {
                        dinnerRecipeList.append(self.mealPlanItem2RecipeItem(item:item))
                    }
                    let dinnerEntity = RecommendationModel(mealTitle: "晚餐", recipeList: dinnerRecipeList, selected_Pos: 0)
                    completition([breakfastEntity,lunchEntity,dinnerEntity])
                } else {
                    //return error message
                }
            })
        } catch {
            print(error)
        }
    }
    
    func mealPlanItem2RecipeItem(item:Apisvr_RecommendedRecipeInfo) -> RecipeModel{
        var recipe = RecipeModel()
        recipe.recipeId = Int(item.recipeID)
        recipe.recipeCookingDuration =  Int(item.cookingTime)
        recipe.recipeCalorie = "\(Int(item.nutrient.energy))千卡"
        recipe.recipeTitle = item.recipeName
        recipe.videoCoverImageUrl = item.sampleImgURL
        recipe.recipeVideoUrl = item.videoURL
        recipe.nutrientData = item.nutrient
        return recipe
    }
    
    func retrieveRecipeDetail(recipeId: Int, completition: @escaping (RecipeModel) -> Void) throws {
        var request = Apisvr_GetRecipeDetailReq()
        request.recipeID = Int32(recipeId)
        guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
            return
        }
        let metaData = try Metadata(["authorization": "Token " + token])
        try self.client.getRecipeDetail(request, metadata: metaData, completion: { (resp, result) in
            if(result.statusCode == .ok){
                //ingredient convertsion
                var recipe = RecipeModel()
                recipe.recipeCookingDuration =  Int(resp!.cookingTime)
                recipe.difficulity = resp!.difficulty
                recipe.recipeTitle = resp!.recipeName
                recipe.videoCoverImageUrl = resp!.sampleImgURL
                recipe.recipeVideoUrl = resp!.videoURL
                recipe.nutrientData = resp!.nutrient
                //ingrdient part
                for ingredient in resp!.ingredient {
                    var ingredientModel = IngredientModel()
                    ingredientModel.ingredientName = ingredient.name
                    ingredientModel.portionDesc = String(ingredient.amount) + ingredient.unit
                    recipe.ingredientList.append(ingredientModel)
                }
                //step convertsion
                for step in resp!.step {
                    var stepModel = StepModel()
                    stepModel.stepImageUrl = step.sampleImgURL
                    stepModel.stepText = step.instruction
                    recipe.stepList.append(stepModel)
                }
                completition(recipe)
            } else {
                //return error message
            }
        })
        
    }
    
    func checkGroceryItem(){
        var request  = Apisvr_IngredientCheckReq()
        
        
    }
    
    func checkGroceryAllItem(){
        var request = Apisvr_AllIngredientCheckReq()
    }
    
    
}
