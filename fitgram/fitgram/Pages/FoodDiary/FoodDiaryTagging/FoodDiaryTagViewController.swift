//
//  FoodDiaryTagViewController.swift
//  fitgram
//
//  Created by boyuan lin on 31/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia
import Kingfisher
import AADraggableView

class FoodDiaryTagViewController:UIViewController {
    var rootView:FoodDiaryTagView! = nil
    var selectedImage = UIImage()
    var foodTagList = [Apisvr_FoodTag]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "backbutton_black"), style: .plain, target: self, action: #selector(onBackPressed))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一步", style: .plain, target: self, action:  #selector(naviToFoodDetailPage))
        rootView.didAddTag = {
            //navigate page to text search
            let targetVC = TextSearchViewController()
            targetVC.textSearchDelegate = self
            self.navigationController?.pushViewController(targetVC, animated: true)
        }
    }
    
    @objc func onBackPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func naviToFoodDetailPage(){
        let targetVC = FoodDiaryDetailViewController()
        targetVC.foodImage = selectedImage
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    override func loadView() {
        rootView = FoodDiaryTagView()
        view = rootView
        rootView.foodImage.image = selectedImage
    }
    
}

extension FoodDiaryTagViewController: TextSearchDelegate {
    
    func onReturnTextsSearchResult(item: Apisvr_SearchItem) {
        let targetView = self.rootView.foodLabelList.last
        targetView?.text = item.searchItemName
    }
    
    func onCancelTextSearchAction() {
        let removedView = self.rootView.foodTagList.removeLast()
        removedView.removeFromSuperview()
    }
    
    
}
