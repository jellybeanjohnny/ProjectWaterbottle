//
//  CardModel.swift
//  ProjectWaterBottle
//
//  Created by Matt Amerige on 10/1/16.
//  Copyright © 2016 BuildThings. All rights reserved.
//

import Foundation

public struct CardModel {
  
 public var frontText: String
 public var backText: String
  
 public init(frontText: String, backText: String) {
    self.frontText = frontText
    self.backText = backText
  }
  
}
