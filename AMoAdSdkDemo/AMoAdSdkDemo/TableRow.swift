//
//  TableRow.swift
//  AMoAdSdkDemo
//
//  Copyright © 2019 CA Wise, Inc.All rights reserved.
//

import Foundation
import ObjectMapper

class TableRow: ImmutableMappable {
  
  var name = ""
  var identifier = ""
  var sid = ""
  var width: CGFloat = .zero
  var height: CGFloat = .zero
  var nibName: String = ""
  var jsType = ""
  
  required init(map: Map) {
    
  }
  
  func mapping(map: Map) {
    self.name <- map["name"]
    self.identifier <- map["identifier"]
    self.sid <- map["sid"]
    self.width <- map["width"]
    self.height <- map["height"]
    self.nibName <- map["nibName"]
    self.jsType <- map["jsType"]
  }
  
  
}
