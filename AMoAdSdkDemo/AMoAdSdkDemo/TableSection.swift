//
//  TableSource.swift
//  AMoAdSdkDemo
//
//  Copyright © 2019 CA Wise, Inc.All rights reserved.
//

import Foundation
import ObjectMapper

class TableSection: ImmutableMappable {

  var name = ""
  var rows = [TableRow]()
  
  required init(map: Map) {
  }
  
  func mapping(map: Map) {
    self.name <- map["name"]
    self.rows <- map["rows"]
  }
}

