//
//  JishoAPIClient.swift
//  ProjectWaterBottle
//
//  Created by Matt Amerige on 11/11/16.
//  Copyright © 2016 BuildThings. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

/// Handles all API calls to Jisho.org
class JishoAPIClient {
  
  enum URLRouter {
    static let base = "http://www.jisho.org"
    static let path = "/api/v1/search/words"
  }
  
  class func definitions(forTerm term: String, completion:@escaping ([JapaneseDefinition]?, Error?)->() ) {
    let parameters = [
      "keyword" : term
    ]
    
    let searchURLString = URLRouter.base + URLRouter.path
    
    Alamofire.request(searchURLString, method: .get, parameters: parameters)
      .validate()
      .responseJSON { response in
        
        switch response.result {
        case .success(let value):
          let json = JSON(value)
          let definitions = parse(json: json)
          completion(definitions, nil)
          
        case .failure(let error):
          print(error.localizedDescription)
          completion(nil, error)
        }
    }
    
  }
  
  private class func parse(json: JSON) -> [JapaneseDefinition] {
        
    var items: [JapaneseDefinition] = []
    
    for (_, entry) in json["data"] {
      let word = entry["japanese"][0]["word"].stringValue
      let reading = entry["japanese"][0]["reading"].stringValue
      var definitions: [[String]] = []
      for (_, sense) in entry["senses"] {
        let meanings = sense["english_definitions"].arrayValue.map{$0.stringValue}
        definitions.append(meanings)
      }
      let newItem = JapaneseDefinition(word: word, reading: reading, definitions: definitions)
      items.append(newItem)
    }
    return items
  }
  
  
}
