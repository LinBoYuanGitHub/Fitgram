//
//  BaseViewController.swift
//  fitgram
//
//  Created by boyuan lin on 26/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    let loadingView = UIView()
    let loadingIndicatonLength: CGFloat = 40 //indicator length
    let viewHeight: CGFloat = 80
    let viewWidth: CGFloat = 200
    let textLabelWidth: CGFloat = 200
    let textLabelHeight: CGFloat = 20
    
    var alertController: UIAlertController?
    
    func showLoadingDialog(targetController: UIViewController) {
      self.showLoadingDialog(targetController: targetController, loadingText: "加载中...")
    }
    
    func showLoadingDialog(targetController: UIViewController, loadingText:String) {
        alertController = UIAlertController(title: nil, message: "\(loadingText)\n\n", preferredStyle: UIAlertController.Style.alert)
        let spinnerIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        alertController?.view.addSubview(spinnerIndicator)
        targetController.present(alertController!, animated: false, completion: nil)
    }
    
    func modifyLoadingDialogText(loadingText:String) {
        if alertController != nil {
            alertController?.message = "\(loadingText)\n\n"
        }
    }
    
    func hideLoadingDialog() {
        if alertController != nil {
            alertController?.dismiss(animated: false, completion: nil)
        }
    }
    
    func hideLoadingDialog(completion: @escaping() -> Void) {
        if alertController != nil {
            alertController?.dismiss(animated: false, completion: completion)
        }
    }
    
    func showAlertMessage(msg:String){
        let alertView = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
    }
}
