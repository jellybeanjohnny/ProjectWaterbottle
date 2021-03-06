//
//  CardModel.swift
//  ProjectWaterBottle
//
//  Created by Matt Amerige on 10/1/16.
//  Copyright © 2016 BuildThings. All rights reserved.
//

import Foundation
import Jellybean

public class CardModel: NSObject, NSCoding {
  
  public var frontText: String
  public var frontAttributedText: NSAttributedString?
  public var backText: String
  
  public var dueDate: Date {
    return spacing.dueDate
  }
  
  let spacing: JBSpacing
  
  
  public override var description: String {
    return "\n----Card Info----\nFront Text: \(frontText)\nBack Text: \(backText)\nDue Date:\(dueDate)"
  }
  
  public init(frontText: String, backText: String) {
    self.frontText = frontText
    self.backText = backText
    self.spacing = JBSpacing()
    super.init()
  }
  
  public func encode(with aCoder: NSCoder) {
    aCoder.encode(frontText, forKey:"frontText")
    aCoder.encode(backText, forKey:"backText")
    aCoder.encode(spacing, forKey:"spacing")
    aCoder.encode(frontAttributedText, forKey:"frontAttributedText")
  }
  
  public required init?(coder aDecoder: NSCoder) {
    self.frontText = aDecoder.decodeObject(forKey: "frontText") as! String
    self.backText = aDecoder.decodeObject(forKey: "backText") as! String
    self.spacing = aDecoder.decodeObject(forKey: "spacing") as! JBSpacing
    self.frontAttributedText = aDecoder.decodeObject(forKey: "frontAttributedText") as? NSAttributedString
  }
  
  
  public func markCorrect() {
    spacing.increaseSpacing()
  }
  
  public func markIncorrect() {
    spacing.decreaseSpacing()
  }
  
  
  
}

