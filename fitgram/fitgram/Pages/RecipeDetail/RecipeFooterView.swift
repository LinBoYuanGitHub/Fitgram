//
//  RecipeFooterView.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 8/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class RecipeFooterView: UIView {
    public var checkButton = UIButton(frame: CGRect(x: 16, y: 0, width: UIScreen.main.bounds.width - 32, height: 50))
    
    convenience init(){
        self.init(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        checkButton.backgroundColor = UIColor(red: 252/255, green: 200/255, blue: 45/255, alpha: 1)
        checkButton.tintColor = UIColor.white
        checkButton.setTitle("打卡", for: .normal)
        checkButton.layer.cornerRadius = 20
        checkButton.setImage(UIImage(named: "camera_checkedIcon_white"), for: .normal)
        checkButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        self.addSubview(checkButton)
    }
    
}
