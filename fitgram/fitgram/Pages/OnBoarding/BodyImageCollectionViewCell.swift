
//
//  bodyImageCollectionViewCell.swift
//  fitgram
//
//  Created by boyuan lin on 22/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class BodyImageCollectionViewCell: UICollectionViewCell{
    public var bodyImageView = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        bodyImageView.contentMode = .scaleAspectFill
        bodyImageView.frame = CGRect(x: 0, y: 0, width: 258, height: 193)
        addSubview(bodyImageView)
    }
    
    
    
    
}
