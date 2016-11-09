//
//  ListViewTVController.swift
//  AMoAdiOSSdkDemo
//
//  Created by AMoAd on 2016/08/17.
//  Copyright © 2016年 AMoAd. All rights reserved.
//

import UIKit

class ListViewTVController: UIViewController, UITableViewDataSource, UITableViewDelegate, AMoAdNativeListViewDelegate {
    let userItemCell = "UserTableViewCell"
    let adItemCell = "AdTableViewCell"
    let beginIndex = 2
    let interval = 4
    let tag = "ad01"
    var items:NSArray = []
    var itemNo = 1
    var sid:String!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initAd()
        addItems()
    }

    func initTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: userItemCell, bundle: nil), forCellReuseIdentifier: userItemCell)
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onRefresh(_:)), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func initAd(){       
        AMoAdNativeViewManager.shared().prepareAd(withSid: sid, defaultBegin: beginIndex, defaultInterval: interval, iconPreloading: true)
        AMoAdNativeViewManager.shared().register(tableView, sid: sid, tag: tag, nibName: adItemCell)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        let item = items[(indexPath as NSIndexPath).row]
        if (item as AnyObject).isKind(of: AMoAdNativeViewItem.self) {
            //広告アイテム
            let adItem = item as! AMoAdNativeViewItem
            cell = adItem.tableView(tableView, cellForRowAt: indexPath, delegate: self)
        } else {
            //ユーザーアイテム
            let userItem = items[(indexPath as NSIndexPath).row]
            cell = tableView.dequeueReusableCell(withIdentifier: userItemCell, for: indexPath)
            let image = cell.viewWithTag(10) as? UIImageView
            image?.image = UIImage(named: "item")
            let title = cell.viewWithTag(11) as? UILabel
            title?.text = userItem as? String
            
        }
        addItemsIfNeeded(indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //コンテンツの高さ
        return CGFloat(116)
    }
    
    func updateAd(){
        AMoAdNativeViewManager.shared().updateAd(withSid: sid, tag: tag)
    }
    
    func onRefresh(_ refreshControl:UIRefreshControl) {
        refreshControl.beginRefreshing()
        itemNo = 1
        items = []
        updateAd()
        addItems()
        refreshControl.endRefreshing()
    }
    
    func addItemsIfNeeded(_ indexPath:IndexPath) {
        if (indexPath as NSIndexPath).row >= items.count - 1 {
            addItems()
        }
    }
    
    func createItems() -> [String] {
        let start = itemNo
        let end = itemNo + 10
        var items = [String]()
        for n in start..<end {
            items.append("ユーザデータ\(n)")
        }
        itemNo = end
        return items
    }

    func addItems(){
        let newItems = createItems()
        let mergedItems = items.addingObjects(from: newItems)
        items = AMoAdNativeViewManager.shared().array(withSid: sid, tag: tag, originalArray: mergedItems) as NSArray
        tableView.reloadData()
    }

    func amoadNativeDidReceive(_ sid: String!, tag: String!, view: UIView!, indexPath: IndexPath!, state: AMoAdResult) {
        print("amoadNativeDidReceive(\(sid), \(tag), \(indexPath.row), \(state))")
    }
    func amoadNativeIconDidReceive(_ sid: String!, tag: String!, view: UIView!, indexPath: IndexPath!, state: AMoAdResult) {
        print("amoadNativeIconDidReceive(\(sid), \(tag), \(indexPath.row), \(state))")
    }
    func amoadNativeImageDidReceive(_ sid: String!, tag: String!, view: UIView!, indexPath: IndexPath!, state: AMoAdResult) {
        print("amoadNativeImageDidReceive(\(sid), \(tag), \(indexPath.row), \(state))")
    }
    func amoadNativeDidClick(_ sid: String!, tag: String!, view: UIView!, indexPath: IndexPath!) {
        print("amoadNativeDidClick(\(sid), \(tag), \(indexPath.row))")
    }
}
