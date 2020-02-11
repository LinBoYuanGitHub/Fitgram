//
//  CoachDetailView.swift
//  fitgram
//
//  Created by boyuan lin on 17/1/20.
//  Copyright © 2020 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class CoachDetailView: UIView {
    public var coachTitleLabel = UILabel()
    public var coachViewContainer = UIView()
    public var coachPortraitImageView = UIImageView()
    public var coachInfoContainer = UIView()
    public var coachClubLabel = UILabel()
    public var coachNameLabel = UILabel()
    public var coachImageArrow = UIImageView()
    
    public var exerciseTitleLabel = UILabel()
    public var exerciseCollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    convenience init(){
        self.init(frame: .zero)
        self.backgroundColor = .white
        sv(
            coachTitleLabel,
            coachViewContainer.sv(
                coachPortraitImageView,
                coachInfoContainer.sv(
                    coachClubLabel,
                    coachNameLabel
                ),
                coachImageArrow
            ),
            exerciseTitleLabel,
            exerciseCollectionView
        )
        layout(
            20,
            |-8-coachTitleLabel-|,
            10,
            |-16-coachViewContainer-16-| ~ 100,
            30,
            |-8-exerciseTitleLabel-|,
            10,
            |-0-exerciseCollectionView-0-|
        )
        layout(
            10,
            |-16-coachPortraitImageView-2-coachInfoContainer-coachImageArrow-16-|,
            10
        )
        layout(
            |-coachClubLabel-|,
            |-coachNameLabel-|
        )
        coachTitleLabel.font = UIFont(name: "PingFangSC-Regular", size: 18)
        exerciseTitleLabel.font = UIFont(name: "PingFangSC-Regular", size: 18)
        coachClubLabel.font = UIFont(name: "PingFangSC-Medium", size: 14)
        coachNameLabel.font = UIFont(name: "PingFangSC-Light", size: 13)
        coachImageArrow.image = UIImage(named: "rightArrow_black")
        coachImageArrow.width(8)
        coachImageArrow.height(13)
        coachViewContainer.layer.shadowOffset = CGSize(width: 0, height: 0) //no shadow direction
        coachViewContainer.layer.cornerRadius = 10
        coachViewContainer.layer.shadowColor = UIColor.black.cgColor
        coachViewContainer.layer.shadowOpacity = 0.2
        coachViewContainer.layer.shadowRadius = 10
        coachViewContainer.backgroundColor = UIColor.white
        coachTitleLabel.text = "我的教练"
        exerciseTitleLabel.text = "我的运动"
        coachPortraitImageView.width(65)
        coachPortraitImageView.height(65)
        coachPortraitImageView.image = UIImage(named: "coachDefault_icon")
        coachInfoContainer.height(40)
        coachInfoContainer.centerVertically()
        exerciseCollectionView.backgroundColor = .white
        exerciseCollectionView.register(ExerciseItemCell.self, forCellWithReuseIdentifier: "ExerciseItemCell")
        exerciseCollectionView.showsHorizontalScrollIndicator = false
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        let sideLength = (UIScreen.main.bounds.width - 60) / 2
        layout.itemSize = CGSize(width: sideLength, height: 230)
        exerciseCollectionView.collectionViewLayout = layout
        exerciseCollectionView.width(UIScreen.main.bounds.width)
        exerciseCollectionView.height(240)
    }
}
