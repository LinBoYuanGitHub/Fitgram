//
//  CurrentBodyShapeViewController.swift
//  fitgram
//
//  Created by boyuan lin on 19/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class CurrentBodyShapeViewController: UIViewController{
    
    var progressBar = UIProgressView(progressViewStyle: .bar)
    var titleLabel = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.height/5, width: UIScreen.main.bounds.width, height: 30))
    var collectionView = UICollectionView(frame: CGRect(x: 0, y: CGFloat(UIScreen.main.bounds.height/5 + 150), width: UIScreen.main.bounds.width, height: 200),collectionViewLayout: UICollectionViewFlowLayout())
    
    var currentCursorLabel = UILabel(frame: CGRect(x: Double(UIScreen.main.bounds.width/2 - 44), y:  Double(UIScreen.main.bounds.height/5 + 75), width: 88, height: 52))
    var currentCursorCover = UIImageView(frame: CGRect(x: Double(UIScreen.main.bounds.width/2 - 100), y:  Double(UIScreen.main.bounds.height/5 + 60), width: 200, height: 100))
    var coverFrameView = UIView(frame: CGRect(x: Double(UIScreen.main.bounds.width/2 - 130), y: Double(UIScreen.main.bounds.height/5 + 150), width: 260, height: 200))
    var bodyFatLabel = UILabel(frame: CGRect(x: 0, y: CGFloat(UIScreen.main.bounds.height/5 + 400) , width:UIScreen.main.bounds.width, height: 50))
    var confirmBtn = UIButton(frame: CGRect(x: 32, y: CGFloat(UIScreen.main.bounds.height/5 + 500) , width:UIScreen.main.bounds.width - 64, height: 50))
    
    let maleBodyFatRangeArr = ["4-9%","9-14%","14-19%","19-24%","24-29%","29-34%","34-39%","39-44%"]
    let femaleBodyFatRangeArr = ["7-12%","12-17%","17-22%","22-27%","27-32%","32-37%","37-42%","42-47%"]
    let maleBodyFatImageStrings = ["maleBF_tier1","maleBF_tier2","maleBF_tier3","maleBF_tier4","maleBF_tier5","maleBF_tier6","maleBF_tier7","maleBF_tier8"]
    let femaleBodyFatImagesStrings = ["femaleBF_tier1","femaleBF_tier2","femaleBF_tier3","femaleBF_tier4","fe0maleBF_tier5","femaleBF_tier6","femaleBF_tier7","femaleBF_tier8"]
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        self.setUpProgressView()
        self.view.backgroundColor = .white
        self.titleLabel.text = "当前体型"
        self.titleLabel.font  = UIFont(name: "PingFangSC-Medium", size: 20)
        self.titleLabel.textAlignment = .center
        
        currentCursorLabel.textAlignment = .center
        currentCursorLabel.text = "我"
        currentCursorLabel.textColor = .white
        currentCursorLabel.backgroundColor = .clear
        currentCursorCover.contentMode = .scaleAspectFit
        currentCursorCover.image = UIImage(named: "conversation_box_black")
//        currentCursorLabel.layer.cornerRadius = 10
//        currentCursorLabel.layer.masksToBounds = true
        
        confirmBtn.setTitle("下一步", for: .normal)
        confirmBtn.layer.cornerRadius = 10
        confirmBtn.layer.masksToBounds = true
        confirmBtn.backgroundColor = UIColor(red: 252/255, green: 200/255, blue: 45/255, alpha: 1)
        confirmBtn.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        
        bodyFatLabel.font = UIFont(name: "PingFangSC-Regualr", size: 13)
        if ProfileDataManager.shared.profile.gender == .female{
            bodyFatLabel.text = "BODY FAT:" + femaleBodyFatRangeArr[currentIndex]
            ProfileDataManager.shared.profile.bodyType = Int32(1)
        } else {
            bodyFatLabel.text = "BODY FAT:" + maleBodyFatRangeArr[currentIndex]
            ProfileDataManager.shared.profile.bodyType = Int32(9)
        }
        bodyFatLabel.textAlignment = .center
        
        coverFrameView.layer.borderColor = UIColor(red: 33/255, green: 43/255, blue: 54/255, alpha: 1).cgColor
        coverFrameView.layer.borderWidth = 4
        coverFrameView.backgroundColor = .clear
        coverFrameView.isUserInteractionEnabled = false
        
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        collectionView.register(BodyImageCollectionViewCell.self, forCellWithReuseIdentifier: "BodyImageCollectionViewCell")
        collectionView.showsHorizontalScrollIndicator = false
        let layout = RecommendationCollectionFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView.collectionViewLayout = layout
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(currentCursorCover)
        self.view.addSubview(currentCursorLabel)
        self.view.addSubview(bodyFatLabel)
        self.view.addSubview(collectionView)
        self.view.addSubview(coverFrameView)
        self.view.addSubview(confirmBtn)
    }
    
    func setUpProgressView() {
        self.title = "5/7"
        progressBar.frame = CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width, height: 6)
        progressBar.progress = 5/7
        progressBar.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        progressBar.progressTintColor = UIColor(red: 252/255, green: 200/255, blue: 45/255, alpha: 1)
        self.view.addSubview(progressBar)
    }
    
    @objc func nextStep(){
        let targetVC = TargetBodyShapeViewController()
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    
    
}

extension CurrentBodyShapeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if ProfileDataManager.shared.profile.gender == .female{
            return femaleBodyFatRangeArr.count
        } else {
            return maleBodyFatRangeArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BodyImageCollectionViewCell", for: indexPath) as? BodyImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        if ProfileDataManager.shared.profile.gender == .female{
            cell.bodyImageView.image = UIImage(named: femaleBodyFatImagesStrings[indexPath.row])
        } else {
            cell.bodyImageView.image = UIImage(named: maleBodyFatImageStrings[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 260, height: 200) //set the collectionViewCell size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let centerPoint = view.convert(collectionView.center, to: collectionView)
        guard let indexPath = self.collectionView.indexPathForItem(at: centerPoint) else {
            return
        }
        currentIndex = indexPath.row
        if ProfileDataManager.shared.profile.gender == .female{
            bodyFatLabel.text = "BODY FAT:" + femaleBodyFatRangeArr[currentIndex]
            ProfileDataManager.shared.profile.bodyType = Int32(currentIndex + 1)
        } else {
            bodyFatLabel.text = "BODY FAT:" + maleBodyFatRangeArr[currentIndex]
            ProfileDataManager.shared.profile.bodyType = Int32(currentIndex + 9)
        }
    }
    
    
}
