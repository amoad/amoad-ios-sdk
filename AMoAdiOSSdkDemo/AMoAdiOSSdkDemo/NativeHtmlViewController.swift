//
//  NativeHtmlViewController.swift
//  AMoAdiOSSdkDemo
//
//  Created by AMoAd on 2016/08/16.
//  Copyright © 2016年 AMoAd. All rights reserved.
//

import UIKit

class NativeHtmlViewController: UIViewController {
    var sid:String!
    let tag = "ad01"
    override func viewDidLoad() {
        super.viewDidLoad()
        initAd()
    }
    
    func initAd() {
        AMoAdNative.load(withSid: sid, tag: tag, frame: CGRect(x: 100, y: 200, width: 140, height: 120), completion: {(sid, tag, result, dic) in
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
        self.view.addSubview(AMoAdNative.view(withSid: sid, tag: tag))
    }

    func showAd() {
        AMoAdNative.show(withSid: sid, tag: tag)
    }
    
    func reloadAd() {
        AMoAdNative.reload(withSid: sid, tag: tag)
    }
    
    func hideAd() {
        AMoAdNative.hide(withSid: sid, tag:tag)
    }
    
    @IBAction func onShowBtnClicked(_ sender: AnyObject) {
        showAd()
    }
    @IBAction func onReloadBtnClicked(_ sender: AnyObject) {
        reloadAd()
    }
    @IBAction func onHideBtnClicked(_ sender: AnyObject) {
        hideAd()
    }
}
