//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by seohui on 30/12/2018.
//  Copyright © 2018 seohui. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let url = URL(string: "https://www.bignerdranch.com")!
        let url = URL(string: "https://www.naver.com")!
        webView.load(URLRequest(url: url))
        
        print("WebViewController loaded its view.")

    }
}
