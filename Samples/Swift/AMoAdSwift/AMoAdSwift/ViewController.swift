//
//  ViewController.swift
//  AMoAdSwift
//
//  Created by AMoAd on 2016/07/21.
//  Copyright © 2016年 AMoAd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AMoAdViewDelegate {

  static let kSid = "管理画面から発行されるSIDを設定してください"

  override func viewDidLoad() {
    super.viewDidLoad()

    AMoAdLogger.shared().logging = true
    AMoAdLogger.shared().trace = true

    // 初期表示画像の取得
    let initialImage = UIImage(named:"b320_50@2x.png")

    // 広告オブジェクトの生成
    if let amoadView = AMoAdView(image: initialImage, adjustMode: .responsive) {

      // デリゲートを設定する
      amoadView.delegate = self

      // 横方向を中央寄せ(AMoAdHorizontalAlignCenter)に指定
      amoadView.horizontalAlign = .center

      // 縦方向を下寄せ(AMoAdVerticalAlignBottom) に指定
      amoadView.verticalAlign = .bottom

      // ローテーション時のアニメーションを設定する
      amoadView.rotateTransition = .flipFromLeft

      // クリック時のアニメーションを設定する
      amoadView.clickTransition = .jump

      // 広告ID（sid）を設定する
      amoadView.sid = ViewController.kSid

      self.view.addSubview(amoadView)
    }
  }

  func aMoAdViewDidReceiveAd(_ amoadView: AMoAdView!) {
    print("正常に広告を受信した")
  }

  func aMoAdViewDidFail(toReceiveAd amoadView: AMoAdView!, error: Error!) {
    print("広告の取得に失敗した（error:\(error)）")
  }

  func aMoAdViewDidReceiveEmptyAd(_ amoadView: AMoAdView!) {
    print("空の広告を受信した")
  }

}

