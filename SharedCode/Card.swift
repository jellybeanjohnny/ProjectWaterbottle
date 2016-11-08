//
//  Card.swift
//  ProjectWaterBottle
//
//  Created by Matt Amerige on 11/7/16.
//  Copyright © 2016 BuildThings. All rights reserved.
//

import Foundation
import RealmSwift
import Jellybean

class Card: Object {
  
  public dynamic var frontText: String? = nil
//  public dynamic var frontAttributedText: NSAttributedString? = nil
  public dynamic var backText: String? = nil
  
  let spacing = JBSpacing()
  
  public dynamic var dueDate: Date {
    return spacing.dueDate
  }
  
  public func markCorrect() {
    spacing.increaseSpacing()
  }
  
  public func markIncorrect() {
    spacing.decreaseSpacing()
  }
  
}
