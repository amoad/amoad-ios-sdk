//
//  ListViewAdViewController.swift
//  AMoAdSdkDemo
//
//  Copyright © 2019 CA Wise, Inc.All rights reserved.
//

import UIKit
import AMoAd

class ListViewAdViewController: UIViewController {
  
  var sid: String = ""
  let tag = "tag"
  @IBOutlet var tableView: UITableView!
  @IBOutlet var logView: UITextView!
  
  var tableDataSource: [AnyObject] = [AnyObject]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    AMoAdNativeViewManager.shared.prepareAd(sid: self.sid, defaultBeginIndex: 2, defaultInterval: 3, iconPreloading: true, imagePreloading: false)
    AMoAdNativeViewManager.shared.register(sid: self.sid,
                                           tag: self.tag,
                                           tableView: self.tableView,
                                           nib: UINib(nibName: "NativeListViewCell", bundle: Bundle.main))
    
    self.logView.isEditable = false
    self.logView.layer.borderColor = UIColor.blue.cgColor
    self.logView.layer.borderWidth = 1.0
    self.logView.layer.cornerRadius = 10.0
    self.logView.layer.masksToBounds = true
    self.logView.backgroundColor = UIColor(red: 0.90, green: 0.92, blue: 1.0, alpha: 1.0)
    
    let contents = (0..<30).reduce([String]()) { (current, _) -> [String] in
      return ["この行はアプリのコンテンツです"] + current
    }
    
    self.tableDataSource = AMoAdNativeViewManager.shared.array(sid: self.sid, tag: self.tag, array: contents as [AnyObject])
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}

extension ListViewAdViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tableDataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell: UITableViewCell!
    if let item = self.tableDataSource[indexPath.row] as? AMoAdNativeViewItem {
      cell = item.tableView(self.tableView, cellForRowAt: indexPath, delegate: self)
    } else {
      cell = tableView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath)
      cell.textLabel!.text = (self.tableDataSource[indexPath.row] as? String) ?? "この行はアプリのコンテンツです"
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if (self.tableDataSource[indexPath.row] is AMoAdNativeViewItem) {
      return 62.0
    } else {
      return 44.0
    }
  }
}

extension ListViewAdViewController: AMoAdNativeListViewDelegate {
  func amoadNativeDidReceive(sid: String, tag: String, view: UIView, indexPath: IndexPath, state: AMoAdResult) {
    self.logView.text += "\(indexPath.row + 1)行目の広告を受信しました(state:\(state.description))\n"
  }
  
  func amoadNativeIconDidReceive(sid: String, tag: String, view: UIView, indexPath: IndexPath, state: AMoAdResult) {
    self.logView.text += "\(indexPath.row + 1)行目のアイコン画像を受信しました(state:\(state.description))\n"
  }
  
  func amoadNativeImageDidReceive(sid: String, tag: String, view: UIView, indexPath: IndexPath, state: AMoAdResult) {
    self.logView.text += "\(indexPath.row + 1)行目のメイン画像を受信しました(state:\(state.description))\n"
  }
  
  func amoadNativeDidClick(sid: String, tag: String, view: UIView, indexPath: IndexPath) {
    self.logView.text += "\(indexPath.row + 1)行目の広告をクリックしました\n"
  }
}
