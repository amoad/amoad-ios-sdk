//
//  FormViewController.swift
//  AMoAdiOSSdkDemo
//
//  Created by AMoAd on 2016/08/15.
//  Copyright © 2016年 AMoAd. All rights reserved.
//

import UIKit
import Foundation

class FormViewController: UIViewController {
    var nextSegue:String!
    @IBOutlet weak var errorMsg: UILabel!
    @IBOutlet weak var sidField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideErrorMsg()
    }

    @IBAction func onNextBtnClicked(_ sender: AnyObject) {
        if validSid() {
            performSegue(withIdentifier: nextSegue, sender: nil)
        } else {
            showErrorMsg()
        }
    }

    @IBAction func onSidChanged(_ sender: UITextField) {
        hideErrorMsg()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sid = sidField.text!
        if let identifier = segue.identifier {
            if identifier == Segues.display {
                (segue.destination as! DisplayViewController).sid = sid
            } else if identifier == Segues.interstitial {
                (segue.destination as! InterstitialViewController).sid = sid
            } else if identifier == Segues.infeed {
                (segue.destination as! InfeedViewController).sid = sid
            } else if identifier == Segues.nativeHtml {
                (segue.destination as! NativeHtmlViewController).sid = sid
            } else if identifier == Segues.screen {
                (segue.destination as! ScreenViewController).sid = sid
            } else if identifier == Segues.nativeApp {
                (segue.destination as! NativeAppViewController).sid = sid
            } else if identifier == Segues.listViewTableView {
                (segue.destination as! ListViewTVController).sid = sid
            } else if identifier == Segues.listViewCollectionView {
                (segue.destination as! ListViewCVController).sid = sid
            }
        }
    }
    
    func validSid() -> Bool {
        if let sid = sidField.text {
            return Regexp("[a-f0-9]{64}").isMatch(sid)
        }
        return false
    }
    
    func hideErrorMsg(){
        self.errorMsg.isHidden = true
    }
    
    func showErrorMsg(){
        self.errorMsg.isHidden = false
    }
}
