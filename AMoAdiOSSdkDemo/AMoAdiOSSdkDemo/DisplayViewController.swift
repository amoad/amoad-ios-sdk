//
//  DisplayViewController.swift
//  AMoAdiOSSdkDemo
//
//  Created by AMoAd on 2016/08/15.
//  Copyright © 2016年 AMoAd. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController, AMoAdViewDelegate {
    var sid:String!
    var adView:AMoAdView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initAd()
    }
    
    func initAd() {       
        adView = AMoAdView()
        adView.delegate = self
        adView.horizontalAlign = .center
        adView.verticalAlign = .bottom
        adView.rotateTransition = .flipFromLeft
        adView.clickTransition = .jump
        adView.adjustMode = .responsive
        adView.sid = sid
        self.view.addSubview(adView)
    }
    
    func showAd() {
        adView.show()
    }
    
    func hideAd() {
        adView.hide()
    }
    
    @IBAction func onHideBtnClicked(_ sender: AnyObject) {
        hideAd()
    }
    @IBAction func onShowBtnClicked(_ sender: AnyObject) {
        showAd()
    }

    func aMoAdViewDidReceiveAd(_ amoadView: AMoAdView!) {
        // 正常に広告を受信した
        print("AMoAdViewDidReceiveAd()")
    }
    
    func aMoAdViewDidFail(toReceiveAd amoadView: AMoAdView!, error: Error!) {
        // 広告の取得に失敗した
        print("AMoAdViewDidFailToReceiveAd()")
    }
    
    func aMoAdViewDidReceiveEmptyAd(_ amoadView: AMoAdView!) {
        // 空の広告を受信した
        print("AMoAdViewDidReceiveEmptyAd()")
    }
}
