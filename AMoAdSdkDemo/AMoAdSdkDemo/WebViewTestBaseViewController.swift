// 
//
//  WebViewtestBaseViewController.swift
//  AMoAdSDKTestApp
//
//  Copyright © 2019 CA Wise, Inc. All rights reserved.
//


import UIKit

class WebViewTestBaseViewController: UIViewController {
  
  var sid: String = ""
  var jsType: JsType = .unknown
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  private var jsFileName: String {
    get {
      switch self.jsType {
        case .display:
          return "https://j.amoad.net/js/aa.js"
        case .native:
          return "https://j.amoad.net/js/n.js"
        default:
          return ""
      }
    }
  }
  
  private var adDiv: String {
    get {
      switch self.jsType {
        case .display:
          return "<div class='amoad_frame sid_\(self.sid) container_div color_#0000CC-#444444-#FFFFFF-#0000FF-#009900 sp'></div>"
        case .native:
          return "<div class='amoad_native' data-sid='\(self.sid)' ></div>"
        default:
          return ""
      }
    }
  }
  
  var html: String {
    get {
      return """
      <!DOCTYPE html>
      <html lang='ja'>
      <head>
      <meta charset='UTF-8'/>
      <meta name="viewport" content='width=device-width,initial-scale=1.0,user-scalable=no,shrink-to-fit=no'>
      <title></title>
      <style>
      body {
      margin: 0;
      padding: 0;
      }
      </style>
      </head>
      <body>
      \(self.adDiv)
      <script src='\(self.jsFileName)' type='text/javascript' charset='utf-8'></script>
      </body>
      </html>
      """
    }
  }
  
}
