//
//  NativeAppViewController.swift
//  AMoAdiOSSdkDemo
//
//  Created by AMoAd on 2016/08/16.
//  Copyright © 2016年 AMoAd. All rights reserved.
//

import UIKit

class NativeAppViewController: UIViewController, AMoAdNativeAppDelegate {
    var sid:String!
    let tag = "ad01"
    override func viewDidLoad() {
        super.viewDidLoad()
        initAd()
    }

    func initAd(){
        let templateView = UINib(nibName: "AdViewCell", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        templateView.frame = CGRect(x: 0, y: 200, width: 320, height: 100)

        AMoAdNativeViewManager.shared().prepareAd(withSid: sid, iconPreloading: true, imagePreloading: true)
        AMoAdNativeViewManager.shared().renderAd(withSid: sid, tag: tag, view: templateView, delegate: self)
        
        self.view.addSubview(templateView)
    }
    
    func updateAd() {
        AMoAdNativeViewManager.shared().updateAd(withSid: sid, tag: tag)
    }
    
    func clearAd() {
        AMoAdNativeViewManager.shared().clearAd(withSid: sid, tag: tag)
    }
    @IBAction func onUpdateBtnClicked(_ sender: AnyObject) {
        updateAd()
    }
    @IBAction func onClearBtnClicked(_ sender: AnyObject) {
        clearAd()
    }
    
    func amoadNativeDidReceive(_ sid: String!, tag: String!, view: UIView!, state: AMoAdResult) {
        print("amoadNativeDidReceive(\(sid), \(tag), \(state))")
    }
    func amoadNativeIconDidReceive(_ sid: String!, tag: String!, view: UIView!, state: AMoAdResult) {
        print("amoadNativeIconDidReceive(\(sid), \(tag), \(state))")
    }
    func amoadNativeImageDidReceive(_ sid: String!, tag: String!, view: UIView!, state: AMoAdResult) {
        print("amoadNativeImageDidReceive(\(sid), \(tag), \(state))")
    }
    func amoadNativeDidClick(_ sid: String!, tag: String!, view: UIView!) {
        print("amoadNativeDidClick(\(sid), \(tag))")
    }
}
