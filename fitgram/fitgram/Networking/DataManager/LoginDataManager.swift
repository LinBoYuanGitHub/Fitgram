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
    
    func anonymousLogin (completition: @escaping (Bool) -> Void){
        self.client = Apisvr_LoginServiceServiceClient(address: address, secure: false)
        var request = Apisvr_AnonymousLoginReq()
        request.userID = ""
        do{
            try self.client.anonymousLogin(request, completion: { (resp, result) in
                if(result.statusCode == .ok){
                    guard let token = resp?.token else {
                        return
                    }
                    UserDefaults.standard.set(token, forKey: "token")
                    completition(true)
                } else {
                    //status code error flow
                    completition(false)
                }
            })
        } catch {
            print(error)
            completition(false)
        }
    }
    
    
}
