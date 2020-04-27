//
//  InfeedAfiOViewController.swift
//  AMoAdSdkDemo
//
//  Copyright © 2019 CA Wise, Inc.All rights reserved.
//

import UIKit
import AMoAd
import SnapKit

class InfeedAfiOViewController: UIViewController {
  
  var sid: String = ""
  let tag: String = "tag"
  var logView: UITextView!
  var adViewNibName: String = ""
  
  var scrollView: UIScrollView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height / 2))
    self.view.addSubview(self.scrollView)
    self.scrollView.snp.makeConstraints { make in
      make.top.left.right.equalToSuperview()
      make.height.equalTo(self.view.frame.height / 2)
    }
    self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height * 2)
    
    let nib = UINib(nibName: self.adViewNibName, bundle: Bundle.main)
    guard let adView = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
    
    self.scrollView.addSubview(adView)
    adView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(self.scrollView.frame.height - 50)
      make.width.equalTo(self.view.frame.width - 50)
    }
    
    self.logView = UITextView(frame: .zero)
    self.logView.isEditable = false
    self.logView.layer.borderColor = UIColor.blue.cgColor
    self.logView.layer.borderWidth = 1.0
    self.logView.layer.cornerRadius = 10.0
    self.logView.layer.masksToBounds = true
    self.logView.backgroundColor = UIColor(red: 0.90, green: 0.92, blue: 1.0, alpha: 1.0)
    
    self.view.addSubview(self.logView)
    self.logView.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(15)
      make.right.equalToSuperview().offset(-15)
      make.top.equalTo(self.scrollView.snp.bottom)
      make.bottom.equalToSuperview().offset(-15)
    }
    
    AMoAdNativeViewManager.shared.prepareAd(sid: self.sid)
    AMoAdNativeViewManager.shared.renderAd(sid: self.sid, tag: self.tag, view: adView, delegate: self)
    guard let videoView = adView.viewWithTag(7) as? AMoAdNativeMainVideoView else { return }
    videoView.delegate = self
  }
  
}

extension InfeedAfiOViewController: AMoAdNativeVideoAppDelegate {
  func amoadNativeVideoDidStart(view amoadNativeMainVideoView: UIView) {
    self.logView.text += "動画の再生を開始しました\n"
  }
  
  func amoadNativeVideoDidComplete(view amoadNativeMainVideoView: UIView) {
    self.logView.text += "動画の再生が完了しました\n"
  }
  
  func amoadNativeVideoDidFailToPlay(view amoadNativeMainVideoView: UIView) {
    self.logView.text += "動画の再生に失敗しました\n"
  }
}

extension InfeedAfiOViewController: AMoAdNativeAppDelegate {
  func amoadNativeDidReceive(sid: String, tag: String, view: UIView, state: AMoAdResult) {
    self.logView.text += "広告を受信しました(state:\(state.description))\n"
  }
  
  func amoadNativeIconDidReceive(sid: String, tag: String, view: UIView, state: AMoAdResult) {
    self.logView.text += "アイコン画像を受信しました(state:\(state.description))\n"
  }
  
  func amoadNativeImageDidReceive(sid: String, tag: String, view: UIView, state: AMoAdResult) {
    self.logView.text += "メイン画像を受信しました(state:\(state.description))\n"
  }
  
  func amoadNativeDidClick(sid: String, tag: String, view: UIView) {
    self.logView.text += "広告をクリックしました\n"
  }
}
