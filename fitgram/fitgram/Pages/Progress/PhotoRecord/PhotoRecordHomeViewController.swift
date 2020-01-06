
//
//  PhotoRecordHome.swift
//  fitgram
//
//  Created by boyuan lin on 19/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia
import SwiftGRPC

class PhotoRecordHomeViewController: UIViewController {
    public var rootView = PhotoRecordHomeView()
    
    override func viewDidLoad() {
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
    }
    
    override func loadView() {
        rootView = PhotoRecordHomeView()
        self.view = rootView
        rootView.onPhotoTakingBtnPressedEvent = {
            
        }
    }
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        } else {
            //TODO show modal native camera not available
            let alert = UIAlertController.init(title: "提示", message: "没有检测到摄像头", preferredStyle: .alert)
            let cancel = UIAlertAction.init(title: "确定", style: .cancel, handler: nil)
            alert.addAction(cancel)
            self.show(alert, sender: nil)
        }
    }
}

extension PhotoRecordHomeViewController:  UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else {
            return
        }
        self.dismiss(animated: true)
        guard let userId = UserDefaults.standard.string(forKey: Constants.userIdKey) else {
            return
        }
        let timeStamp = String(Int(Date().timeIntervalSince1970 * 1000))
        let objectKey = userId + "_" + timeStamp
        UploaderManager.shared.asyncPutImage(objectKey: objectKey, image: selectedImage) { (objectKey) in
            
        }
    }
    
}


