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

    
    init() {
        address = Bundle.main.object(forInfoDictionaryKey: "GRPC_Address") as! String
        gRPC.initialize()
        print("GRPC version \(gRPC.version) - endpoint: \(address)")
    }
    
    
    func RetrieveRecommendationList (dateStr:String, completition: @escaping ([RecommendationModel]) -> Void){
        self.client = Apisvr_RecommendationServiceServiceClient(address: address, secure: false)
        var request = Apisvr_GetRecommendedMealPlanReq()
        request.date = dateStr
        do{
            let token = UserDefaults.standard.string(forKey: "token")!
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
                    let breakfastEntity = RecommendationModel(mealTitle: "早餐", recipeList: breakFastRecipeList)
                    var lunchRecipeList = [RecipeModel]()
                    for item in mealPlan.lunch {
                        lunchRecipeList.append(self.mealPlanItem2RecipeItem(item:item))
                    }
                    let lunchEntity = RecommendationModel(mealTitle: "午餐", recipeList: lunchRecipeList)
                    var dinnerRecipeList = [RecipeModel]()
                    for item in mealPlan.dinner {
                        dinnerRecipeList.append(self.mealPlanItem2RecipeItem(item:item))
                    }
                    let dinnerEntity = RecommendationModel(mealTitle: "晚餐", recipeList: dinnerRecipeList)
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
        recipe.recipeCookingDuration =  "烹饪时间约\(item.cookingTime)分钟"
        recipe.recipeCalorie = "\(item.energy)千卡"
        recipe.recipeTitle = item.recipeName
        recipe.videoCoverImageUrl = item.sampleImgURL
        return recipe
    }
    
    
}
