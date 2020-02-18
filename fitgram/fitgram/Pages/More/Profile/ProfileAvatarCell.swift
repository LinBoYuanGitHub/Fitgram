//
//  ProfileAvatarCell.swift
//  fitgram
//
//  Created by boyuan lin on 25/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class ProfileAvatarCell:UITableViewCell {
    let profileInfoLabel = UILabel()
    let profileAvatarView = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        sv(
            profileInfoLabel,
            profileAvatarView
        )
        layout(
            |-32-profileInfoLabel-profileAvatarView-32-|
        )
        self.backgroundColor = .white
        profileInfoLabel.centerVertically()
        profileInfoLabel.font = UIFont(name: "PingFangSC-Regular", size: 17)
        profileInfoLabel.textColor = .black
        profileInfoLabel.sizeToFit()
        
        profileAvatarView.width(77)
        profileAvatarView.height(77)
        profileAvatarView.contentMode = .scaleAspectFit
//        profileAvatarView.layer.cornerRadius =  profileAvatarView.frame.width/2
//        profileAvatarView.clipsToBounds = true
        profileAvatarView.image = UIImage(named: "profile_avatar")
        self.clipsToBounds = true
    }
    
}

