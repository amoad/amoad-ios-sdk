//
//  ViewController.swift
//  AMoAdSwift
//
//  Created by AMoAd on 2016/07/21.
//  Copyright © 2016年 AMoAd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  static let kSid = "管理画面から発行されるSIDを設定してください"

  override func viewDidLoad() {
    super.viewDidLoad()

    AMoAdLogger.sharedLogger().logging = true
    AMoAdLogger.sharedLogger().trace = true

    // 初期表示画像の取得
    let initialImage = UIImage(named:"b320_50@2x.png")

    // 広告オブジェクトの生成
    let amoadView = AMoAdView(image: initialImage, adjustMode: .Responsive)

    // デリゲートを設定する
    amoadView.delegate = self

    // 横方向を中央寄せ(AMoAdHorizontalAlignCenter)に指定
    amoadView.horizontalAlign = .Center

    // 縦方向を下寄せ(AMoAdVerticalAlignBottom) に指定
    amoadView.verticalAlign = .Bottom

    // ローテーション時のアニメーションを設定する
    amoadView.rotateTransition = .FlipFromLeft

    // クリック時のアニメーションを設定する
    amoadView.clickTransition = .Jump

    // 広告ID（sid）を設定する
    amoadView.sid = ViewController.kSid

    self.view.addSubview(amoadView)
  }


  func AMoAdViewDidReceiveAd(amoadView: AMoAdView!) {
    print("正常に広告を受信した")
  }

  func AMoAdViewDidFailToReceiveAd(amoadView: AMoAdView!, error: NSError!) {
    print("広告の取得に失敗した（error:\(error)）")
  }

  func AMoAdViewDidReceiveEmptyAd(amoadView: AMoAdView!) {
    print("空の広告を受信した")
  }

}

