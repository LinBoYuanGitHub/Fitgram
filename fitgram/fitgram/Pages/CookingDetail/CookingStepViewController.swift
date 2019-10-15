//
//  CookingStepViewController.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 9/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class CookingStepViewController: UIViewController {
    var stepImage = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
    var stepLabel = UILabel(frame: CGRect(x: 16, y:  UIScreen.main.bounds.width, width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.height - UIScreen.main.bounds.width))
    var imageUrl = ""
    var stepText = ""
    var checkBtn = UIButton(frame: CGRect(x: 16, y: UIScreen.main.bounds.width + 120, width: UIScreen.main.bounds.width - 64, height: 50))
    //last page judge ment
    var isLast:Bool = false
    
    override func loadView() {
        let newView = UIView()
        newView.backgroundColor = UIColor.white
        view = newView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //load stepImage
        stepImage.contentMode = .scaleAspectFit
        stepImage.kf.setImage(with: URL(string: imageUrl))
        //set up step text
        stepLabel.text = stepText
        stepLabel.numberOfLines = 0
        if isLast {
            stepLabel.frame = CGRect(x: 16, y: UIScreen.main.bounds.width, width: UIScreen.main.bounds.width - 32, height: 120)
            stepLabel.font = UIFont(name: "PingFangSC-Light", size: 14)
            stepLabel.textAlignment = .center
            //check btn settting
            checkBtn.backgroundColor = UIColor(red: 252/255, green: 200/255, blue: 45/255, alpha: 1)
            checkBtn.tintColor = UIColor.white
            checkBtn.setTitle("打卡", for: .normal)
            checkBtn.layer.cornerRadius = 20
            checkBtn.setImage(UIImage(named: "camera_checkedIcon_white"), for: .normal)
            checkBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            self.view.addSubview(checkBtn)
        } else {
            stepLabel.font = UIFont(name: "PingFangSC-Light", size: 28)
            stepLabel.textAlignment = .left
            stepLabel.sizeToFit()
        }
        self.view.addSubview(stepImage)
        self.view.addSubview(stepLabel)
    }
    
    
    
    
}
