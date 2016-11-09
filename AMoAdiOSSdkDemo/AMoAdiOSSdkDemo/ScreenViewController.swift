//
//  ScreenViewController.swift
//  AMoAdiOSSdkDemo
//
//  Created by AMoAd on 2016/08/16.
//  Copyright © 2016年 AMoAd. All rights reserved.
//

import UIKit

class ScreenViewController: UIViewController {
    var sid:String!
    let tag = "ad01"
    override func viewDidLoad() {
        super.viewDidLoad()
        initAd()
    }
    
    func initAd() {
        let templateView = UIView.init(frame: fullSizeFrame())
        
        let analytics = AMoAdAnalytics.init(reportId: "report001")
        analytics?.publisherParam = ["key1":"value1", "key2":"value2"]
        
        AMoAdNativePreRoll.prepareAd(withSid: sid)
        AMoAdNativePreRoll.renderAd(withSid: sid, tag: tag, view: templateView, analytics: analytics, completion: {(sid, tag, templateView, result) in
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
        
        self.view.addSubview(templateView)
    }
    
    func fullSizeFrame() -> CGRect {
        let screen = UIScreen.main;
        let screenBounds = screen.bounds
        return CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height)
    }
}
