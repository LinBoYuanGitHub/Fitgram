//
//  MoreView.swift
//  fitgram
//
//  Created by boyuan lin on 31/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class MoreView: UIView {
    public var profileContainer = UIView()
    public var portraitImageView = UIImageView()
    public var portraitTitleLabel = UILabel()
    public var arrowImageView = UIImageView()
    
    public var horizontalContainer = UIView()
    
    public var coachContainer = UIView()
    public var coachMemberIcon = UIImageView()
    public var coachMemberLabel = UILabel()
    
    public var verticalView = UIView()
    
    public var nutriContainer = UIView()
    public var nutriRecommendIcon = UIImageView()
    public var nutriRecommendLabel = UILabel()
    //like part
    public var likeSegmentedControl = UISegmentedControl()
    public var seperatorLine = UIView()
    public var recipeLikeCollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    public var restaurantLikeTableView = UITableView.init()
    public var likeViewContainer = UIView()
//    public var restaurantLikeATableView = UITableView()
    
    //tap callback event
    public var onProfileContainerTapEvent: () -> Void = {}
    public var onCoachViewTapEvent: () -> Void = {}
    public var onNutriViewTapEvent: () -> Void = {}
    
    convenience init(){
        self.init(frame: .zero)
        self.backgroundColor = .white
        sv(
            profileContainer.sv(
                portraitImageView,
                portraitTitleLabel,
                arrowImageView
            ),
            horizontalContainer.sv(
                    coachMemberIcon,
                    coachMemberLabel
            ),
            likeSegmentedControl,
            seperatorLine,
            likeViewContainer
        )
        layout(
            50,
            |-profileContainer-| ~ 100,
            20,
            |-1-horizontalContainer-1-| ~ 80,
            10,
            |-32-likeSegmentedControl-32-| ~ 50,
            10,
            |-0-seperatorLine-0-|,
            10,
            |-8-likeViewContainer-8-|,
            0
        )
        layout(
             |-32-portraitImageView-20-portraitTitleLabel-arrowImageView-32-|
        )
        layout(
            |-(UIScreen.main.bounds.width/2-12)-coachMemberIcon-(UIScreen.main.bounds.width/2-12)-|,
            |-(UIScreen.main.bounds.width/2-18)-coachMemberLabel-(UIScreen.main.bounds.width/2-18)-|
        )
//        layout(
//            |-nutriRecommendIcon-|,
//            |-nutriRecommendLabel-|
//        )
        portraitImageView.width(80)
        portraitImageView.height(80)
        portraitImageView.contentMode = .scaleToFill
        portraitImageView.image = UIImage(named: "profile_avatar")
        portraitImageView.centerVertically()
        portraitTitleLabel.font = UIFont(name: "PingFangSC-Medium", size: 20)
        portraitTitleLabel.text = "AAA"
        portraitTitleLabel.centerVertically()
        
        arrowImageView.image = UIImage(named: "rightArrow_black")
        arrowImageView.width(10)
        arrowImageView.height(15)
        arrowImageView.centerVertically()
        
//        horizontalContainer.width(UIScreen.main.bounds.width)
//        horizontalContainer.height(80)
        horizontalContainer.layer.borderWidth = 1
        horizontalContainer.layer.borderColor = UIColor.lightGray.cgColor
        horizontalContainer.isUserInteractionEnabled = true
        
        coachMemberIcon.width(25)
        coachMemberIcon.height(16)
        coachMemberIcon.centerHorizontally()
        coachMemberIcon.centerVertically()
        coachMemberIcon.image = UIImage(named: "more_cardIcon")
        
        coachMemberLabel.text = "Member"
        coachMemberLabel.font = UIFont(name: "PingFangSC-Regular", size: 14)
        coachMemberLabel.centerHorizontally()
        coachMemberLabel.width(100)
//        coachMemberLabel.height(20)
        
//        nutriContainer.height(80)
//        nutriContainer.width(UIScreen.main.bounds.width/2)
//        verticalView.width(1)
//        verticalView.height(44)
//        verticalView.centerHorizontally()
//        verticalView.centerVertically()
//        verticalView.backgroundColor = .lightGray
        
//        nutriRecommendIcon.width(20)
//        nutriRecommendIcon.height(20)
//        nutriRecommendIcon.centerHorizontally()
//        nutriRecommendIcon.centerVertically()
//        nutriRecommendIcon.image = UIImage(named: "more_nutriIcon")
//
//        nutriRecommendLabel.width(56)
//        nutriRecommendLabel.text = "营养推荐"
//        nutriRecommendLabel.font = UIFont(name: "PingFangSC-Regular", size: 14)
//        nutriRecommendLabel.centerHorizontally()
        
        let profileTapAction = UITapGestureRecognizer(target: self, action: #selector(onProfileContainerTap))
        profileContainer.addGestureRecognizer(profileTapAction)
        let coachTapAction = UITapGestureRecognizer(target: self, action: #selector(onCoachViewTap))
        horizontalContainer.addGestureRecognizer(coachTapAction)
//        let nutriTapAction = UITapGestureRecognizer(target: self, action: #selector(onNutriViewTap))
//        nutriContainer.addGestureRecognizer(nutriTapAction)
        //like part
        likeSegmentedControl.insertSegment(withTitle: "Favourite", at: 0, animated: false)
        likeSegmentedControl.insertSegment(withTitle: "Restaurant", at: 1, animated: false)
        likeSegmentedControl.selectedSegmentIndex = 0
//        let yellowLineColor = UIColor(red: 252/255, green: 200/255, blue: 45/255, alpha: 1)
        likeSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                                     NSAttributedString.Key.font: UIFont(name: "PingFangSC-Medium", size: 14)!], for: .normal)
        likeSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black,
                                                     NSAttributedString.Key.font: UIFont(name: "PingFangSC-Medium", size: 14)!], for: .selected)
        likeSegmentedControl.tintColor = .white
        seperatorLine.width(UIScreen.main.bounds.width)
        seperatorLine.height(1)
        seperatorLine.backgroundColor = .lightGray
        seperatorLine.alpha = 0.3
        //recipe collection
        recipeLikeCollectionView.backgroundColor = .white
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        layout.footerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 20)
        recipeLikeCollectionView.collectionViewLayout = layout
        recipeLikeCollectionView.showsVerticalScrollIndicator = false
        recipeLikeCollectionView.register(LikeCollectionViewCell.self, forCellWithReuseIdentifier: "LikeCollectionViewCell")
        //restaurant list
        restaurantLikeTableView.backgroundColor = .white
        restaurantLikeTableView.showsVerticalScrollIndicator = false
        restaurantLikeTableView.register(LikeTableViewCell.self, forCellReuseIdentifier: "LikeTableViewCell")
        restaurantLikeTableView.tableFooterView = UIView()
    }
    
    func switchToRestaurantLikeTableView() {
        self.recipeLikeCollectionView.removeFromSuperview()
        restaurantLikeTableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 16, height: self.likeViewContainer.frame.height)
        self.likeViewContainer.addSubview(restaurantLikeTableView)
    }
    
    func switchToRecipeCollectionView() {
        self.restaurantLikeTableView.removeFromSuperview()
        recipeLikeCollectionView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 16, height: self.likeViewContainer.frame.height)
        self.likeViewContainer.addSubview(recipeLikeCollectionView)
    }
    
    func addTopAndBottomBorders(targetView:UIView) {
        let thickness:CGFloat = 1
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0.0, y: 0.0, width: targetView.frame.size.width, height: thickness)
        topBorder.backgroundColor = UIColor.lightGray.cgColor
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x:0, y: targetView.frame.size.height - thickness, width: targetView.frame.size.width, height:thickness)
        bottomBorder.backgroundColor  = UIColor.lightGray.cgColor
        targetView.layer.addSublayer(topBorder)
        targetView.layer.addSublayer(bottomBorder)
    }
    
    
    @objc func onProfileContainerTap(){
        self.onProfileContainerTapEvent()
    }
    
    @objc func onCoachViewTap(){
        self.onCoachViewTapEvent()
    }
    
    @objc func onNutriViewTap(){
        self.onNutriViewTapEvent()
    }
    
}
