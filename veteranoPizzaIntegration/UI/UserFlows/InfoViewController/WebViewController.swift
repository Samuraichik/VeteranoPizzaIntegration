//
//  wedViewController.swift
//  veteranoPizzaIntegration
//
//  Created by User on 09.02.2022.
//

import Foundation

import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    static let shared = WebViewController()
    
    private var webView: WKWebView!
    public var url1 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: url1)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true

    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
}
