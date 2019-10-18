//
//  ProfileView.swift
//  fitgram
//
//  Created by boyuan lin on 18/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class ProfileView:UIView{
    let profileTableView = UITableView.init()
    
    convenience init() {
        self.init(frame: CGRect.zero)
        sv(
            profileTableView
        )
        layout(
            0,
            |-profileTableView-|,
            0
        )
        self.backgroundColor = .white
        profileTableView.register(ProfileTableCell.self, forCellReuseIdentifier: "ProfileTableCell")
    }
    
    
    
    
}
