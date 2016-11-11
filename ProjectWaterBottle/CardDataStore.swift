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
  
  private(set) var allCards: [Card] = []
  private(set) var dueCards: [Card] = []
  
  
  init() {
    loadCards()
  }
  
  func loadCards() {
    
    let cards = RealmInterface.shared.loadCards()
    allCards = cards
    let today = Date()
    
    dueCards = allCards.filter{ $0.dueDate <= today }
    
    
  }
  
  
}
