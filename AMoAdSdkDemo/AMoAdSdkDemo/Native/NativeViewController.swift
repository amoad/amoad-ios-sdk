//
//  NativeViewController.swift
//  AMoAdSdkDemo
//
//  Created by AMoAd on 18/01/2018.
//  Copyright © 2018 AMoAd. All rights reserved.
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
        Item(title: "アイコン画像＋テキスト", storyboardName: "IconText"),
        Item(title: "アイコン画像＋テキスト ( リンク )", storyboardName: "IconTextLink"),
        Item(title: "メイン画像＋テキスト", storyboardName: "ImageText"),
        Item(title: "メイン画像＋テキスト ( Coder )", storyboardName: "ImageTextCoder"),
        Item(title: "一行テキスト", storyboardName: "SingleText"),
        Item(title: "[ UITableView ] アイコン画像＋テキスト", storyboardName: "TableViewIconText"),
        Item(title: "[ UITableView ] メイン画像＋テキスト", storyboardName: "TableViewImageText"),
        Item(title: "[ UITableView ] 一行テキスト", storyboardName: "TableViewSingleText"),
        Item(title: "[ UICollectionView ] アイコン画像＋テキスト", storyboardName: "CollectionViewIconText"),
        Item(title: "[ UICollectionView ] メイン画像＋テキスト", storyboardName: "CollectionViewImageText"),
        Item(title: "[ UICollectionView ] 一行テキスト", storyboardName: "CollectionViewSingleText")
    ]
}

class NativeViewController: UITableViewController {
    
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
