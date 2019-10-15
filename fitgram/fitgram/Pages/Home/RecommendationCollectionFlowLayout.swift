
//
//  RecommendationCollectionFlowLayout.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 26/9/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class RecommendationCollectionFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepare() {
        super.prepare()
        //set the content to the center
//        let insect = ((self.collectionView?.frame.size.width)! - self.itemSize.width)/2
        self.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    //scale the cell
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let original = super.layoutAttributesForElements(in: rect)
//        let attsArray = NSArray.init(array: original!, copyItems: true) as! [UICollectionViewLayoutAttributes]
//        let centerX = (self.collectionView?.frame.size.width)! / 2 + (self.collectionView?.contentOffset.x)!
//        for atts in attsArray {
//            let space = abs(atts.center.x - centerX)
//            let scale = 1 - (space/(self.collectionView?.frame.size.width)!/5)
//            atts.transform = CGAffineTransform(scaleX: scale, y: scale)
//        }
//        return attsArray
//    }
    
    //set collectionView cell position when scrolling stop
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var rect = CGRect()
        rect.origin.y = 0
        rect.origin.x = proposedContentOffset.x
        rect.size = (self.collectionView?.frame.size)!
        
        let original = super.layoutAttributesForElements(in: rect)
        let attsArray = NSArray.init(array: original!, copyItems: true) as! [UICollectionViewLayoutAttributes]
        let centerX = proposedContentOffset.x + self.collectionView!.frame.size.width / 2
        var minSpace = MAXFLOAT
        for atts in attsArray {
            if (CGFloat(abs(minSpace)) > abs(atts.center.x - centerX)) {
                minSpace = Float(atts.center.x - centerX);        //各个不同的cell与显示中心点的距离
            }
        }
        var finalContentOffset = CGPoint()
        finalContentOffset.x = proposedContentOffset.x + CGFloat(minSpace);
        finalContentOffset.y = proposedContentOffset.y
        return finalContentOffset;
    }
    
    
    
    
}
