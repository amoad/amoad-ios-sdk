//
//  NativeAfioViewController.swift
//  AMoAdSdkDemo
//
//  Created by AMoAd on 19/04/2017.
//  Copyright © 2017 AMoAd. All rights reserved.
//

import UIKit

class NativeAfioViewController: UIViewController, AMoAdNativeAppDelegate, AMoAdNativeVideoAppDelegate {

    @IBOutlet weak var adView: UIView!

    let sid = "管理画面から発行されるSIDを設定してください"
    let tag = "任意のタグ名を指定してください"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 広告 View を xib から生成する
        let view = Bundle.main.loadNibNamed("AfioView", owner: nil, options: nil)?.first as! UIView
        view.translatesAutoresizingMaskIntoConstraints = false
        self.adView.addSubview(view)
        self.adView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(1)-[view]-(1)-|", options:.alignAllCenterX, metrics: nil, views: ["view": view]))
        self.adView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(1)-[view]-(1)-|", options:.alignAllCenterY, metrics: nil, views: ["view": view]))

        // 広告ダウンロードが完了するまで View を非表示にする
        self.adView.isHidden = true

        // 広告準備
        AMoAdNativeViewManager.shared().prepareAd(withSid: sid, iconPreloading: true, imagePreloading: true)
        // 広告取得
        AMoAdNativeViewManager.shared().renderAd(withSid: sid, tag: tag, view: view, delegate: self)
        // AMoAdNativeMainVideoViewを取得
        guard let videoView = self.adView.viewWithTag(7) as? AMoAdNativeMainVideoView else { return }
        videoView.delegate = self
    }

    func amoadNativeImageDidReceive(_ sid: String!, tag: String!, view: UIView!, state: AMoAdResult) {
        // 広告ダウンロードが完了したら View を表示する
        if (state == .success) {
            self.adView.isHidden = false
        }
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        // 広告ダウンロードが完了するまで View を非表示にする
        self.adView.isHidden = true
        // 広告更新
        AMoAdNativeViewManager.shared().updateAd(withSid: sid, tag: tag)
    }
    
    func amoadNativeVideoDidStart(_ amoadNativeMainVideoView: UIView!) {
        NSLog("\(#function) 動画再生開始")
    }
    
    func amoadNativeVideoDidComplete(_ amoadNativeMainVideoView: UIView!) {
        NSLog("\(#function) 動画再生完了")
    }
    
    func amoadNativeVideoDidFailToPlay(_ amoadNativeMainVideoView: UIView!) {
        NSLog("\(#function) 動画再生失敗")
    }
}

