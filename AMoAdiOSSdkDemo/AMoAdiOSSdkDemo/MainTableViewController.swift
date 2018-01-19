//
//  MainTableViewController.swift
//  AMoAdiOSSdkDemo
//
//  Created by AMoAd on 2016/08/15.
//  Copyright © 2016年 AMoAd. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    var nextSegue:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        //ログを出力するように設定する
        AMoAdLogger.shared().trace = true
        AMoAdLogger.shared().logging = true
    }


    override func tableView(_ table: UITableView, didSelectRowAt indexPath:IndexPath) {
        if let segue = indexPathToNextSegue(indexPath) {
            nextSegue = segue
            performSegue(withIdentifier: Segues.form,sender: nil)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier{
            if identifier == Segues.form {
                (segue.destination as! FormViewController).nextSegue = nextSegue
            }
        }
    }

    fileprivate func indexPathToNextSegue (_ indexPath:IndexPath) -> String? {
        switch (indexPath as NSIndexPath).row {
        case 0:
            return Segues.display
        case 1:
            return Segues.interstitial
        case 2:
            return Segues.infeed
        case 3:
            return Segues.nativeHtml
        case 4:
            return Segues.screen
        case 5:
            return Segues.nativeApp
        case 6:
            return Segues.listViewTableView
        case 7:
            return Segues.listViewCollectionView
        default:
            return nil
        }
    }
}
