//
//  texgtSearchViewController.swift
//  fitgram
//
//  Created by boyuan lin on 8/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import SwiftGRPC

enum TextSearchType{
    case ingredient
    case recipe
    case all
}

protocol TextSearchDelegate:AnyObject {
    
    func onReturnTextsSearchResult(item:Apisvr_SearchItem)
    
    func onCancelTextSearchAction()
}

class TextSearchViewController:UIViewController {
    //text search flag
    public var searchType:TextSearchType = .all
    public var isKeepSearchPage:Bool = false
    
    var rootView:TextSearchView! = nil
    var textSearchResult = [Apisvr_SearchItem]()
    var textSearchSuggestedResult = [Apisvr_SuggestedTag]()
    var mealType:Apisvr_MealType = .breakfast
    
    public weak var textSearchDelegate:TextSearchDelegate?
    public var recognitionTaskId = ""
    
    
    override func viewDidLoad() {
        self.title = "搜索"
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "backbutton_black"), style: .plain, target: self, action: #selector(onBackPressed))
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
        if !isKeepSearchPage {
            self.rootView.setSuggestedData(suggestedTags: textSearchSuggestedResult)
            self.rootView.foodRecognitionCollection.reloadData()
        }
        self.rootView.foodRecognitionCollection.delegate = self
        self.rootView.foodRecognitionCollection.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }
    
    override func loadView() {
        rootView = TextSearchView()
        rootView.foodTextSearchTable.delegate = self
        rootView.foodTextSearchTable.dataSource = self
        rootView.textSearchInput.delegate = self
        view = rootView
    }
    
    @objc func onBackPressed(){
        textSearchDelegate?.onCancelTextSearchAction()
        self.navigationController?.popViewController(animated: true)
    }
    
    func initMockUpData(){
        var entity1 = Apisvr_SearchItem()
        entity1.searchItemName = "红豆卷饼"
        entity1.searchItemWeight = 150
        entity1.searchItemUnit = "个"
        entity1.energy = 95
        textSearchResult.append(entity1)
        var entity2 = Apisvr_SearchItem()
        entity2.searchItemName = "红豆小圆子"
        entity2.searchItemWeight = 442
        entity2.searchItemUnit = "碗"
        entity2.energy = 421
        textSearchResult.append(entity2)
    }
    
    
    func performTextSearch(keyword:String){
        var req = Apisvr_SearchReq()
        req.keywords = keyword
        do{
            guard let token = UserDefaults.standard.string(forKey: Constants.tokenKey) else {
                return
            }
            let metaData = try Metadata(["authorization": "Token " + token])
            try FoodDiaryDataManager.shared.client.search(req, metadata: metaData) { (resp, callback) in
                guard let search = resp else {
                    return
                }
                self.textSearchResult =  search.searchItems
                DispatchQueue.main.async {
                    self.rootView.foodTextSearchTable.reloadData()
                }
            }
        }catch{
            print("error")
        }
        self.rootView.foodTextSearchTable.reloadData()
        self.rootView.foodTextLabel.isHidden = true
        self.rootView.foodTextSearchTable.isHidden = false
        self.rootView.foodRecognitionCollection.isHidden = true
    }
    
    
}

extension TextSearchViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textSearchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let textSearchItem =  textSearchResult[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextSearchTableViewCell", for: indexPath) as? TextSearchTableViewCell else {
            return UITableViewCell()
        }
        if !textSearchItem.sampleImageURL.isEmpty {
             cell.foodImage.kf.setImage(with: URL(string: textSearchItem.sampleImageURL))
        } else {
             cell.foodImage.image = UIImage(named: "fitgram_defaultIcon")
        }
        cell.foodNameLabel.text = textSearchItem.searchItemName
        cell.foodDescLabel.text = "1 \(textSearchItem.searchItemUnit)(\(textSearchItem.searchItemWeight)克)"
        cell.calorieUnitLabel.text = "千卡"
        cell.calorieValueLabel.text = String(Int(textSearchItem.energy))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //navi back
        let item = textSearchResult[indexPath.row]
        textSearchDelegate?.onReturnTextsSearchResult(item: item)
        if !isKeepSearchPage{
             self.navigationController?.popViewController(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}

extension TextSearchViewController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performTextSearch(keyword: textField.text!)
        return true
    }
}


extension TextSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return textSearchSuggestedResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextSearchSuggestionCollectionCell", for: indexPath) as? TextSearchSuggestionCollectionCell else {
            return UICollectionViewCell()
        }
        cell.foodTagBtn.setTitle(textSearchSuggestedResult[indexPath.row].foodName, for: .normal)
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let result = textSearchSuggestedResult[indexPath.row]
        var item = Apisvr_SearchItem()
        item.searchItemID = result.foodID
        item.searchItemName = result.foodName
        textSearchDelegate?.onReturnTextsSearchResult(item: item)
        if !isKeepSearchPage{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:textSearchSuggestedResult[indexPath.row].foodName.count * 15 + 20 , height: 40)
    }
    
    
}

