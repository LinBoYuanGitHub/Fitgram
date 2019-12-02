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
    
    public var foodTextSearchTable = UITableView.init(frame: CGRect(x: 16, y: 80, width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.height - 80), style: .plain)
//    public var foodRecognitionCollection = UICollectionView.init()
//    public var foodPopularCollection = UICollectionView.init()
    
    convenience init(){
        self.init(frame:.zero)
        self.backgroundColor = .white
        textSearchInput.placeholder =  "请输入食物名称"
        textSearchInput.leftView = UIImageView(image: UIImage(named: "searchIcon_gray"))
        textSearchInput.leftViewMode = .always
        textSearchInput.font = UIFont(name: "PingFangSC-Regular", size: 16)
        textSearchInput.contentVerticalAlignment = .center
        textSearchInput.keyboardType = .asciiCapable
        textSearchInput.returnKeyType = .search
        textSearchInput.clearButtonMode = .whileEditing
        textSearchViewContainer.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
        textSearchViewContainer.layer.cornerRadius = 15
        foodTextSearchTable.register(TextSearchTableViewCell.self, forCellReuseIdentifier: "TextSearchTableViewCell")
        foodTextSearchTable.backgroundColor = .white
        foodTextSearchTable.isHidden = true
        //collecton init
        addSubview(foodTextSearchTable)
        addSubview(textSearchViewContainer)
        textSearchViewContainer.addSubview(textSearchInput)
    }
    
    
    
    
}
