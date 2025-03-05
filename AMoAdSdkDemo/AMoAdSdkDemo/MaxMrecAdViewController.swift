//
//  MaxMrecAdViewController.swift
//  AMoAdSdkDemo
//
//  Created by 中村 正義 on 2025/02/27.
//  Copyright © 2025 CAWise. All rights reserved.
//

import AppLovinSDK
import SnapKit
import UIKit

class MaxMrecAdViewController: UIViewController {

  var adUnitId = ""
  var adSize = CGSize(width: 300, height: 250)

  var logView: UITextView!

  var scrollView: UIScrollView!
  private var searchField: UISearchBar!
  private var adView: MAAdView!

  override func viewDidLoad() {
    super.viewDidLoad()

    self.scrollView = UIScrollView(
      frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height / 2)
    )
    self.view.addSubview(self.scrollView)
    self.scrollView.snp.makeConstraints { make in
      make.top.left.right.equalToSuperview()
      make.height.equalTo(self.view.frame.height / 2)
    }
    self.scrollView.contentSize = CGSize(
      width: max(self.scrollView.frame.width, adSize.width),
      height: self.scrollView.frame.height
    )

    self.searchField = UISearchBar()
    self.searchField.delegate = self
    self.searchField.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 80)
    self.searchField.text = self.adUnitId
    self.searchField.prompt = "adUnitId入力フォーム"
    self.searchField.placeholder = "描画する広告枠のsidを入力してください。"
    self.scrollView.addSubview(self.searchField)

    self.adView = MAAdView(adUnitIdentifier: self.adUnitId, adFormat: .mrec)
    self.adView.delegate = self
    self.adView.loadAd()

    self.scrollView.addSubview(self.adView)

    self.adView.snp.makeConstraints { make in
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
}

// MARK: - MAAdViewAdDelegate
extension MaxMrecAdViewController: MAAdViewAdDelegate {
  func didLoad(_ ad: MAAd) {
    self.logView.text += "広告をロードしました\n"
  }

  func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {
    self.logView.text += "広告のロードに失敗しました(error:\(error))\n"
  }

  func didClick(_ ad: MAAd) {
    self.logView.text += "広告をクリックしました\n"
  }

  func didFail(toDisplay ad: MAAd, withError error: MAError) {
    self.logView.text += "広告の表示に失敗しました(error:\(error))\n"
  }

  // MARK: - MAAdViewAdDelegate Protocol
  func didExpand(_ ad: MAAd) {
    self.logView.text += "広告を拡大しました\n"
  }

  func didCollapse(_ ad: MAAd) {
    self.logView.text += "広告を破棄しました\n"
  }

  // MARK: - Deprecated Callbacks
  func didDisplay(_: MAAd) {}
  func didHide(_: MAAd) {}
}

extension MaxMrecAdViewController: UISearchBarDelegate {
  //サーチバーで決定ボタンを押した時の動作（決定ボタンで検索したい時はこっちを使用　今回未使用）
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    self.adUnitId = self.searchField.text ?? ""
    self.view.endEditing(true)

    self.adView = MAAdView(adUnitIdentifier: self.adUnitId, adFormat: .mrec)
    self.adView.delegate = self
    self.adView.loadAd()
  }
}

