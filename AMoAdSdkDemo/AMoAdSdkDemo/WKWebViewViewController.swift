// 
//
//  WKWebViewViewController.swift
//  AMoAdSDKTestApp
//
//  Copyright © 2019 CA Wise, Inc. All rights reserved.
//


import UIKit
import WebKit
import SnapKit

class WKWebViewViewController: WebViewTestBaseViewController {
  
  var webView: WKWebView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    let config = WKWebViewConfiguration()
    // videoタグの自動再生設定(タグ側にもmuted autoplay playsinline(iOS10以下ではwebkit-playsinline)が必要
    config.allowsInlineMediaPlayback = true
    if #available(iOS 10.0, *) {
      config.mediaTypesRequiringUserActionForPlayback = []
    } else {
      config.requiresUserActionForMediaPlayback = false
    }

    self.webView = WKWebView(frame: .zero, configuration: config)
    self.view.addSubview(self.webView)
    self.webView.snp.makeConstraints { make in
      make.width.equalTo(300)
      make.height.equalTo(250)
      make.centerX.centerY.equalToSuperview()
    }
    self.webView.scrollView.isScrollEnabled = true
    self.webView.navigationDelegate = self
    
    self.webView.loadHTMLString(self.html, baseURL: URL(string: "https://www.amoad.com"))
  }
}

extension WKWebViewViewController: WKNavigationDelegate {
  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    guard navigationAction.navigationType == .linkActivated else {
      decisionHandler(.allow)
      return
    }
    
    UIApplication.shared.openURL(navigationAction.request.url!)
    decisionHandler(.cancel)
  }
  
}
