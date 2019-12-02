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
    private var address: String
    var client: Apisvr_LoginServiceServiceClient!
    
    static let shared = LoginDataManager()
    
    //private param
    public var userId = ""
    
    public var user = Apisvr_GetUserProfileResp()
    
    private init() {
        address = Bundle.main.object(forInfoDictionaryKey: "GRPC_Address") as! String
//        address = "172.29.32.226:10000"
//        address = "api.gram.fit:443"
        gRPC.initialize()
        print("GRPC version \(gRPC.version) - endpoint: \(address)")
    }
    
    func anonymousLogin (completition: @escaping (Bool) -> Void) throws{
        self.client = Apisvr_LoginServiceServiceClient(address: address, secure: false)
//        guard let caU = Bundle.main.url(forResource: "server", withExtension: "pem") else {
//            return
//        }
//        let certificates = try! String(contentsOf: caU)
//        guard let clientU = Bundle.main.url(forResource: "client", withExtension: "pem") else {
//            return
//        }
//        let clientCert = try! String(contentsOf: clientU)
//        guard let clientKeyU = Bundle.main.url(forResource: "client", withExtension: "key") else {
//            return
//        }
//        let clientKey = try! String(contentsOf: clientKeyU)
//        self.client = Apisvr_LoginServiceServiceClient(address: address, certificates: clientCert)
//        guard let certUrl = Bundle.main.url(forResource: "fullchain", withExtension: "pem") else {
//            return
//        }
//        let cert = try! String(contentsOf: certUrl)
//        self.client = Apisvr_LoginServiceServiceClient(address: apiAddress, certificates: cert)
//        self.client = Apisvr_LoginServiceServiceClient(address: address, certificates: certificate)
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
                self.userId = userId
                UserDefaults.standard.set(userId, forKey: Constants.userIdKey)
                completition(true)
            } else {
                //status code error flow
                completition(false)
            }
        })
    }
    
    
}
