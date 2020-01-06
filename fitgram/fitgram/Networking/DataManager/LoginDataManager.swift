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
    public var userId = UserDefaults.standard.string(forKey: Constants.userIdKey) ?? ""
    
    public var user = Apisvr_GetUserProfileResp()
    
    private init() {
        address = Bundle.main.object(forInfoDictionaryKey: "GRPC_Address") as! String
//        address = "172.29.32.226:10000"
//        address = "api.gram.fit:1443"
        gRPC.initialize()
        self.client = Apisvr_LoginServiceServiceClient(address: address, secure: true)
        print("GRPC version \(gRPC.version) - endpoint: \(address)")
    }
    
    func getUserStatus() -> Apisvr_UserType {
        let rawValue = UserDefaults.standard.integer(forKey: Constants.userStatusKey)
        let userStatus = Apisvr_UserType(rawValue: rawValue)!
        return userStatus
    }
    
    func anonymousLogin (completition: @escaping (Bool) -> Void) throws {
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
                if result.statusCode == .ok {
                    completition(resp!.isExist)
                }else {
                    failureCompletion(result.statusMessage!)
                }
            }
        } catch {
            failureCompletion(error.localizedDescription)
        }
    }
    
    func phonePwdLogin (phone:String, password:String, completition: @escaping (Bool) -> Void,failureCompletion:@escaping (String) -> Void) {
        do{
            var req = Apisvr_AppLoginReq()
            req.phone = phone
            req.password = password
            try self.client.appLogin(req) { (resp, result) in
                if result.statusCode == .ok {
                    let token = resp?.token
                    UserDefaults.standard.set(token, forKey: Constants.tokenKey)
                    let userStatus = resp?.userType
                    UserDefaults.standard.set(userStatus, forKey: Constants.userStatusKey)
                    completition(true)
                }else {
                    failureCompletion(result.statusMessage!)
                }
            }
        } catch {
            failureCompletion(error.localizedDescription)
        }
    }
    
    func sendVerificationCode(phone:String, purpose:Apisvr_OtpType, completion: @escaping (Bool) -> Void,failureCompletion:@escaping (String) -> Void){
        do{
            var req = Apisvr_GetOneTimePasswordReq()
            req.phone = phone
            req.purpose = purpose
            req.userID = UserDefaults.standard.string(forKey: Constants.userIdKey)!
            try self.client.getOneTimePassword(req,  completion: { (resp, result) in
                if result.statusCode == .ok {
                    completion(true)
                } else {
                    failureCompletion(result.statusMessage!)
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
                if result.statusCode == .ok {
                    let token = resp?.token
                    UserDefaults.standard.set(token, forKey: Constants.tokenKey)
                    let userStatus = resp?.userType
                    UserDefaults.standard.set(userStatus?.rawValue, forKey: Constants.userStatusKey)
                    completition(resp!.isNewUser)
                } else {
                    failureCompletion(result.statusMessage!)
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
