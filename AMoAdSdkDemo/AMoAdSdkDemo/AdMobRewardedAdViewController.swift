//
//  AdMobRewardedAdViewController.swift
//  AMoAdSdkDemo
//
//  Created by 中村 正義 on 2025/02/27.
//  Copyright © 2025 CAWise. All rights reserved.
//

import GoogleMobileAds
import UIKit

class AdMobRewardedAdViewController: UIViewController {

  var adUnitId = ""
  @IBOutlet var logView: UITextView!

  var isRewardedInterstitial = false
  var rewardedAd: GADRewardedAd?
  var rewardedInterstitialAd: GADRewardedInterstitialAd?

  override func viewDidLoad() {
    super.viewDidLoad()

    self.logView.isEditable = false
    self.logView.layer.borderColor = UIColor.blue.cgColor
    self.logView.layer.borderWidth = 1.0
    self.logView.layer.cornerRadius = 10.0
    self.logView.layer.masksToBounds = true
    self.logView.backgroundColor = UIColor(red: 0.90, green: 0.92, blue: 1.0, alpha: 1.0)
  }

  @IBAction func onTapLoad() {
    self.loadRewardedAd()
  }

  @IBAction func onTapShow() {
    self.show()
  }

  private func loadRewardedAd() {
    let request = GADRequest()
    if isRewardedInterstitial {
      GADRewardedInterstitialAd.load(
        withAdUnitID: self.adUnitId,
        request: request
      ) { [self] ad, error in
        if let error = error {
          self.logView.text += "広告のロードに失敗しました(error:\(error.localizedDescription))\n"
          return
        }
        self.rewardedInterstitialAd = ad
        self.logView.text += "広告のロードが完了しました\n"
        self.rewardedInterstitialAd?.fullScreenContentDelegate = self
      }
    } else {
      GADRewardedAd.load(
        withAdUnitID: self.adUnitId,
        request: request
      ) { [self] ad, error in
        if let error = error {
          self.logView.text += "広告のロードに失敗しました(error:\(error.localizedDescription))\n"
          return
        }
        self.rewardedAd = ad
        self.logView.text += "広告のロードが完了しました\n"
        self.rewardedAd?.fullScreenContentDelegate = self
      }
    }
  }

  private func show() {
    if let ad = self.rewardedInterstitialAd {
      ad.present(fromRootViewController: self) {
        let reward = ad.adReward
        self.logView.text += "報酬を取得しました currency:\(reward.amount), amount:\(reward.amount.doubleValue)\n"
      }
    } else if let ad = self.rewardedAd {
      ad.present(fromRootViewController: self) {
        let reward = ad.adReward
        self.logView.text += "報酬を取得しました currency:\(reward.amount), amount:\(reward.amount.doubleValue)\n"
      }
    } else {
      self.logView.text += "広告準備が完了していません\n"
    }
  }
}

// MARK: - GADFullScreenContentDelegate
extension AdMobRewardedAdViewController: GADFullScreenContentDelegate {
  func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
    self.logView.text += "広告の表示に失敗しました(error:\(error.localizedDescription))\n"
  }

  func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
    self.logView.text += "広告を表示しました\n"
  }

  func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
    self.logView.text += "広告を閉じました\n"
  }
}
