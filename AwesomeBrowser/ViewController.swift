//
//  ViewController.swift
//  AwesomeBrowser
//
//  Created by Valentina Abramova on 28/07/2019.
//  Copyright © 2019 Valentina Abramova. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var urlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlTextField.delegate = self
        webView.navigationDelegate = self
        
        let homePage = "https://www.apple.com"
        let myURL = URL(string: homePage)
        let myRequest = URLRequest(url: myURL!)
        
        urlTextField.text = homePage
        
        webView.load(myRequest)
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func forwardButtonAction(_ sender: UIButton) {
    
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
}

extension ViewController: UITextFieldDelegate, WKNavigationDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let urlString = textField.text!
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        webView.load(request)
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        urlTextField.text = webView.url?.absoluteString
        
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}

