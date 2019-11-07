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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
        rootView.foodImage.kf.setImage(with: URL(string: "https://i2.chuimg.com/ac6aa49e873d4aaa926e89d42c8a022b_1920w_1920h.jpg?imageView2/2/w/300/interlace/1/q/90"))
        rootView.didAddTag = {
            //navigate page to text search
        }
    }
    
    override func loadView() {
        rootView = FoodDiaryTagView()
        view = rootView
        rootView.foodImage.image = selectedImage
    }
    
}
