//
//  FoodDiaryTagView.swift
//  fitgram
//
//  Created by boyuan lin on 31/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import AADraggableView

class FoodDiaryTagView: UIView {
    public var respectedView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
    public var foodImage = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
    public var foodTagList = [AADraggableView]()
    public var foodLabelList = [UILabel]()
    public var instructionLabel = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.height/2 + UIScreen.main.bounds.width/2, width: UIScreen.main.bounds.width, height: 30))
    private let tagSize = CGSize(width: 90, height: 75)
    private let tagImageSize = CGSize(width: 35, height: 35)
    
    var didAddTag: () -> Void = { }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        self.addSubview(respectedView)
        self.backgroundColor = .white
        instructionLabel.numberOfLines = 2
        instructionLabel.text = "长按给图中食物添加标签"
        instructionLabel.textColor = .gray
        instructionLabel.textAlignment = .center
        instructionLabel.font = UIFont(name: "PingFangSC-Regular", size: 17)
        foodImage.contentMode = .scaleAspectFill
        respectedView.addSubview(foodImage)
        respectedView.addSubview(instructionLabel)
        //set long press trigger event
        let longTapGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(createTag))
        longTapGestureRecognizer.numberOfTapsRequired = 0
        longTapGestureRecognizer.numberOfTouchesRequired = 1
        longTapGestureRecognizer.minimumPressDuration = 0.5
        longTapGestureRecognizer.delegate = self
        respectedView.addGestureRecognizer(longTapGestureRecognizer)
    }
    
    @objc func createTag(gestureReconizer:UILongPressGestureRecognizer){
        if (gestureReconizer.state != .ended){
            return
        }
        var point = gestureReconizer.location(in: foodImage)
        point.x -= 45
        point.y -= 37
        let foodTag = AADraggableView(frame: CGRect(origin: point, size: tagSize))
        foodTag.backgroundColor = .clear
        let foodLabel = UILabel(frame: CGRect(x: 0, y: 40, width: 90, height: 35))
        foodLabel.text = "这是什么?" // initial text label
        foodLabel.textColor = .white
        foodLabel.textAlignment = .center
        foodLabel.layer.cornerRadius = 10
        foodLabel.backgroundColor = .black
        foodLabel.clipsToBounds = true
        let tagCircleImage = UIImageView(frame: CGRect(origin: CGPoint(x: 20, y: 0), size: tagImageSize))
        tagCircleImage.image = UIImage(named: "tagIcon_gray")
        foodTag.addSubview(tagCircleImage)
        foodTag.addSubview(foodLabel)
        foodTagList.append(foodTag)
        foodLabelList.append(foodLabel)
        foodImage.addSubview(foodTag)
        foodImage.bringSubviewToFront(foodTag)
        foodTag.delegate = self
        foodTag.padding = 5
        foodTag.respectedView = respectedView
        foodTag.reposition = .sticky
        foodTag.isEnabled = true
        foodTag.repositionIfNeeded()
        self.didAddTag() // callback for view controller
    }
    
    
    
}

extension FoodDiaryTagView: AADraggableViewDelegate {
    
    func draggingDidBegan(_ sender: UIView) {
        sender.layer.zPosition = 1
        sender.layer.shadowOffset = CGSize(width: 0, height: 20)
        sender.layer.shadowOpacity = 0.3
        sender.layer.shadowRadius = 6
    }
    
    func draggingDidEnd(_ sender: UIView) {
        sender.layer.zPosition = 0
        sender.layer.shadowOffset = CGSize.zero
        sender.layer.shadowOpacity = 0.0
        sender.layer.shadowRadius = 0
        //collect tagX & tagY
        let tagX = sender.frame.origin.x
        let tagY = sender.frame.origin.y
        print("tagx:\(tagX),tagY:\(tagY)")
    }
}

extension FoodDiaryTagView: UIGestureRecognizerDelegate {
    
}

