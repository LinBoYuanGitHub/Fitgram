//
//  WebViewViewController.swift
//  fitgram
//
//  Created by boyuan lin on 20/1/20.
//  Copyright © 2020 boyuan lin. All rights reserved.
//

import UIKit
import WebKit

class WebViewController:UIViewController,WKNavigationDelegate{
    var webView: WKWebView!
    var urlString:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.view.addSubview(webView)
        webView.navigationDelegate = self
        configWebView()
    }
    
    func configWebView() {
           if let url = URL(string: urlString) {
               let urlreq = URLRequest(url: url)
               webView.load(urlreq)
               webView.allowsBackForwardNavigationGestures = false
           }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let backNaviBtn = UIBarButtonItem(image: UIImage(named:"backbutton_black"), style: .plain, target: self, action: #selector(onBackPressed))
        self.navigationItem.leftBarButtonItem = backNaviBtn
    }
    
    @objc func onBackPressed(){
        if webView.canGoBack{
            webView.goBack()
        } else{
            self.navigationController?.popViewController(animated: true)
        }
    }
}




