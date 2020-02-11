//
//  PicCollectionCell.swift
//  fitgram
//
//  Created by boyuan lin on 10/2/20.
//  Copyright © 2020 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class PicCollectionCell: UICollectionViewCell{
    
    public var bodyShapePicImageView = UIImageView()
    public var weightLabel = UILabel()
    public var dateLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sv(
            bodyShapePicImageView,
            weightLabel,
            dateLabel
        )
        layout(
            |-bodyShapePicImageView-|,
            2,
            |-0-weightLabel-dateLabel-0-|
        )
        bodyShapePicImageView.contentMode = .scaleAspectFill
        bodyShapePicImageView.width(150)
        bodyShapePicImageView.height(150)
        bodyShapePicImageView.layer.cornerRadius = 10
        bodyShapePicImageView.layer.masksToBounds = true
        weightLabel.textColor = .black
        weightLabel.font = UIFont(name: "PingFangSC-Light", size: 11)
        dateLabel.font = UIFont(name: "PingFangSC-Light", size: 11)
        dateLabel.textColor = .lightGray
    }
    
    
}
