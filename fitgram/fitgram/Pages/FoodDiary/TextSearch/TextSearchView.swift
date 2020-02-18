//
//  TextSearchView.swift
//  fitgram
//
//  Created by boyuan lin on 8/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class TextSearchView: UIView {
    
    public var textSearchInput = LeftViewTextField(frame: CGRect(x: 16, y: 0, width: UIScreen.main.bounds.width - 64 , height: 40))
    public var textSearchViewContainer = UIView(frame: CGRect(x: 16, y: 8, width: UIScreen.main.bounds.width - 32 , height: 40))
    
    public var foodTextSearchTable = UITableView.init(frame: CGRect(x: 16, y: 60, width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.height - 80), style: .plain)
    public var foodTextLabel = UILabel(frame: CGRect(x: 16, y: 58, width: 150 , height: 30))
    public var foodRecognitionCollection = UICollectionView.init(frame: CGRect(x: 16, y: 100, width: UIScreen.main.bounds.width - 32, height: 150),collectionViewLayout: UICollectionViewFlowLayout())
    
    
    convenience init(){
        self.init(frame:.zero)
        self.backgroundColor = .white
        textSearchInput.placeholder =  "Please enter the food name"
        textSearchInput.leftView = UIImageView(image: UIImage(named: "searchIcon_gray"))
        textSearchInput.leftViewMode = .always
        textSearchInput.font = UIFont(name: "PingFangSC-Regular", size: 16)
        textSearchInput.contentVerticalAlignment = .center
        textSearchInput.returnKeyType = .search
        textSearchInput.clearButtonMode = .whileEditing
        textSearchViewContainer.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
        textSearchViewContainer.layer.cornerRadius = 10
        foodTextSearchTable.register(TextSearchTableViewCell.self, forCellReuseIdentifier: "TextSearchTableViewCell")
        foodRecognitionCollection.register(TextSearchSuggestionCollectionCell.self, forCellWithReuseIdentifier: "TextSearchSuggestionCollectionCell")
        foodTextSearchTable.backgroundColor = .clear
        foodTextSearchTable.showsVerticalScrollIndicator = false
        foodTextSearchTable.isHidden = true
        foodTextLabel.text = "Food Recommendation"
        foodTextLabel.textColor = .lightGray
        foodTextLabel.font = UIFont(name: "PingFangSC-Regualr", size: 14)
        //collecton init
        addSubview(foodTextSearchTable)
        addSubview(textSearchViewContainer)
        addSubview(foodTextLabel)
        addSubview(foodRecognitionCollection)
        textSearchViewContainer.addSubview(textSearchInput)
        foodRecognitionCollection.isHidden = true
        foodTextLabel.isHidden = true
        foodRecognitionCollection.backgroundColor = .white
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        foodRecognitionCollection.collectionViewLayout = layout
        foodRecognitionCollection.showsVerticalScrollIndicator = false
        foodRecognitionCollection.showsHorizontalScrollIndicator = false
    }
    
    public func setSuggestedData(suggestedTags:[Apisvr_SuggestedTag]){
        foodRecognitionCollection.isHidden = false
        foodTextLabel.isHidden = false
        foodRecognitionCollection.reloadData()
    }
    

    
}
