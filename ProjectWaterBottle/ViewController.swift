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
  
  @IBOutlet weak var answerButtonsStackView: UIStackView!
  
  
  var currentCard: CardModel?
  
  
  
  var currentIndex = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(showBack))
    textStackView.addGestureRecognizer(tapRecognizer)
    
    NotificationCenter.default.addObserver(self, selector: #selector(handleRefresh), name: .onCardStoreRefresh, object: nil)
    
  }

  func handleRefresh() {
    if !CardDataStore.sharedStore.dueCards.isEmpty {
      setupReviewSession()
    } else {
      displayFinishedMessage()
    }
  }
  
  func setupReviewSession() {
    
    backTextView.isHidden = true
    frontTextView.isHidden = false
    completedLabel.isHidden = true
    textStackView.isHidden = false
    textStackView.isUserInteractionEnabled = true
    answerButtonsStackView.isHidden = false
    nextCard()

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
    
    if index < CardDataStore.sharedStore.dueCards.count && !CardDataStore.sharedStore.dueCards.isEmpty {
      let card = CardDataStore.sharedStore.dueCards[index]
      currentCard = card
      frontTextView.attributedText = card.frontAttributedText
      backTextView.text = card.backText
    }
  }
  
  
  func nextCard() {
    
    answerButtonsStackView.isHidden = true
    CardDataStore.sharedStore.syncWithUserDefaults()
    
    if currentIndex < CardDataStore.sharedStore.dueCards.count {
      presentCard(forIndex: currentIndex)
      currentIndex += 1
      backTextView.isHidden = true
    } else {
      // no more cards!
      displayFinishedMessage()
    }
  }
  
  
  
  func showBack() {
    backTextView.isHidden = false
    answerButtonsStackView.isHidden = false
  }
  
  
  func displayFinishedMessage() {
    resetIndex()
    textStackView.isHidden = true
    textStackView.isUserInteractionEnabled = false
    completedLabel.isHidden = false
    answerButtonsStackView.isHidden = true
  }
  
  func resetIndex() {
    currentIndex = 0
  }

  
}

