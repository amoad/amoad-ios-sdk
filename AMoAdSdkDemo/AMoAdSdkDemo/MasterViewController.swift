//
//  MasterViewController.swift
//  AMoAdSdkDemo
//
//  Copyright © 2019 CA Wise, Inc.All rights reserved.
//

import UIKit
import ObjectMapper

class MasterViewController: UITableViewController {
    
    var sections = [TableSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loadTableSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Table View
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section].name
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = self.sections[indexPath.section].rows[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = self.sections[indexPath.section].rows[indexPath.row]
        let identifier = row.identifier
        let srotyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        tableView.deselectRow(at: indexPath, animated: true)
        switch identifier {
        case "display":
            let vc = srotyboard.instantiateViewController(withIdentifier: identifier) as!  DisplayAdViewController
            vc.adSize = CGSize(width: row.width, height: row.height)
            vc.sid = row.sid
            vc.navigationItem.title = row.name
            self.navigationController?.pushViewController(vc, animated: true)
        case "interstitial":
            let vc = srotyboard.instantiateViewController(withIdentifier: identifier) as!  InterstitilaAdViewController
            vc.sid = row.sid
            vc.navigationItem.title = row.name
            self.navigationController?.pushViewController(vc, animated: true)
        case "native":
            let vc = srotyboard.instantiateViewController(withIdentifier: identifier) as!  NativeAdViewController
            vc.sid = row.sid
            vc.adViewNibName = row.nibName
            vc.navigationItem.title = row.name
            self.navigationController?.pushViewController(vc, animated: true)
        case "listview":
            let vc = srotyboard.instantiateViewController(withIdentifier: identifier) as!  ListViewAdViewController
            vc.sid = row.sid
            vc.navigationItem.title = row.name
            self.navigationController?.pushViewController(vc, animated: true)
        case "preroll":
            let vc = srotyboard.instantiateViewController(withIdentifier: identifier) as!  PreRollAdViewController
            vc.sid = row.sid
            vc.navigationItem.title = row.name
            self.navigationController?.pushViewController(vc, animated: true)
        case "infeed_afio":
            let vc = srotyboard.instantiateViewController(withIdentifier: identifier) as!  InfeedAfiOViewController
            vc.sid = row.sid
            vc.adViewNibName = row.nibName
            vc.navigationItem.title = row.name
            self.navigationController?.pushViewController(vc, animated: true)
        case "interstitial_afio":
            let vc = srotyboard.instantiateViewController(withIdentifier: identifier) as!  InterstitialAfiOViewController
            vc.sid = row.sid
            vc.navigationItem.title = row.name
            self.navigationController?.pushViewController(vc, animated: true)
        case "max_rewarded":
            let vc = srotyboard.instantiateViewController(withIdentifier: identifier) as!  MaxRewardedAdViewController
            vc.adUnitId = row.sid
            vc.navigationItem.title = row.name
            self.navigationController?.pushViewController(vc, animated: true)
        case "max_interstitial":
            let vc = srotyboard.instantiateViewController(withIdentifier: identifier) as!  MaxInterstitialAdViewController
            vc.adUnitId = row.sid
            vc.navigationItem.title = row.name
            self.navigationController?.pushViewController(vc, animated: true)
        case "max_mrec":
            let vc = srotyboard.instantiateViewController(withIdentifier: identifier) as!  MaxMrecAdViewController
            vc.adUnitId = row.sid
            vc.navigationItem.title = row.name
            self.navigationController?.pushViewController(vc, animated: true)
        case "wkwebview":
            guard let jsType = JsType(rawValue: row.jsType) else { return }
            let vc = srotyboard.instantiateViewController(withIdentifier: identifier) as!  WKWebViewViewController
            vc.sid = row.sid
            vc.jsType = jsType
            vc.navigationItem.title = row.name
            self.navigationController?.pushViewController(vc, animated: true)
        case "admob_rewarded":
            let vc = srotyboard.instantiateViewController(withIdentifier: identifier) as!  AdMobRewardedAdViewController
            vc.adUnitId = row.sid
            vc.navigationItem.title = row.name
            self.navigationController?.pushViewController(vc, animated: true)
        case "admob_mrec":
            let vc = srotyboard.instantiateViewController(withIdentifier: identifier) as!  AdMobBannerAdViewController
            vc.adUnitId = row.sid
            vc.navigationItem.title = row.name
            self.navigationController?.pushViewController(vc, animated: true)
        case "uiwebview":
            guard let jsType = JsType(rawValue: row.jsType) else { return }
            let vc = srotyboard.instantiateViewController(withIdentifier: identifier) as!  UIWebViewViewController
            vc.sid = row.sid
            vc.jsType = jsType
            vc.navigationItem.title = row.name
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            //
            break
        }
    }
    
    // MARK: - Private
    private func loadTableSource() {
        let url = Bundle.main.url(forResource: "MainTableSource", withExtension: "json")!
        let json = try? String(contentsOf: url)
        self.sections = try! Mapper<TableSection>().mapArray(JSONString: json!) as [TableSection]
    }
}

