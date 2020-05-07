//
//  InterstitilaAdViewController.swift
//  AMoAdSdkDemo
//
//  Copyright © 2019 CA Wise, Inc.All rights reserved.
//

import UIKit
import AMoAd

class InterstitilaAdViewController: UIViewController {
  
  var sid: String = ""
  @IBOutlet var logView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    AMoAdInterstitial.registerAd(sid: self.sid)
    
    self.logView.isEditable = false
    self.logView.layer.borderColor = UIColor.blue.cgColor
    self.logView.layer.borderWidth = 1.0
    self.logView.layer.cornerRadius = 10.0
    self.logView.layer.masksToBounds = true
    self.logView.backgroundColor = UIColor(red: 0.90, green: 0.92, blue: 1.0, alpha: 1.0)
  }
  
  @IBAction func onTapLoad() {
    AMoAdInterstitial.loadAd(sid: self.sid) { (_, result, error) in
      switch result {
      case .success:
        self.logView.text += "広告を受信しました\n"
      case .failure:
        self.logView.text += "広告受信に失敗しました(error: \(error.debugDescription))\n"
      case .empty:
        self.logView.text += "空広告を受信しました\n"
      @unknown default:
        break
      }
    }
  }
  
  @IBAction func onTapShow() {
    guard AMoAdInterstitial.isLoadedAd(sid: self.sid) else {
      self.logView.text += "広告受信前に表示ボタンが押されました\n"
      return
    }
    
    AMoAdInterstitial.showAd(sid: self.sid) { (_, result, error) in
      switch result {
      case .click:
        self.logView.text += "広告をクリックしました\n"
      case .close:
        self.logView.text += "広告を閉じました\n"
      case .duplicated:
        self.logView.text += "二重に広告を表示することはできません\n"
      case .closeFromApp:
        self.logView.text += "アプリから広告を閉じました\n"
      case .failure:
        self.logView.text += "表示に失敗しました(error:\(error.debugDescription))\n"
      @unknown default:
        break
      }
    }
  }
  
}
