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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(showBack))
    textStackView.addGestureRecognizer(tapRecognizer)
    
    NotificationCenter.default.addObserver(self, selector: #selector(handleRefresh), name: .onCardStoreRefresh, object: nil)
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if !CardDataStore.sharedStore.dueCards.isEmpty {
      setupReviewSession()
    } else {
      displayFinishedMessage()
    }
    
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
    completedLabel.isHidden = true
    completedLabel.isEnabled = true
    textStackView.isHidden = false
    textStackView.isUserInteractionEnabled = true
    
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
      frontTextView.text = card.frontText
      backTextView.text = card.backText
    }
  }
  
  
  func nextCard() {
    
    toggleButtons()
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
    toggleButtons()
  }
  
  func toggleButtons() {
    correctButton.isEnabled = !correctButton.isEnabled
    incorrectButton.isEnabled = !incorrectButton.isEnabled
  }
  
  func displayFinishedMessage() {
    textStackView.isHidden = true
    textStackView.isUserInteractionEnabled = false
    completedLabel.isHidden = false
    correctButton.isEnabled = false
    incorrectButton.isEnabled = false
  }

  
}

