//
//  ViewController.swift
//  AMoAdSdkDemo
//
//  Created by AMoAd on 18/01/2018.
//  Copyright © 2018 CA Wise Inc. All rights reserved.
//

import UIKit

fileprivate struct Item {
    public let title: String
    public let storyboardName: String
    
    public init(title: String, storyboardName: String) {
        self.title = title
        self.storyboardName = storyboardName
    }
}

fileprivate struct Const {
    public static let items: [Item] = [
        Item(title: "ディスプレイ広告", storyboardName: "Display"),
        Item(title: "ディスプレイ広告 ( Swift )", storyboardName: "DisplaySwift"),
        Item(title: "インタースティシャル広告", storyboardName: "DisplayInterstitial"),
        Item(title: "WebView 広告", storyboardName: "WebView"),
        Item(title: "WebView 広告 ( Swift )", storyboardName: "SwiftWebView"),
        Item(title: "スクリーン ( プリロール ) 広告", storyboardName: "PreRoll"),
        Item(title: "インフィード AfiO 広告", storyboardName: "NativeAfio"),
        Item(title: "インタースティシャル AfiO 広告", storyboardName: "InterstitialAfio"),
        Item(title: "旧ネイティブ広告", storyboardName: "Native"),
        Item(title: "インフィード広告", storyboardName: "Infeed"),
        Item(title: "NativeHtml 広告", storyboardName: "NativeHtml")
    ]
}

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func pushViewController(withItem item: Item) {
        let vc = UIStoryboard(name: item.storyboardName, bundle: Bundle.main).instantiateInitialViewController()!
        vc.title = item.title
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.pushViewController(withItem: Const.items[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Const.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contentView", for: indexPath)
        (cell.viewWithTag(1) as! UILabel).text = Const.items[indexPath.row].title
        return cell
    }
}
