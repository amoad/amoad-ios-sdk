//
//  AdMobBannerAdController.swift
//  AMoAdSdkDemo
//
//  Created by 中村 正義 on 2025/02/27.
//  Copyright © 2025 CAWise. All rights reserved.
//

import GoogleMobileAds
import SnapKit
import UIKit

class AdMobBannerAdViewController: UIViewController {

  var adUnitId = ""
  var adSize: CGSize = .zero

  var logView: UITextView!

  var scrollView: UIScrollView!
  private var searchField: UISearchBar!
  private var adView: GADBannerView!

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

    self.adView = GADBannerView()
    self.adView.delegate = self
    self.adView.rootViewController = self
    self.adView.adUnitID = adUnitId
    self.adView.load(GADRequest())

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

// MARK: - GADBannerViewDelegate
extension AdMobBannerAdViewController: GADBannerViewDelegate {
  func bannerViewDidReceiveAd(_: GADBannerView) {
    self.logView.text += "広告を受信しました\n"
  }

  func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
    self.logView.text += "広告の受信に失敗しました(error:\(error))\n"
  }

  func bannerViewDidRecordClick(_ bannerView: GADBannerView) {
    self.logView.text += "広告をクリックしました\n"
  }

  func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {}

  func bannerViewWillPresentScreen(_: GADBannerView) {}

  func bannerViewWillDismissScreen(_: GADBannerView) {}

  func bannerViewDidDismissScreen(_: GADBannerView) {}
}

extension AdMobBannerAdViewController: UISearchBarDelegate {
  //サーチバーで決定ボタンを押した時の動作（決定ボタンで検索したい時はこっちを使用　今回未使用）
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    self.adUnitId = self.searchField.text ?? ""
    self.view.endEditing(true)
  }
}

