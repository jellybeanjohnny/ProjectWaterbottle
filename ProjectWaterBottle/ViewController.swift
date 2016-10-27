//
//  ViewController.swift
//  ProjectWaterBottle
//
//  Created by Matt Amerige on 10/1/16.
//  Copyright © 2016 BuildThings. All rights reserved.
//

import UIKit
import WaterBottleCard

class ViewController: UIViewController {
  
  @IBOutlet weak var frontTextView: UITextView!
  @IBOutlet weak var backTextView: UITextView!
  @IBOutlet weak var textStackView: UIStackView!
  
  @IBOutlet weak var completedLabel: UILabel!
  
  @IBOutlet weak var incorrectButton: UIButton!
  @IBOutlet weak var correctButton: UIButton!
  
  
  
  var currentCard: CardModel?
  
  
  var currentIndex = 0
  
  let dueCards = CardDataStore.sharedStore.dueCards
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    backTextView.isHidden = true
    completedLabel.isHidden = true
    
    nextCard()
    
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(showBack))
    textStackView.addGestureRecognizer(tapRecognizer)
    
    testingSpacing()
    
  }
  
  func testingSpacing() {
    
    print("Due cards before marking:  \(CardDataStore.sharedStore.dueCards)")
    
    for card in dueCards {
      card.markCorrect()
    }
    
    CardDataStore.sharedStore.syncWithUserDefaults()
    
    print("All cards: \(CardDataStore.sharedStore.allCards)")
    
    
    
    print("Due cards after marking and syncing:  \(CardDataStore.sharedStore.dueCards)")
    
  }
  
  @IBAction func correctButtonTapped() {
    currentCard?.markCorrect()
    nextCard()
  }
  
  @IBAction func incorrectButtonTapped() {
    currentCard?.markIncorrect()
    nextCard()
  }
  
  func presentCard(forIndex index: Int) {
    
    if index < dueCards.count && !dueCards.isEmpty {
      let card = dueCards[index]
      currentCard = card
      frontTextView.text = card.frontText
      backTextView.text = card.backText
    }
  }
  
  
  func nextCard() {
    
    toggleButtons()
    CardDataStore.sharedStore.syncWithUserDefaults()
    
    if currentIndex < dueCards.count {
      presentCard(forIndex: currentIndex)
      currentIndex += 1
      backTextView.isHidden = true
    } else {
      // no more cards!
      textStackView.isHidden = true
      textStackView.isUserInteractionEnabled = false
      completedLabel.isHidden = false
    }
    
 
    
  }
  
  func showBack() {
    backTextView.isHidden = false
    toggleButtons()
  }
  
  func toggleButtons() {
    correctButton.isEnabled = !correctButton.isEnabled
    incorrectButton.isEnabled = !incorrectButton.isEnabled
  }

  
}

