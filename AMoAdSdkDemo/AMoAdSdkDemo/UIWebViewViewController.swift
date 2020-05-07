// 
//
//  UIWebViewViewController.swift
//  AMoAdSDKTestApp
//
//  Copyright © 2019 CA Wise, Inc. All rights reserved.
//


import UIKit

class UIWebViewViewController: WebViewTestBaseViewController {
  
  var webView: UIWebView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    self.webView = UIWebView(frame: .zero)
    self.webView.allowsInlineMediaPlayback = true
    self.webView.mediaPlaybackRequiresUserAction = false
    self.view.addSubview(self.webView)
    self.webView.snp.makeConstraints { make in
      make.width.equalTo(300)
      make.height.equalTo(250)
      make.centerX.centerY.equalToSuperview()
    }
    self.webView.scrollView.isScrollEnabled = true
    self.webView.delegate = self
    
    self.webView.loadHTMLString(self.html, baseURL: URL(string: "https://www.amoad.com"))
  }
  
}

extension UIWebViewViewController: UIWebViewDelegate {
  func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
    guard navigationType == .linkClicked else {
      return true
    }
    
    UIApplication.shared.openURL(request.url!)
    return false
  }
}
