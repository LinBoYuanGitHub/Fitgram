//
//  ProfileTableCell.swift
//  fitgram
//
//  Created by boyuan lin on 18/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class ProfileTableCell:UITableViewCell {
    let profileInfoLabel = UILabel()
    let profileInfoTextField = UITextField()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       sv(
            profileInfoLabel,
            profileInfoTextField
        )
        layout(
            |-32-profileInfoLabel-profileInfoTextField-32-|
        )
        self.backgroundColor = .white
        profileInfoLabel.font = UIFont(name: "PingFangSC-Regular", size: 17)
        profileInfoLabel.textColor = .black
        profileInfoTextField.textColor = .gray
    }
}
