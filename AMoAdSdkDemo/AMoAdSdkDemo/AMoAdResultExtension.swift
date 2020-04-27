//
//  AMoAdStateExtension.swift
//  AMoAdSdkDemo
//
//  Copyright © 2019 CA Wise, Inc. All rights reserved.
//

import Foundation
import AMoAd

extension AMoAdResult {
  var description: String {
    switch self {
    case .success:
      return "成功"
    case .failure:
      return "失敗"
    case .empty:
      return "空広告"
    @unknown default:
      return "不明"
    }
  }
}
