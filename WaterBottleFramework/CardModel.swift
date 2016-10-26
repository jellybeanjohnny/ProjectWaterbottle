//
//  CardModel.swift
//  ProjectWaterBottle
//
//  Created by Matt Amerige on 10/1/16.
//  Copyright © 2016 BuildThings. All rights reserved.
//

import Foundation
import Jellybean

public class CardModel : NSCoding {
  
  public var frontText: String
  public var backText: String
  public let spacing: JBSpacing
  
  public init(frontText: String, backText: String) {
    self.frontText = frontText
    self.backText = backText
    self.spacing = JBSpacing()
  }
  
  public func encode(with aCoder: NSCoder) {
    aCoder.encode(frontText, forKey:"frontText")
    aCoder.encode(backText, forKey:"backText")
    aCoder.encode(spacing, forKey:"spacing")
  }
  
  public required init?(coder aDecoder: NSCoder) {
    self.frontText = aDecoder.decodeObject(forKey: "frontText") as! String
    self.backText = aDecoder.decodeObject(forKey: "backText") as! String
    self.spacing = aDecoder.decodeObject(forKey: "spacing") as! JBSpacing
  }
  
}
