//
//  WebViewController.swift
//  Project16
//
//  Created by Alanna Romao on 11/11/20.
//

import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController {
    var webView: WKWebView!
    var capital: String?
    
    var tap: UITapGestureRecognizer?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard var capital = self.capital else {
            return
        }
        if capital == "Washington DC" {
           capital = "Washington,_D.C."
        }
        let html = "https://en.wikipedia.org/wiki/" + capital
        guard let url = URL(string: html) else { return }
        let urlr = URLRequest(url: url)
        webView.load(urlr)
    }
}
