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
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(showBack))
        textStackView.addGestureRecognizer(tapRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleRefresh), name: .onCardStoreRefresh, object: nil)
        
    }
    
    func handleRefresh() {
        
        print("Cards: \(CardDataStore.sharedStore.allCards.count)\nDue: \(CardDataStore.sharedStore.dueCards.count)")
        
        if !CardDataStore.sharedStore.dueCards.isEmpty {
            setupReviewSession()
        } else {
            displayFinishedMessage()
        }
    }
    
    func setupReviewSession() {
        showCardFront()
        hideCardBackAndAnswers()
        displayCard()
    }
    
    func showCardFront() {
        frontTextView.isHidden = false
        textStackView.isHidden = false
        textStackView.isUserInteractionEnabled = true
    }
    
    func hideCardBackAndAnswers() {
        backTextView.isHidden = true
        completedLabel.isHidden = true
        answerButtonsStackView.isHidden = true
    }
    
    @IBAction func correctButtonTapped() {
        processAnswer(isCorrect: true)
        displayCard()
    }
    
    @IBAction func incorrectButtonTapped() {
        processAnswer(isCorrect: false)
        displayCard()
    }
    
    func processAnswer(isCorrect: Bool) {
        if isCorrect {
            currentCard?.markCorrect()
        } else {
            currentCard?.markIncorrect()
        }
        advanceIndex()
    }
    
    
    func presentCard(_ card: CardModel) {
        frontTextView.attributedText = card.frontAttributedText
        backTextView.text = card.backText
    }
    
    func nextCard() -> CardModel? {
        if currentIndex < CardDataStore.sharedStore.dueCards.count {
            return CardDataStore.sharedStore.dueCards[currentIndex]
        }
        return nil
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
    
    func displayCard() {
        if let next = nextCard() {
            currentCard = next
            presentCard(next)
        } else {
            displayFinishedMessage()
        }
    }
    
    func resetIndex() {
        currentIndex = 0
    }
    
    func advanceIndex() {
        currentIndex += 1
    }
    
    
}

