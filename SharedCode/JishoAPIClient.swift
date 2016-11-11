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
  
  class func definitions(forTerm term: String, completion:()->() ) {
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
          parse(json: json)
          
          
        case .failure(let error):
          print(error.localizedDescription)
        }
    }
    
  }
  
  private class func parse(json: JSON) {
    print(json)
  }
  
  
}
