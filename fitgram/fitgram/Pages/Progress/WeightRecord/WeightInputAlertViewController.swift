//
//  WeightInputAlertViewController.swift
//  fitgram
//
//  Created by boyuan lin on 16/1/20.
//  Copyright © 2020 boyuan lin. All rights reserved.
//

import UIKit
import Stevia
import SwiftGRPC


class WeightInputAlertViewController: UIViewController {
    
    public var rootView = weightInputAlertView()
    public var confirmInputEvent:(Float,String) -> Void = {_,_ in }
    var imageKey = ""
    
    override func viewDidLoad() {
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
        let dismissTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onBackgroundViewPressed))
        dismissTapRecognizer.delegate = self
        self.view.addGestureRecognizer(dismissTapRecognizer)
        let imageTapRecognizer =  UITapGestureRecognizer(target: self, action: #selector(showImagePickerSelection))
        imageTapRecognizer.delegate = self
        self.rootView.photoImgView.isUserInteractionEnabled = true
        self.rootView.photoImgView.addGestureRecognizer(imageTapRecognizer)
    }
    
    override func loadView() {
        view = rootView
        rootView.confirmBtn.addTarget(self, action: #selector(onConfirm), for: .touchUpInside)
        rootView.titleLabel.text = "Today"
        rootView.confirmBtn.setTitle("Confirm", for: .normal)
        rootView.photoImgView.image = UIImage(named: "roundCamera_yellow")
        rootView.photoText.text = "Photo Record"
        rootView.weightNameLabel.text = "Your Weight"
        rootView.unitLabel.text = "kg"
    }
    
    @objc func onConfirm(){
        guard let weightValue = Float(rootView.weightValueTextField.text!) else {
            self.confirmInputEvent(0,imageKey)
            self.dismiss(animated: true, completion: nil)
            return
        }
        self.confirmInputEvent(weightValue,imageKey)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onBackgroundViewPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func showImagePickerSelection(){
        let optionMenu = UIAlertController(title: nil, message: "Option", preferredStyle: .actionSheet)
        let cameraOption  = UIAlertAction(title: "Camera", style: .default) { (alertAction) in
            self.openCamera()
            optionMenu.dismiss(animated: true, completion: nil)
        }
        let galleryOption  = UIAlertAction(title: "Album", style: .default) { (alertAction) in
            self.openAlbum()
            optionMenu.dismiss(animated: true, completion: nil)
        }
        let cancelOption  = UIAlertAction(title: "Cancel", style: .cancel) { (alertAction) in
            optionMenu.dismiss(animated: true, completion: nil)
        }
        optionMenu.addAction(cameraOption)
        optionMenu.addAction(galleryOption)
        optionMenu.addAction(cancelOption)
        self.present(optionMenu, animated: true, completion: nil)
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
            let alert = UIAlertController.init(title: "Message", message: "No Camera Dectected", preferredStyle: .alert)
            let cancel = UIAlertAction.init(title: "Confirm", style: .cancel, handler: nil)
            alert.addAction(cancel)
            self.show(alert, sender: nil)
        }
    }
    
    func openAlbum(){
           if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
               let picker = UIImagePickerController()
               picker.sourceType = .photoLibrary
               picker.delegate = self
               picker.allowsEditing = true
               self.present(picker, animated: true, completion: nil)
           } else {
               //TODO show modal native camera not available
               let alert = UIAlertController.init(title: "Message", message: "Cannot open album", preferredStyle: .alert)
               let cancel = UIAlertAction.init(title: "Confirm", style: .cancel, handler: nil)
               alert.addAction(cancel)
               self.show(alert, sender: nil)
           }
       }
}

extension WeightInputAlertViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == self.view || touch.view == self.rootView.photoImgView {
            return true
        }
        return false
    }
}

extension WeightInputAlertViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else {
            return
        }
        let compressedImage = selectedImage.resized(withPercentage: 0.2)!
         DispatchQueue.main.async {
            guard let userId = UserDefaults.standard.string(forKey: Constants.userIdKey) else {
                       return
            }
            picker.dismiss(animated: true, completion: nil)
            let timeStamp = String(Int(Date().timeIntervalSince1970 * 1000))
            let objectKey = "bodyShape_" + userId + "_" + timeStamp
            UploaderManager.shared.asyncPutBodyShapeImage(objectKey: objectKey, image: compressedImage) { (objectKey) in
                self.imageKey = objectKey
                DispatchQueue.main.async {
                    self.rootView.photoImgView.layer.cornerRadius = self.rootView.photoImgView.frame.width/2
                    self.rootView.photoImgView.clipsToBounds = true
                    self.rootView.photoImgView.image = selectedImage
                }
            }
        }
        
    }
}

extension UIImage {
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}

class weightInputAlertView: UIView {
    
    let containerView = UIView()
    
    let titleLabel = UILabel()
    let confirmBtn = UIButton()
    
    let photoImgView = UIImageView()
    let photoText = UILabel()
    
    let weightNameLabel = UILabel()
    let unitLabel = UILabel()
    let weightValueTextField = UITextField()
    let underlineView = UIView()
    let weightValueContainer = UIView()
    
    convenience init(){
        self.init(frame: .zero)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        containerView.backgroundColor = .white
        containerView.alpha = 1
        sv(
            containerView.sv(
                titleLabel,
                confirmBtn,
                photoImgView,
                photoText,
                weightNameLabel,
                weightValueContainer.sv(
                    weightValueTextField,
                    underlineView
                ),
                unitLabel
            )
        )
        layout(
            |-0-containerView.width(UIScreen.main.bounds.width)-0-|,
            320
        )
        layout(
            30,
            |-titleLabel-confirmBtn-16-| ~ 30,
            10,
            |-photoImgView.width(45)-| ~ 45,
            1,
            |-photoText-| ~ 20,
            40,
            |-weightNameLabel-| ~ 30,
            10,
            |-120-weightValueContainer-1-unitLabel-120-| ~ 70,
            40
        )
        layout(
            |-0-weightValueTextField-0-|,
            |-0-underlineView-0-| ~ 1
        )
        containerView.centerHorizontally()
        titleLabel.font = UIFont(name: "PingFangSC-Regular", size: 16)
        titleLabel.width(55)
        titleLabel.centerHorizontally()
        confirmBtn.titleLabel!.font = UIFont(name: "PingFangSC-Regular", size: 18)
        confirmBtn.contentHorizontalAlignment = .right
        confirmBtn.setTitleColor(UIColor(red: 238/255, green: 194/255, blue: 0, alpha: 1), for: .normal)
        photoText.font = UIFont(name: "PingFangSC-Regular", size: 13)
        photoText.width(UIScreen.main.bounds.width)
        photoText.textAlignment = .center
        photoImgView.centerHorizontally()
        photoImgView.contentMode = .scaleAspectFill
        photoImgView.width(45)
        photoImgView.height(45)
        weightNameLabel.font = UIFont(name: "PingFangSC-Medium", size: 20)
        weightNameLabel.centerHorizontally()
        weightNameLabel.width(100)
        weightValueTextField.font = UIFont(name: "PingFangSC-Regular", size: 40)
        weightValueTextField.textColor = UIColor(red: 238/255, green: 194/255, blue: 0, alpha: 1)
        weightValueTextField.textAlignment = .center
//        weightValueContainer.width(120)
//        weightValueContainer.centerHorizontally()
        weightValueTextField.keyboardType = .decimalPad
        unitLabel.width(20)
        unitLabel.font = UIFont(name: "PingFangSC-Regular", size: 14)
        underlineView.backgroundColor = .lightGray
    }
    
}
