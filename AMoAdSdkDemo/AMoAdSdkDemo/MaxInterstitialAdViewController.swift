//
//  MaxInterstitialAdViewController.swift
//  AMoAdSdkDemo
//
//  Created by 中村 正義 on 2025/02/27.
//  Copyright © 2025 CAWise. All rights reserved.
//

import AppLovinSDK
import SnapKit
import UIKit

class MaxInterstitialAdViewController: UIViewController {
  
  var adUnitId = ""
  @IBOutlet var logView: UITextView!
  
  var interstitialAd: MAInterstitialAd?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    self.interstitialAd = MAInterstitialAd(adUnitIdentifier: self.adUnitId)
    self.interstitialAd?.delegate = self

    self.logView.isEditable = false
    self.logView.layer.borderColor = UIColor.blue.cgColor
    self.logView.layer.borderWidth = 1.0
    self.logView.layer.cornerRadius = 10.0
    self.logView.layer.masksToBounds = true
    self.logView.backgroundColor = UIColor(red: 0.90, green: 0.92, blue: 1.0, alpha: 1.0)
  }
  
  @IBAction func onTapLoad() {
    self.interstitialAd?.load()
  }

  @IBAction func onTapShow() {
    guard self.interstitialAd?.isReady ?? false else {
      self.logView.text += "広告受信前に表示ボタンが押されました\n"
      return
    }
    self.interstitialAd?.show()
  }
}

// MARK: - MAAdDelegate
extension MaxInterstitialAdViewController: MAAdDelegate {
  // MARK: - MAAdDelegate Protocol
  func didLoad(_ ad: MAAd) {
    self.logView.text += "広告のロードが完了しました\n"
  }

  func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {
    self.logView.text += "広告のロードに失敗しました(error:\(error))\n"
  }

  func didDisplay(_ ad: MAAd) {
    self.logView.text += "広告を表示しました\n"
  }

  func didClick(_ ad: MAAd) {
    self.logView.text += "広告をクリックしました\n"
  }

  func didHide(_ ad: MAAd) {
    self.logView.text += "広告を閉じました\n"
  }

  func didFail(toDisplay ad: MAAd, withError error: MAError) {
    self.logView.text += "広告の表示に失敗しました(error:\(error))\n"
  }
}
