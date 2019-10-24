//
//  ProfileDataService.swift
//  fitgram
//
//  Created by boyuan lin on 22/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import Foundation
import SwiftGRPC

class ProfileDataService{
    var address: String
    public var client: Apisvr_UserServiceServiceClient!
    
    init() {
        address = Bundle.main.object(forInfoDictionaryKey: "GRPC_Address") as! String
        gRPC.initialize()
        print("GRPC version \(gRPC.version) - endpoint: \(address)")
        self.client = Apisvr_UserServiceServiceClient(address: address, secure: false)
    }
    
    
    
}
