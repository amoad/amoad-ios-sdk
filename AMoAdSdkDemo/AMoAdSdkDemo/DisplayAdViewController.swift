//
//  DisplayAdViewController.swift
//  AMoAdSdkDemo
//
//  Copyright © 2019 CA Wise, Inc.All rights reserved.
//

import UIKit
import AMoAd
import SnapKit

class DisplayAdViewController: UIViewController {
  
  var sid: String = ""
  var adSize: CGSize = .zero
  
  var logView: UITextView!
  
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
    self.scrollView.contentSize = CGSize(width: max(self.scrollView.frame.width, adSize.width), height: self.scrollView.frame.height)
    
    let adView = AMoAdView(frame: .zero)
    
    adView.sid = self.sid
    adView.delegate = self
    adView.rotateTransition = .curlUp
    
    self.scrollView.addSubview(adView)
    
    adView.snp.makeConstraints { make in
      if (self.scrollView.frame.width > adSize.width) {
        make.centerX.equalToSuperview()
      } else {
        make.left.equalToSuperview()
      }
      make.centerY.equalToSuperview()
      make.size.equalTo(self.adSize)
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
      make.top.equalTo(self.scrollView.snp.bottom).offset(15)
      make.bottom.equalToSuperview().offset(-15)
    }
    
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

extension DisplayAdViewController: AMoAdViewDelegate {
  func amoadViewDidReceiveAd(view amoadView: AMoAdView) {
    self.logView.text += "広告を受信しました\n"
  }
  
  func amoadViewDidReceiveEmptyAd(view amoadView: AMoAdView) {
    self.logView.text += "空広告を受信しました\n"
  }
  
  func amoadViewDidFailToReceiveAd(error: Error) {
    self.logView.text += "広告の受信に失敗しました(error: \(error.localizedDescription))\n"
  }
  
  func amoadViewDidClick(view amoadView: AMoAdView) {
    self.logView.text += "広告をクリックしました\n"
  }
  
  func amoadViewWillClickBack(view amoadView: AMoAdView) {
    self.logView.text += "広告をクリックしアプリに戻ってくる直前です\n"
  }
  
  func amoadViewDidClickBack(view amoadView: AMoAdView) {
    self.logView.text += "広告をクリックしアプリに戻ってきました\n"
  }
}
