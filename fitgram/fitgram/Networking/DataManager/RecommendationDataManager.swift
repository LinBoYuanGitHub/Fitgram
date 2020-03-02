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
        self.client = Apisvr_RecommendationServiceServiceClient(address: address, secure: true)
    }
    
    func retrieveRecommendationList (dateStr:String, completition: @escaping ([RecommendationModel]) -> Void){
        var request = Apisvr_GetRecommendedMealPlanReq()
        let calendar = Calendar(identifier: .chinese)
        let components = calendar.dateComponents([.year,.month,.day],from: Date())
        request.date = Int64(calendar.date(from: components)!.timeIntervalSince1970)
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
                    let breakfastEntity = RecommendationModel(mealTitle: "Breakfast", recipeList: breakFastRecipeList, selected_Pos: 0)
                    var lunchRecipeList = [RecipeModel]()
                    for item in mealPlan.lunch {
                        lunchRecipeList.append(self.mealPlanItem2RecipeItem(item:item))
                    }
                    let lunchEntity = RecommendationModel(mealTitle: "Lunch", recipeList: lunchRecipeList, selected_Pos: 0)
                    var dinnerRecipeList = [RecipeModel]()
                    for item in mealPlan.dinner {
                        dinnerRecipeList.append(self.mealPlanItem2RecipeItem(item:item))
                    }
                    let dinnerEntity = RecommendationModel(mealTitle: "Dinner", recipeList: dinnerRecipeList, selected_Pos: 0)
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
        recipe.recipeCalorie = "\(Int(item.nutrient.energy)) kCal"
        recipe.recipeTitle = item.recipeName
        recipe.videoCoverImageUrl = item.sampleImgURL
        recipe.recipeVideoUrl = item.videoURL
        recipe.nutrientData = item.nutrient
        recipe.isLike = item.isFavourite
        recipe.isChecked = item.isChecked
        return recipe
    }
    
    func retrieveRecipeDetail(recipeId: Int, completition: @escaping (RecipeModel) -> Void) throws {
        var request = Apisvr_GetRecipeDetailReq()
        request.recipeID = Int32(recipeId)
        let calendar = Calendar(identifier: .chinese)
        let components = calendar.dateComponents([.year,.month,.day],from: Date())
        request.date = Int64(calendar.date(from: components)!.timeIntervalSince1970)
        guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
            return
        }
        let metaData = try Metadata(["authorization": "Token " + token])
        try self.client.getRecipeDetail(request, metadata: metaData, completion: { (resp, result) in
            if(result.statusCode == .ok){
                //ingredient convertsion
                var recipe = RecipeModel()
                recipe.recipeId = Int(resp!.recipeID)
                recipe.recipeCookingDuration =  Int(resp!.cookingTime)
                recipe.difficulity = resp!.difficulty
                recipe.recipeTitle = resp!.recipeName
                recipe.videoCoverImageUrl = resp!.sampleImgURL
                recipe.recipeVideoUrl = resp!.videoURL
                recipe.nutrientData = resp!.nutrient
                recipe.isLike = resp!.isFavourite
                recipe.isChecked = resp!.isChecked
                //ingrdient part
                for ingredient in resp!.ingredient {
                    var ingredientModel = IngredientModel()
                    ingredientModel.ingredientName = ingredient.name
                    if ingredient.amount == 0 {
                        ingredientModel.portionDesc = "To Taste"
                    } else {
                        ingredientModel.portionDesc = String(format: "%.1f",ingredient.amount) + ingredient.unit
                    }
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
