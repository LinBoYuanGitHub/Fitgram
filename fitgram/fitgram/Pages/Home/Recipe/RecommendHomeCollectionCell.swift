//
//  RecommendHomeCollectionCell.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 24/9/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class RecommendHomeCollectionCell: UICollectionViewCell {
    public var videoPlayView = UIImageView()
    public var videoTitleLabel = UILabel()
    public var videoCalorieLabel = UILabel()
    public var videoDurationBtn = UIButton()
    public var likeButton = UIButton()
    public var checkedButton = UIButton()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sv(
            videoPlayView
        )
        layout(
            0,
            |videoPlayView| ~ UIScreen.main.bounds.width - 40,
            0
        )
        //videoImage view setting
//        videoPlayView.frame.size.width = UIScreen.main.bounds.width - 100 // screen width - offset-width
        videoPlayView.backgroundColor = .black
        videoPlayView.centerHorizontally()
        videoPlayView.layer.cornerRadius = 10.0
        videoPlayView.layer.masksToBounds = true
        //calorie value
        videoCalorieLabel.frame.origin.x = 16
        videoCalorieLabel.frame.origin.y = 16
        videoCalorieLabel.frame.size.width = self.frame.size.width - 32
        videoCalorieLabel.frame.size.height = 24
        videoCalorieLabel.textAlignment = .left
        videoCalorieLabel.textColor = .white
        videoCalorieLabel.font = UIFont(name: "PingFangSC-Medium", size: 17)
        videoPlayView.addSubview(videoCalorieLabel)
        videoPlayView.bringSubviewToFront(videoCalorieLabel)
        //video title
        videoTitleLabel.frame.origin.x = 16
        videoTitleLabel.frame.origin.y = 40
        videoTitleLabel.frame.size.width = self.frame.size.width - 32
        videoTitleLabel.frame.size.height = 33
        videoTitleLabel.textAlignment = .left
        videoTitleLabel.textColor = .white
        videoTitleLabel.font = UIFont(name: "PingFangSC-Medium", size: 24)
        videoPlayView.addSubview(videoTitleLabel)
        videoPlayView.bringSubviewToFront(videoTitleLabel)
        //video durationText
        videoDurationBtn.frame.origin.x = 20
        videoDurationBtn.frame.origin.y = self.frame.size.height - 35
        videoDurationBtn.frame.size.width = self.frame.size.width - 32
        videoDurationBtn.frame.size.height = 20
        videoDurationBtn.titleLabel!.textAlignment = .center
        videoDurationBtn.tintColor = .white
        videoDurationBtn.titleLabel!.font = UIFont(name: "PingFangSC-Medium", size: 14)
        videoDurationBtn.setImage(UIImage(named: "clockIcon_white"), for: .normal)
        videoDurationBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        videoPlayView.addSubview(videoDurationBtn)
        videoPlayView.bringSubviewToFront(videoDurationBtn)
        //like button
        likeButton.frame.origin.x = 16
        likeButton.frame.origin.y = self.frame.size.height - 33
        likeButton.frame.size.width = 15
        likeButton.frame.size.height = 15
        likeButton.setImage(UIImage(named: "heartIcon_white"), for: .normal)
        likeButton.setImage(UIImage(named: "heartIcon_red"), for: .selected)
        videoPlayView.addSubview(likeButton)
        videoPlayView.bringSubviewToFront(likeButton)
        //check button
        checkedButton.frame.origin.x = self.frame.size.width - 64
        checkedButton.frame.origin.y = self.frame.size.height - 33
        checkedButton.frame.size.width = 58
        checkedButton.frame.size.height = 20
        checkedButton.titleLabel!.font = UIFont(name: "PingFangSC-Medium", size: 14)
        checkedButton.setImage(UIImage(named: "plusIcon_white"), for: .normal)
        checkedButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        videoPlayView.addSubview(checkedButton)
        videoPlayView.bringSubviewToFront(checkedButton)
    }
    
    
    
    
}
