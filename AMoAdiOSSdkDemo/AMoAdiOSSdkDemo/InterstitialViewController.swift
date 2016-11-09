//
//  InterstitialViewController.swift
//  AMoAdiOSSdkDemo
//
//  Created by AMoAd on 2016/08/15.
//  Copyright © 2016年 AMoAd. All rights reserved.
//

import UIKit

class InterstitialViewController: UIViewController {
    var sid:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        initAd()
    }

    func initAd() {
        AMoAdInterstitial.registerAd(withSid: sid)
        AMoAdInterstitial.loadAd(withSid: sid, completion: {(sid, result, error) in
            switch result {
            case .empty:
                // 空の広告を受信した
                break
            case .failure:
                // 広告の取得に失敗した
                break
            case .success:
                // 正常に広告を受信した
                break
            }
        })
    }
    
    func showAd() {
        if AMoAdInterstitial.isLoadedAd(withSid: sid) {
            AMoAdInterstitial.showAd(withSid: sid, completion: {(sid, result, error) in
                switch result {
                case .click:
                    // 広告をクリックしたから広告を閉じる。
                    break
                case .close:
                    // 閉じるボタンをクリックしたから広告を閉じる。
                    break
                case .closeFromApp:
                    // アプリからcloseAdWithSid関数が呼ばれたから広告を閉じる
                    break
                case .duplicated:
                    // 広告を表示関数(showAdWithSid)が連続で呼ばれたから広告を閉じる
                    break
                case .failure:
                    // 広告の取得に失敗したから広告を閉じる
                    break
                }
            })
        }
    }

    @IBAction func onShowBtnClicked(_ sender: AnyObject) {
        showAd()
    }

}

