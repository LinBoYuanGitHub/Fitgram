//
//  RecommendHomeTableCell.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 24/9/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia
import AVKit
import Kingfisher

class RecommendHomeTableCell: UITableViewCell {
    let mealText = UILabel()
    let recommendationCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var recommendationDishes = [RecipeModel]()
    
    //on collection item select listener
    var didSelectAction: (RecipeModel,Int) -> Void = {_,_ in }
    var didMoveAction: (Int) -> Void = {_ in }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        sv(
            mealText,
            recommendationCollectionView
        )
        layout(
            8,
            |-10-mealText| ~ 40,
            8,
            |recommendationCollectionView| ~  UIScreen.main.bounds.width,
            0
        )
        recommendationCollectionView.register(RecommendHomeCollectionCell.self, forCellWithReuseIdentifier: "RecommendHomeCollectionCell")
        let layout = RecommendationCollectionFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width) //set item size to eliminate the offset issue
        layout.scrollDirection = .horizontal
        recommendationCollectionView.collectionViewLayout = layout
        recommendationCollectionView.backgroundColor = .clear
        recommendationCollectionView.showsHorizontalScrollIndicator = false
        recommendationCollectionView.delegate = self
        recommendationCollectionView.dataSource = self
        recommendationCollectionView.decelerationRate = .fast
//        recommendationCollectionView.isPagingEnabled = true
        //meal text
        mealText.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
    }
    
    func setRecommendationList(dishList: [RecipeModel]){
        self.recommendationDishes = dishList
        recommendationCollectionView.reloadData()
    }
    
}

extension RecommendHomeTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendationDishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.recommendationCollectionView.dequeueReusableCell(withReuseIdentifier: "RecommendHomeCollectionCell", for: indexPath) as? RecommendHomeCollectionCell else {
            return UICollectionViewCell()
        }
        cell.videoPlayView.kf.setImage(with: URL(string: recommendationDishes[indexPath.row].videoCoverImageUrl))
        cell.videoTitleLabel.text = recommendationDishes[indexPath.row].recipeTitle
        cell.videoCalorieLabel.text = recommendationDishes[indexPath.row].recipeCalorie
        cell.videoDurationBtn.setTitle("烹饪时间约\(recommendationDishes[indexPath.row].recipeCookingDuration)分钟", for: .normal)
        cell.checkedButton.setTitle("打卡", for: .normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: UIScreen.main.bounds.width-40, height: UIScreen.main.bounds.width-40) //set the collectionViewCell size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipeItem = recommendationDishes[indexPath.row]
        didSelectAction(recipeItem,indexPath.row)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let centerPoint = CGPoint(x: self.recommendationCollectionView.center.x + self.recommendationCollectionView.contentOffset.x, y: self.recommendationCollectionView.center.y + self.recommendationCollectionView.contentOffset.y)
        guard let indexPath = self.recommendationCollectionView.indexPathForItem(at: centerPoint) else {
            return
        }
        didMoveAction(indexPath.row)
    }
    
}
