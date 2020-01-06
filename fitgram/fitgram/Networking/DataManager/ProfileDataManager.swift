//
//  ProfileDataService.swift
//  fitgram
//
//  Created by boyuan lin on 22/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import Foundation
import SwiftGRPC

class ProfileDataManager{
    static let shared = ProfileDataManager()
    
    var address: String
    public var client: Apisvr_UserServiceServiceClient!
    public var profile = Apisvr_GetUserProfileResp()
    
    private init() {
        address = Bundle.main.object(forInfoDictionaryKey: "GRPC_Address") as! String
        gRPC.initialize()
        print("GRPC version \(gRPC.version) - endpoint: \(address)")
        self.client = Apisvr_UserServiceServiceClient(address: address, secure: true)
    }
    
    public func getUserProfile(completion: @escaping (Bool) -> Void, failureCompletion: @escaping (String) -> Void){
        let req = Apisvr_GetUserProfileReq()
        do{
            guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                return
            }
            let metadata = try Metadata(["authorization": "Token " + token])
            try self.client.getUserProfile(req, metadata:metadata, completion: { (resp, result) in
                if result.statusCode == .ok {
                    self.profile = resp!
                    completion(true)
                }
            })
        } catch {
            failureCompletion(error.localizedDescription)
        }
    }
    
    public func updateUserProfile(completion: @escaping (Bool) -> Void, failureCompletion: @escaping (String) -> Void){
        var req = Apisvr_UpdateUserProfileReq()
        req.activityLevel = profile.activityLevel
        req.birthYear = profile.birthYear
        req.gender = profile.gender
        req.goal = profile.goal
        req.height = profile.height
        req.weight = profile.weight
        req.bodyType = profile.bodyType
        req.targetBodyType = profile.targetBodyType
        
        do{
            guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                return
            }
            let metadata = try Metadata(["authorization": "Token " + token])
            try self.client.updateUserProfile(req, metadata: metadata) { (resp, result) in
                if result.statusCode == .ok {
                    completion(true)
                } else {
                    failureCompletion(result.statusMessage!)
                }
            }
        } catch {
            failureCompletion(error.localizedDescription)
        }
       
    }
    
    
    
    
    
    
    
}
