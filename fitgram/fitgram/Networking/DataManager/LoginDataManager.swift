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
        self.client = Apisvr_LoginServiceServiceClient(address: address, secure: false)
        print("GRPC version \(gRPC.version) - endpoint: \(address)")
    }
    
    func getUserStatus() -> Int {
        guard let userStatus = UserDefaults.standard.integer(forKey: Constants.userStatusKey) as Int? else {
            return 0
        }
        return userStatus
    }
    
    func anonymousLogin (completition: @escaping (Bool) -> Void) throws {
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
    
    func phoneVerification(phone:String, completition: @escaping (Bool) -> Void,failureCompletion:@escaping (String) -> Void) {
        do{
            var req = Apisvr_VerifyPhoneNumReq()
            req.phone = phone
            try self.client.verifyPhoneNum(req) { (resp, result) in
                completition(resp!.isExist)
            }
        } catch {
            failureCompletion(error.localizedDescription)
        }
    }
    
    func phonePwdLogin (phone:String, password:String, completition: @escaping (Bool) -> Void,failureCompletion:@escaping (String) -> Void) throws{
        do{
            var req = Apisvr_AppLoginReq()
            req.phone = phone
            req.password = password
            try self.client.appLogin(req) { (resp, result) in
                if result.statusCode == .ok {
                     completition(true)
                }
            }
        } catch {
            failureCompletion(error.localizedDescription)
        }
    }
    
    func sendVerificationCode(phone:String, purpose:Int, completion: @escaping (Bool) -> Void,failureCompletion:@escaping (String) -> Void){
        do{
            var req = Apisvr_GetOneTimePasswordReq()
            req.phone = phone
            req.purpose = Int32(purpose)
            req.userID = UserDefaults.standard.string(forKey: Constants.userIdKey)!
            try self.client.getOneTimePassword(req,  completion: { (resp, result) in
                if result.statusCode == .ok {
                    completion(true)
                }
            })
        } catch {
           failureCompletion(error.localizedDescription)
        }
    }
    
    func phoneSMSLogin (phone:String,otp:String, completition: @escaping (Bool) -> Void,failureCompletion:@escaping (String) -> Void){
        do{
            var req = Apisvr_OneTimePasswordLoginReq()
            req.phone = phone
            req.otp = otp
            try self.client.oneTimePasswordLogin(req) { (resp, result) in
                if result.statusCode == .ok{
                    UserDefaults.standard.set(1, forKey: Constants.userStatusKey)
                    completition(resp!.isNewUser)
                }
            }
        } catch {
            failureCompletion(error.localizedDescription)
        }
    }
    
    
    
    func resetPwd (newPwd:String,otpToken:String, completition: @escaping (Bool) -> Void,failureCompletion:@escaping (String) -> Void){
        do {
            var req = Apisvr_ResetPasswordReq()
            req.otpToken = otpToken
            req.password = newPwd
            try self.client.resetPassword(req) { (resp, result) in
                completition(true)
            }
        } catch {
           failureCompletion(error.localizedDescription)
        }
    }
    
    
}
