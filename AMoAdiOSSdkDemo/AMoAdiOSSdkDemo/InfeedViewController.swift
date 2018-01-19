//
//  InfeedTableViewController.swift
//  AMoAdiOSSdkDemo
//
//  Created by AMoAd on 2016/08/16.
//  Copyright © 2016年 AMoAd. All rights reserved.
//

import UIKit

class InfeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AMoAdNativeListViewDelegate {
    let tableViewCell = "UserTableViewCell"
    let tag = "ad01"
    var items = [UserItem]()
    var itemNo = 1
    var sid:String!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AMoAdInfeed.setNetworkTimeoutMillis(5000);

        initTableView()
        addItems()
    }
    
    func initTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: tableViewCell, bundle: nil), forCellReuseIdentifier: tableViewCell)
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onRefresh(_:)), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCell, for: indexPath)
        let item = items[(indexPath as NSIndexPath).row]

        let iconView = cell.viewWithTag(10) as! UIImageView
        let label1 = cell.viewWithTag(11) as! UILabel
        let label2 = cell.viewWithTag(12) as! UILabel
        let label3 = cell.viewWithTag(13) as! UILabel
        
        label1.text = item.text1
        label2.text = item.text2
        label3.text = item.text3
        iconView.image = nil
        
        if item.adItem != nil {
            loadImage(item.iconUrl, completion: {(icon) in
                if item.text1 == label1.text! &&
                   item.text2 == label2.text! &&
                   item.text3 == label3.text! &&
                   iconView.image == nil { // リサイクルされていないか確認する
                    iconView.image = icon;
                }
            })
        } else {
            iconView.image = UIImage(named: "item")
        }
        
        AMoAdInfeed.setViewabilityTrackingCell(cell, adItem: item.adItem)
        addItemsIfNeeded(indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(116)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[(indexPath as NSIndexPath).row]
        if let adItem = item.adItem {
            adItem.onClick()
        }
    }

    func onRefresh(_ refreshControl:UIRefreshControl) {
        refreshControl.beginRefreshing()
        itemNo = 1
        items = []
        addItems({refreshControl.endRefreshing()})
        
    }
    
    func addItemsIfNeeded(_ indexPath:IndexPath) {
        if (indexPath as NSIndexPath).row >= items.count - 1 {
            addItems()
        }
    }
    
    func createItems() -> [UserItem] {
        let start = itemNo
        let end = itemNo + 10
        var items = [UserItem]()
        for n in start..<end {
            let item = UserItem(text1:"タイトル[\(n)]", text2:"本文１[\(n)]", text3:"本文２[\(n)]")
            items.append(item)
        }
        itemNo = end
        return items
    }
    
    func mergeAd(_ userItems:[UserItem], adList:AMoAdList) -> [UserItem]{
        var merged = [UserItem]() + userItems
        var adIndex = 0
        for (i, _) in userItems.enumerated() {
            if i == adList.beginIndex || (i > adList.beginIndex && (i - adList.beginIndex) % adList.interval == 0) {
                let userItem = UserItem(item: adList.ads[adIndex])
                adIndex += 1
                merged.insert(userItem, at: i)
            }
            if adIndex >= adList.ads.count {
                break
            }
        }
        
        return merged
    }

    func addItems(){
        addItems(nil)
    }

    func addItems(_ completion:(()->Void)?){
        loadItem({(newItems) in
            if newItems.count > 0 {
                self.items = self.items + newItems
                self.tableView.reloadData()
            }
            if let added = completion {
                added()
            }
        })
    }
    
    func loadItem(_ completion:@escaping (_ userItems:[UserItem]) -> Void){
        //use background thread
        DispatchQueue(label: "com.amoad.queue.UserItems", attributes: []).async(execute: {
            let newUserItems = self.createItems()
            if newUserItems.count > 0 {
                AMoAdInfeed.load(withSid: self.sid, completion: {(adList, adResult) in
                    var mergedItems:[UserItem]!
                    if adResult == .success && !(adList?.ads.isEmpty)!{
                        mergedItems = self.mergeAd(newUserItems, adList: adList!)
                    }else{
                        mergedItems = newUserItems
                    }
                    
                    //use main thread
                    DispatchQueue.main.async(execute: {
                        completion(mergedItems)
                    })
                })
            }
        })
        
    }

    func loadImage(_ url:URL, completion:@escaping (_ image:UIImage?) -> Void){
        //use background thread
        DispatchQueue(label: "com.amoad.queue.Icon", attributes: []).async(execute: {
            let request = URLRequest(url: url)
            let response: AutoreleasingUnsafeMutablePointer<URLResponse?>? = nil
            var img:UIImage?
            do {
                let data = try NSURLConnection.sendSynchronousRequest(request, returning: response)
                img = UIImage(data: data)
            }catch (let e){
                print("error:\(e)")
            }

            //use main thread
            DispatchQueue.main.async(execute: {
                completion(img)
            })
        })
    }
    
    class UserItem {
        var iconUrl:URL!
        var text1:String!
        var text2:String!
        var text3:String!
        var adItem:AMoAdItem?
        
        init(text1:String, text2:String, text3:String){
            self.text1 = text1;
            self.text2 = text2;
            self.text3 = text3;
        }
        convenience init(item:AMoAdItem){
            self.init(text1: item.serviceName, text2: item.titleShort, text3: item.titleLong);
            iconUrl = URL(string: item.iconUrl)
            adItem = item
        }
    }
}
