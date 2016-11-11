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

public class Card: Object {
  
  //MARK: - Public Properties
  public dynamic var frontText: String?
  public dynamic var backText: String?
  public var frontAttributedText: NSAttributedString? // Realm should ignore
  public dynamic var dueDate: Date {
    return spacing.dueDate
  }
  
  //MARK: - Private Properties
  private(set) var spacing = JBSpacing() // Realm should ignore
  dynamic var frontAttributedTextData: Data?
  dynamic var spacingData: Data?
  

  
  //MARK: - Spacing
  public func markCorrect() {
    spacing.increaseSpacing()
  }
  
  public func markIncorrect() {
    spacing.decreaseSpacing()
  }
  
  //MARK: - Archiving/Unarchiving Data
 
  /// Archives the current values in the spacing and attributed text properties into Data objects
  /// so that they can be stored on Realm
  public func archiveSpacingAndTextData() {
    NSKeyedArchiver.archivedData(withRootObject: spacing)
    if let frontAttributedText = frontAttributedText {
      NSKeyedArchiver.archivedData(withRootObject: frontAttributedText)
    }
  }
  
  /// Unarchives any data that may be in the spacing and text data properties 
  /// and sets the corresponding properties with those values
  public func unarchiveSpacingAndTextData() {
    if let spacingData = spacingData {
      spacing = NSKeyedUnarchiver.unarchiveObject(with: spacingData) as! JBSpacing
    }
    
    if let frontAttributedTextData = frontAttributedTextData {
      frontAttributedText = NSKeyedUnarchiver.unarchiveObject(with: frontAttributedTextData) as? NSAttributedString
    }
  }
  
  override public static func ignoredProperties() -> [String] {
    return ["frontAttributedText", "spacing"]
  }
  
}
