//
//  InterstitialAfiOViewController.swift
//  AMoAdSdkDemo
//
//  Copyright © 2019 CA Wise, Inc.All rights reserved.
//

import UIKit
import AMoAd
import SnapKit

class InterstitialAfiOViewController: UIViewController {
  
  var sid = ""
  let tag = "tag"
  @IBOutlet var logView: UITextView!
  
  var afioInterstitial: AMoAdInterstitialVideo?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.afioInterstitial = AMoAdInterstitialVideo.shared(sid: self.sid, tag: self.tag)
    self.afioInterstitial!.delegate = self
    
    self.logView.isEditable = false
    self.logView.layer.borderColor = UIColor.blue.cgColor
    self.logView.layer.borderWidth = 1.0
    self.logView.layer.cornerRadius = 10.0
    self.logView.layer.masksToBounds = true
    self.logView.backgroundColor = UIColor(red: 0.90, green: 0.92, blue: 1.0, alpha: 1.0)
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
  @IBAction func onTapLoad() {
    self.afioInterstitial?.load()
  }
  
  @IBAction func onTapShow() {
    guard self.afioInterstitial?.isLoaded ?? false else {
      self.logView.text += "広告受信前に表示ボタンが押されました\n"
      return
    }
    self.afioInterstitial?.show()
  }
}

extension InterstitialAfiOViewController: AMoAdInterstitialVideoDelegate {
  func amoadInterstitialVideoDidLoadAd(amoadInterstitialVideo: AMoAdInterstitialVideo, result: AMoAdResult) {
    self.logView.text += "広告の取得が完了しました(\(result.description))\n"
  }
  
  func amoadInterstitialVideoDidStart(amoadInterstitialVideo: AMoAdInterstitialVideo) {
    self.logView.text += "動画の再生を開始しました\n"
  }
  
  func amoadInterstitialVideoDidComplete(amoadInterstitialVideo: AMoAdInterstitialVideo) {
    self.logView.text += "動画の再生が完了しました\n"
  }
  
  func amoadInterstitialVideoDidFailToPlay(amoadInterstitialVideo: AMoAdInterstitialVideo) {
    self.logView.text += "動画の再生に失敗しました\n"
  }
  
  func amoadInterstitialVideoDidShow(amoadInterstitialVideo: AMoAdInterstitialVideo) {
    self.logView.text += "広告を表示しました\n"
  }
  
  func amoadInterstitialVideoWillDismiss(amoadInterstitialVideo: AMoAdInterstitialVideo) {
    self.logView.text += "広告を閉じました\n"
  }
  
  func amoadInterstitialVideoDidClickAd(amoadInterstitialVideo: AMoAdInterstitialVideo) {
    self.logView.text += "広告をクリックしました\n"
  }
}
