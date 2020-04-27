//
//  PageItemViewController.swift
//  AMoAdSdkDemo
//
//  Copyright © 2019 CA Wise, Inc.All rights reserved.
//

import UIKit
import AMoAd
import SnapKit

class PageItemViewController: UIViewController {
  
  enum PageType {
    case previousAd
    case ad
    case followingAd
  }
  
  let pageType: PageType
  let sid: String?
  let tag = "tag"
  
  var logView: UITextView?
  
  init(sid: String?, pageType: PageType) {
    guard !(pageType == .ad && sid == nil)  else {
      fatalError()
    }
    
    self.sid = sid
    self.pageType = pageType
    super.init(nibName: nil, bundle: nil)
    
    self.view.backgroundColor = .white
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @available(*, unavailable)
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    fatalError("init(nibName:bundle:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    switch self.pageType {
    case .previousAd:
      self.addLabel(text: "ここより先のページに広告が表示されます")
    case .ad:
      self.addLogView()
      self.initAd()
    case .followingAd:
      self.addLabel(text: "ここより前のページに広告が表示されます")
    }
  }
  
  private func addLabel(text: String) {
    let label = UILabel(frame: .zero)
    label.text = text
    label.textAlignment = .center
    self.view.addSubview(label)
    label.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.left.equalToSuperview().offset(15)
      make.right.equalToSuperview().offset(-15)
    }
  }
  
  private func addLogView() {
    let logView = UITextView(frame: .zero)
    logView.isEditable = false
    logView.layer.borderColor = UIColor.blue.cgColor
    logView.layer.borderWidth = 1.0
    logView.layer.cornerRadius = 10.0
    logView.layer.masksToBounds = true
    logView.backgroundColor = UIColor(red: 0.90, green: 0.92, blue: 1.0, alpha: 1.0)
    
    self.view.addSubview(logView)
    logView.snp.makeConstraints { make in
      let offset = self.navigationController?.navigationBar.frame.height ?? 44
      if #available(iOS 11, *) {
        make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(offset)
      } else {
        make.top.equalToSuperview().offset(offset)
      }
      make.left.equalToSuperview().offset(15)
      make.right.equalToSuperview().offset(-15)
      make.height.equalTo(80)
    }
    
    self.logView = logView
  }
  
  private func initAd() {
    guard let logView = self.logView else { return }
    guard let sid = self.sid else { return }
    let adContainer = UIView(frame: .zero)
    self.view.addSubview(adContainer)
    adContainer.snp.makeConstraints { make in
      if #available(iOS 11, *) {
        make.left.right.bottom.equalTo(self.view.safeAreaLayoutGuide)
      } else {
        make.left.right.bottom.equalToSuperview()
      }
      make.top.equalTo(logView.snp.bottom)
    }
    
    AMoAdNativePreRoll.prepareAd(sid: sid)
    
    AMoAdNativePreRoll.renderAd(sid: sid,
                                tag: self.tag,
                               view: adContainer,
                          analytics: nil,
                  isFullscreenClickable: false)
    { (_, _, _, result) in
      switch result {
      case .success:
        logView.text += "広告を受信しました\n"
      case .failure:
        logView.text += "広告の受信に失敗しました\n"
      case .empty:
        logView.text += "空広告を受信しました\n"
      @unknown default:
        break
      }
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if (self.pageType == .ad) {
      guard let sid = self.sid else { return }
      AMoAdNativePreRoll.layoutAd(sid: sid, tag: self.tag)
    }
  }
  
}
