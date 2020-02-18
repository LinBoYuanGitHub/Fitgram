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
    public var foodTagImageList = [UIImageView]()
    public var foodDeleteBtnList = [UIButton]()
    public var instructionLabel = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.height/2 + UIScreen.main.bounds.width/4, width: UIScreen.main.bounds.width, height: 30))
    private let tagSize = CGSize(width: 90, height: 75)
    private let tagImageSize = CGSize(width: 35, height: 35)
    private let deleteBtnSize = CGSize(width: 20, height: 20)
    private var longTapGestureRecognizer:UILongPressGestureRecognizer!
    private var showDeleteBtnGestureRecognizer:UITapGestureRecognizer!
    
    var didAddTag: (Double,Double) -> Void = {tagX,tagY in }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        self.addSubview(respectedView)
        self.backgroundColor = .white
        instructionLabel.numberOfLines = 2
        instructionLabel.text = "Long press to tag food"
        instructionLabel.textColor = .gray
        instructionLabel.textAlignment = .center
        instructionLabel.font = UIFont(name: "PingFangSC-Regular", size: 17)
        foodImage.contentMode = .scaleAspectFit
        respectedView.addSubview(foodImage)
        respectedView.addSubview(instructionLabel)
        //set long press trigger event
        longTapGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(createTag))
        longTapGestureRecognizer.numberOfTapsRequired = 0
        longTapGestureRecognizer.numberOfTouchesRequired = 1
        longTapGestureRecognizer.minimumPressDuration = 0.2
        longTapGestureRecognizer.allowableMovement = 0
        longTapGestureRecognizer.delegate = self
        respectedView.addGestureRecognizer(longTapGestureRecognizer)
        //set show-hide delete btn recognizer
        showDeleteBtnGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleDeleteBtn))
    }
    
    @objc func createTag(gestureReconizer:UILongPressGestureRecognizer) {
        if (gestureReconizer.state != .began){
            return
        }
        var point = gestureReconizer.location(in: foodImage)
        point.x -= tagSize.width/2
        point.y -= tagSize.height/2
        let foodTag = AADraggableView(frame: CGRect(origin: point, size: tagSize))
        foodTag.backgroundColor = .clear
        let foodLabel = UILabel(frame: CGRect(x: 0, y: 40, width: 90, height: 35))
        foodLabel.text = "food item" // initial text label
        foodLabel.textColor = .white
        foodLabel.textAlignment = .center
        foodLabel.layer.cornerRadius = 10
        foodLabel.backgroundColor = .black
        foodLabel.clipsToBounds = true
        foodLabel.addGestureRecognizer(showDeleteBtnGestureRecognizer)
        
        let tagCircleImage = UIImageView(frame: CGRect(origin: CGPoint(x: tagSize.width/2-tagImageSize.width/2, y: 0), size: tagImageSize))
        tagCircleImage.image = UIImage(named: "tagIcon_gray")
        let tagDeleteBtn = UIButton(frame: CGRect(origin:CGPoint(x: tagSize.width-tagImageSize.width, y: tagImageSize.height/2) , size: deleteBtnSize))
        tagDeleteBtn.setImage(UIImage(named: "tag_deleteBtn"), for: .normal)
        tagDeleteBtn.isHidden = true
        foodTag.addSubview(tagDeleteBtn)
        foodTag.addSubview(tagCircleImage)
        foodTag.addSubview(foodLabel)
        foodTagList.append(foodTag)
        foodLabelList.append(foodLabel)
        foodTagImageList.append(tagCircleImage)
        respectedView.addSubview(foodTag)
        respectedView.bringSubviewToFront(foodTag)
        foodTag.delegate = self
        foodTag.padding = 5
        foodTag.respectedView = foodImage
        foodTag.reposition = .sticky
        foodTag.isEnabled = true
        foodTag.repositionIfNeeded()
        foodTag.isUserInteractionEnabled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.didAddTag(Double(point.x),Double(point.y))
        }
    }
    
    @objc func toggleDeleteBtn(sender:UITapGestureRecognizer) {
        print("show delete btn")
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
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        var flag = true
//        foodTagList.forEach { (tagView) in
//            if (touch.view?.isDescendant(of: tagView))!{
//                flag = false
//            }
//        }
//        return flag
//    }
}

