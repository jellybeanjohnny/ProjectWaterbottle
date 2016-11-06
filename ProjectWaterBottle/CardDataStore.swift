//
//  CardDataStore.swift
//  ProjectWaterBottle
//
//  Created by Matt Amerige on 10/26/16.
//  Copyright © 2016 BuildThings. All rights reserved.
//

import Foundation
import SharedCode

class CardDataStore {
  
  static let sharedStore = CardDataStore()
  
  private(set) var allCards: [CardModel] = []
  private(set) var dueCards: [CardModel] = []
  
  
  init() {
    loadCards()
  }
  
  /// Loads card objects from the UserDefaults and populates the arrays with the appropriate card information
  func loadCards() {
    let sharedDefaults = UserDefaults(suiteName: Secrets.appGroupName)
    if let data = sharedDefaults?.object(forKey: Constants.userDefaultsCardDataKey) as? Data {
      allCards = NSKeyedUnarchiver.unarchiveObject(with: data) as! [CardModel]
      
      let today = Date()
      
      dueCards = allCards.filter{ $0.dueDate <= today }
      
    }
  }
  
  /// Saves the current cards to the UserDefaults and reloads the cards to repopulate the arrays
  func syncWithUserDefaults() {
    let sharedDefaults = UserDefaults(suiteName: Secrets.appGroupName)
    
    let data = NSKeyedArchiver.archivedData(withRootObject: allCards)
    
    sharedDefaults?.setValue(data, forKey: Constants.userDefaultsCardDataKey)
    
    loadCards()
  }
  
}
