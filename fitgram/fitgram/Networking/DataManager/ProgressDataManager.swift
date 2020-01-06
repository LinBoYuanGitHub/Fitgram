//
//  ProgressDataManager.swift
//  fitgram
//
//  Created by boyuan lin on 16/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//
import SwiftGRPC

class ProgressDataManager {
    var address: String
    public var client:Apisvr_ProgressServiceServiceClient!
    
    static let shared = ProgressDataManager()
    
    private init() {
        address = Bundle.main.object(forInfoDictionaryKey: "GRPC_Address") as! String
        gRPC.initialize()
        print("GRPC version \(gRPC.version) - endpoint: \(address)")
        self.client = Apisvr_ProgressServiceServiceClient(address: address, secure: true)
    }
    
}
