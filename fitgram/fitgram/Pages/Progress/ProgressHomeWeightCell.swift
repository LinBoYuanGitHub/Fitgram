//
//  ProgressHomeWeightCell.swift
//  fitgram
//
//  Created by boyuan lin on 12/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class ProgressHomeWeightCell: UITableViewCell {
    public var titleLabel = UILabel()
    public var arrowImage = UIImageView()
    public var recordTimeLabel = UILabel()
    public var weightLabel = UILabel()
    public var unitLabel = UILabel()
    public var weightRecordBtn = UIButton()
    
    public var onWeightRecordBtnPressed: () -> Void = { }
    private let defaultRecordTimeText = "2019年10月28日"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        sv(
           titleLabel,
           arrowImage,
           recordTimeLabel,
           weightLabel,
           unitLabel,
           weightRecordBtn
        )
        layout(
            8,
            |-16-titleLabel-arrowImage-16-|,
            8,
            |-16-recordTimeLabel-16-|,
            8,
            |-weightLabel-unitLabel-|,
            8,
            |-16-weightRecordBtn-16-|,
            20
        )
        titleLabel.font = UIFont(name: Constants.Dimension.RegularFont, size: 14)
        titleLabel.text = "体重"
        arrowImage.image = UIImage(named: "rightArrow_black")
        arrowImage.width(10)
        arrowImage.height(15)
        recordTimeLabel.width(50%)
        recordTimeLabel.textAlignment = .center
        recordTimeLabel.font = UIFont(name: Constants.Dimension.RegularFont, size: 14)
        recordTimeLabel.text = defaultRecordTimeText
        recordTimeLabel.centerHorizontally()
        weightLabel.text = "59.7"
        weightLabel.textAlignment = .right
        weightLabel.font = UIFont(name: "PingFangSC-semibold", size: 48)
        weightLabel.width(30%)
        weightLabel.centerHorizontally()
        unitLabel.text = "公斤"
        unitLabel.textAlignment = .left
        unitLabel.width(20%)
        unitLabel.centerHorizontally(15)
        unitLabel.font = UIFont(name: "PingFangSC-Regular", size: 16)
        align(lastBaselines: [weightLabel,unitLabel])
        weightRecordBtn.setTitle("记录体重", for: .normal)
        weightRecordBtn.width(125)
        weightRecordBtn.centerHorizontally()
        weightRecordBtn.backgroundColor = .black
        weightRecordBtn.layer.cornerRadius = 15
        weightRecordBtn.layer.masksToBounds = true
        weightRecordBtn.addTarget(self, action: #selector(naviToWeightRecordPage), for: .touchUpInside)
    }
    
    @objc func naviToWeightRecordPage(){
        self.onWeightRecordBtnPressed()
    }
    
    
}
