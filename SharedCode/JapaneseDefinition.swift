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
      
      // Not sure if I'll keep this, it might be too confusing
      // This formats the entry so that it looks like this "1. Some definition; another definition"
      // I use the reduce function here because the entry from above is an array of sub definitions, and I want them
      // reduced to a single string
      formattedString += "\n\(index + 1). \(entry.reduce("", { "\($0);" }))\n"
      
    }
    
    return formattedString
  }
  
  
  
  
}
