//
//  JapaneseWord.swift
//  ProjectWaterBottle
//
//  Created by Matt Amerige on 10/4/16.
//  Copyright © 2016 BuildThings. All rights reserved.
//

import Foundation
import SwiftyJSON

struct JapaneseWord: Word, Japanese {
  let term: String
  var readings: [String] = []
  var definitions: [String] = []
  
  init(json: JSON) {
    
    self.term = json["data"][0]["japanese"][0]["word"].stringValue
    self.readings.append(json["data"][0]["japanese"][0]["reading"].stringValue)
    self.definitions.append(json["data"][0]["senses"][0]["english_definitions"][0].stringValue)
    
  }
  
  
  
}
