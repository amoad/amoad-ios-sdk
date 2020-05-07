//
//  PreRollAdViewController.swift
//  AMoAdSdkDemo
//
//  Copyright © 2019 CA Wise, Inc.All rights reserved.
//

import UIKit

class PreRollAdViewController: UIPageViewController {
  
  var sid: String = ""
  var pages = [PageItemViewController]()
  var currentIndex = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.initPages()
    
    guard let first = self.pages.first else { return }
    self.setViewControllers([first], direction: .forward, animated: true, completion: nil)
    self.dataSource = self as UIPageViewControllerDataSource
  }
  
  func initPages() {
    self.pages = (0..<5).reduce([PageItemViewController]()) { (current, index) -> [PageItemViewController] in
      var settings: (sid: String?, pageType: PageItemViewController.PageType)
      if (index == 2) {
        settings = (self.sid, .ad)
      } else {
        settings = (nil, (index < 2) ? .previousAd : .followingAd)
      }
      return current + [PageItemViewController(sid: settings.sid, pageType: settings.pageType)]
    }
  }
}

extension PreRollAdViewController: UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
   guard case 0...self.pages.count-1 = currentIndex - 1 else { return nil }
    
    currentIndex -= 1
    return self.pages[currentIndex]
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard case 0...self.pages.count-1 = currentIndex + 1 else { return nil }
    
    currentIndex += 1
    return self.pages[currentIndex]
  }
}
