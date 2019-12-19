//
//  PhotoRecordHomeView.swift
//  fitgram
//
//  Created by boyuan lin on 19/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class PhotoRecordHomeView: UIView {
    public var emptyView = UIView()
    public var photoImageView = UIImageView()
    public var photoTitleLabel = UILabel()
    public var photoDescLabel = UILabel()
    public var photoRecordBtn = UIButton()
    
    public var onPhotoTakingBtnPressedEvent: () -> Void = { }
    
    convenience init(){
        self.init(frame: .zero)
        self.backgroundColor = .white
        sv(
            photoImageView,
            photoTitleLabel,
            photoDescLabel,
            photoRecordBtn
        )
        layout(
            50,
            |-32-photoImageView-32-| ~ 225,
            10,
            |-photoTitleLabel-|,
            5,
            |-photoDescLabel-|,
            50,
            |-0-photoRecordBtn-0-| ~ 50,
            20
        )
        photoTitleLabel.textAlignment = .center
        photoTitleLabel.text = "拍一张照片"
        photoTitleLabel.font = UIFont(name: "PingFangSC-Medium", size: 20)
        
        photoDescLabel.textAlignment = .center
        photoDescLabel.font = UIFont(name: "PingFangSC-Regular", size: 16)
        photoDescLabel.textColor = .lightGray
        photoDescLabel.numberOfLines = 3
        photoDescLabel.text = "用照片记录你的身材变化过程,\n让你的每一次进步都可以被看得见。\n身材变化过程"
        
        photoRecordBtn.width(UIScreen.main.bounds.width)
        photoRecordBtn.backgroundColor = UIColor(red: 252/255, green: 200/255, blue: 45/255, alpha: 1)
        photoRecordBtn.setTitle("记录体重", for: .normal)
        photoRecordBtn.setTitleColor(.white, for: .normal)
        photoRecordBtn.titleLabel?.textAlignment = .center
        photoRecordBtn.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 18)
        photoRecordBtn.addTarget(self, action: #selector(onPhotoTakingBtnPressed), for: .touchUpInside)
    }
    
    @objc func onPhotoTakingBtnPressed(){
        self.onPhotoTakingBtnPressedEvent()
    }
}
