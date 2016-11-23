//
//  JapaneseDefinition.swift
//  ProjectWaterBottle
//
//  Created by Matt Amerige on 11/11/16.
//  Copyright © 2016 BuildThings. All rights reserved.
//

import Foundation

struct JapaneseDefinition {
  var word: String?
  var reading: String?
  var definitions: [[String]]?
  
  var formatedDefinitions: String  {
    
    guard let definitions = definitions else {
      return ""
    }
    
    var formattedString = ""
    
    for (index, entry) in definitions.enumerated() {
      
      formattedString += "\n\(index + 1). \(entry.joined(separator: "; "))\n"
      
    }
    
    return formattedString.lowercased()
  }
  
  
  
  
}
