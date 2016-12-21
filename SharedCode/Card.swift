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
  public dynamic var frontText: String? // Ignored
  public dynamic var definitions: [String]? // Realm should ignore
  public var frontAttributedText: NSAttributedString? // Realm should ignore
  public dynamic var dueDate: Date {
    return spacing.dueDate
  }
  
  //MARK: - Private Properties
  private(set) var spacing = JBSpacing() // Realm should ignore
  dynamic var frontAttributedTextData: Data?
  dynamic var definitionsData: Data?
  dynamic var spacingData: Data?
  dynamic var id = UUID().uuidString
  

  
  //MARK: - Spacing
  public func markCorrect() {
    spacing.increaseSpacing()
    archiveSpacingAndTextData()
  }
  
  public func markIncorrect() {
    spacing.decreaseSpacing()
    archiveSpacingAndTextData()
  }
  
  //MARK: - Archiving/Unarchiving Data
 
  /// Archives the current values in the spacing and attributed text properties into Data objects
  /// so that they can be stored on Realm
  public func archiveSpacingAndTextData() {
    let realm = RealmInterface.shared.defaultRealm()
    do {
      try realm.write {
        spacingData = NSKeyedArchiver.archivedData(withRootObject: spacing)
        if let frontAttributedText = frontAttributedText {
          frontAttributedTextData = NSKeyedArchiver.archivedData(withRootObject: frontAttributedText)
        }
        if let definitions = definitions {
          definitionsData = NSKeyedArchiver.archivedData(withRootObject: definitions)
        }
      }
    } catch {
      print("Unable to write archieved data to Realm: \(error.localizedDescription)")
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
    
    if let definitionsData = definitionsData {
      definitions = NSKeyedUnarchiver.unarchiveObject(with: definitionsData) as? [String]
    }
    
  }
  
  //MARK: - Realm Required Overrides
  override public static func ignoredProperties() -> [String] {
    return ["frontAttributedText", "spacing" ,"definitions", "frontText"]
  }
  
  override public static func primaryKey() -> String? {
    return "id"
  }
  
}
