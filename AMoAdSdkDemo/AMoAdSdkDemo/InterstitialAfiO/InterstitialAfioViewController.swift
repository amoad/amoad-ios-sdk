//
//  InterstitialAfioViewController.swift
//  AMoAdSdkDemo
//
//  Created by AMoAd on 19/01/2018.
//  Copyright © 2018 CA Wise, Inc. All rights reserved.
//

import UIKit

class InterstitialAfioViewController: UIViewController, AMoAdInterstitialVideoDelegate {
    
    let sid = "管理画面から発行されるSIDを設定してください"
    let tag = "任意のタグ名を指定してください"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AMoAdInterstitialVideo.sharedInstance(withSid: sid, tag: tag).delegate = self
    }
    
    func amoadInterstitialVideo(_ amoadInterstitialVideo: AMoAdInterstitialVideo!, didLoadAd result: AMoAdResult) {
        // 広告ダウンロードが完了したら View を表示する
        if (result == .success) {
            amoadInterstitialVideo.show()
        }
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        // 広告ダウンロード
        AMoAdInterstitialVideo.sharedInstance(withSid: sid, tag: tag).load()
    }
}
