//
//  SwiftWebViewController.swift
//  AMoAdSdkDemo
//
//  Created by AMoAd on 2015/12/10.
//  Copyright © 2015年 AMoAd. All rights reserved.
//

import UIKit

class SwiftWebViewController: UIViewController, UIWebViewDelegate {

  @IBOutlet weak var webView: UIWebView!

  static let LOAD_FROM_URL = true // URLからロードする
  static let LOAD_FROM_FILE = false // ファイルからロードする
  static let LOAD_FROM_STRING = false // 文字列からロードする

  override func viewDidLoad() {
    super.viewDidLoad()

    // [Logger] ログ出力設定
    AMoAdLogger.shared().logging = true
    AMoAdLogger.shared().trace = true

    // [SDK] AMoAdWebの利用を開始する（UIWebViewオブジェクトを作る前に呼んでおく）
    AMoAdWeb.prepareAd()

    // UIWebViewのデリゲートを設定する
    self.webView.delegate = self

    if SwiftWebViewController.LOAD_FROM_URL {
      // URLからロードする
      if let requestURL = URL(string: "https://example.com/") {  // TODO: URLを指定する
        let req = URLRequest(url: requestURL)
        self.webView.loadRequest(req)
      }
    } else if SwiftWebViewController.LOAD_FROM_FILE {
      // ファイルからロードする
      if let requestPath = Bundle.main.path(forResource: "index", ofType: "html") { // TODO: index.htmlの場合
        if let requestURL = URL(string: requestPath) {
          let req = URLRequest(url: requestURL)
          self.webView.loadRequest(req)
        }
      }
    } else if SwiftWebViewController.LOAD_FROM_STRING {
      // 文字列からロードする
      self.webView.loadHTMLString("<!DOCTYPE html>" +
        "<html lang='ja'>" +
        "<head>" +
        "<meta charset='utf-8'>" +
        "<meta name='viewport' content='width=device-width,initial-scale=1.0,user-scalable=no'>" +
        "<title>サンプルページ</title>" +
        "</head>" +
        "<body style='margin: 0; padding: 0'>" +
        "<p>↓ここにアドタグを貼ってください</p>" +
        "</body>" +
        "</html>" +
        "", baseURL:nil)  // TODO: HTMLを文字列で指定する
    }
  }

  func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    // [SDK] 広告クリックの時の処理を行う
    if !AMoAdWeb.webView(webView, shouldStartLoadWith: request, navigationType: navigationType) {
      return false;
    }
    return true;
  }
}

