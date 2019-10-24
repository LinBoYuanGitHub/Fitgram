//
//  LoginDataManagert.swift
//  fitgram
//
//  Created by boyuan lin on 18/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import Foundation
import SwiftGRPC

class LoginDataManager {
    var address: String
    var client: Apisvr_LoginServiceServiceClient!
    
    init() {
        address = Bundle.main.object(forInfoDictionaryKey: "GRPC_Address") as! String
        gRPC.initialize()
        print("GRPC version \(gRPC.version) - endpoint: \(address)")
    }
    
    func anonymousLogin (completition: @escaping (Bool) -> Void) throws{
        self.client = Apisvr_LoginServiceServiceClient(address: address, secure: false)
        var request = Apisvr_AnonymousLoginReq()
        request.userID = UserDefaults.standard.string(forKey: Constants.userIdKey) ?? ""
        try self.client.anonymousLogin(request, completion: { (resp, result) in
            if(result.statusCode == .ok){
                guard let token = resp?.token else {
                    return
                }
                UserDefaults.standard.set(token, forKey: Constants.tokenKey)
                guard let userId = resp?.userID else {
                    return
                }
                UserDefaults.standard.set(userId, forKey: Constants.userIdKey)
                completition(true)
            } else {
                //status code error flow
                completition(false)
            }
        })
    }
    
    
}
