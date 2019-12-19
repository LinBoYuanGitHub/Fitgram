//
//  ProgressHomeMeasureCell.swift
//  fitgram
//
//  Created by boyuan lin on 12/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class ProgressHomeMeasureCell:UITableViewCell {
    public var measurementBtn = UIButton()
    public var arrowImageView = UIImageView()
    public var measurementCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100), collectionViewLayout: UICollectionViewFlowLayout())
    
    public var measurementDataList = [Apisvr_BodyMeasurementLog]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        sv(
            measurementBtn,
            arrowImageView,
            measurementCollectionView
        )
        layout(
            8,
            |-16-measurementBtn-arrowImageView-16-|,
            8,
            |-16-measurementCollectionView-16-| ~ 120,
            8
        )
        measurementBtn.titleLabel?.textAlignment = .left
        measurementBtn.setTitle("围度记录", for: .normal)
        measurementBtn.setTitleColor(.black, for: .normal)
        
        arrowImageView.image = UIImage(named: "rightArrow_black")
        arrowImageView.width(10)
        arrowImageView.height(15)
        
        measurementCollectionView.backgroundColor = .white
        measurementCollectionView.register(ProgressHomeMeasurementLogCell.self, forCellWithReuseIdentifier: "ProgressHomeMeasurementLogCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        measurementCollectionView.collectionViewLayout = layout
        measurementCollectionView.showsHorizontalScrollIndicator = false
        measurementCollectionView.delegate = self
        measurementCollectionView.dataSource = self
    }
    
    
}

extension ProgressHomeMeasureCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return measurementDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgressHomeMeasurementLogCell", for: indexPath) as? ProgressHomeMeasurementLogCell else {
            return UICollectionViewCell()
        }
        cell.titleLabel.text = measurementDataList[indexPath.row].title
        cell.unitLabel.text = measurementDataList[indexPath.row].unit
        cell.valueLabel.text = String(measurementDataList[indexPath.row].value)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    
}
