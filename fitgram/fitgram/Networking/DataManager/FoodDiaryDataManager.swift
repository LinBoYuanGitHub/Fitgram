//
//  FoodDiaryDataManager.swift
//  fitgram
//
//  Created by boyuan lin on 26/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import SwiftGRPC

class FoodDiaryDataManager {
    var address: String
    public var client:Apisvr_FoodDiaryServiceServiceClient!
    
    static let shared = FoodDiaryDataManager()
    //management part -> for the data list
    public var foodDiaryList = [Apisvr_FoodDiaryMealLog]()
    
    
    private init(){
        address = Bundle.main.object(forInfoDictionaryKey: "GRPC_Address") as! String
        gRPC.initialize()
        print("GRPC version \(gRPC.version) - endpoint: \(address)")
        self.client = Apisvr_FoodDiaryServiceServiceClient(address: address, secure: true)
    }
    
    
    
}
