//
//  NativeAdViewController.swift
//  AMoAdSdkDemo
//
//  Copyright © 2019 CA Wise, Inc.All rights reserved.
//

import UIKit
import AMoAd
import SnapKit

class NativeAdViewController: UIViewController {
  
  var sid: String = ""
  let tag = "tag"
  var adViewNibName: String = ""
  var logView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    AMoAdNativeViewManager.shared.prepareAd(sid: self.sid, iconPreloading: true, imagePreloading: true)
    
    let nib = UINib(nibName: self.adViewNibName, bundle: Bundle.main)
    guard let adView = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
    
    self.view.addSubview(adView)
    adView.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(50)
      make.right.equalToSuperview().offset(-50)
      let offset = self.navigationController?.navigationBar.frame.height ?? 44
      if #available(iOS 11, *) {
        make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(offset)
      } else {
        make.top.equalToSuperview().offset(offset)
      }
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
      make.top.equalTo(adView.snp.bottom).offset(15)
      make.bottom.equalToSuperview().offset(-15)
    }
    
    AMoAdNativeViewManager.shared.renderAd(sid: self.sid, tag: self.tag, view: adView, delegate: self)
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}

extension NativeAdViewController: AMoAdNativeAppDelegate {
  
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
