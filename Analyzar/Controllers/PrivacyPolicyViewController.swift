//
//  PrivacyPolicyViewController.swift
//  Analyzar
//
//  Created by Danijela Vrzan on 2019-10-24.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let policyURL = URL(string:"https://dvrzan.github.io/analyzar/policy.html")
        let policyRequest = URLRequest(url: policyURL!)
        webView.load(policyRequest)
        
    }
    
}
