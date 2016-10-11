//
//  CardEditorViewController.swift
//  ProjectWaterBottle
//
//  Created by Matt Amerige on 10/1/16.
//  Copyright © 2016 BuildThings. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

public class CardEditorViewController: UIViewController {
  
  @IBOutlet weak var frontTextView: UITextView!
  @IBOutlet weak var backTextView: UITextView!
  
  
  public var card: CardModel!
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    frontTextView.delegate = self
    backTextView.delegate = self
    
    addCustomMenu()
    
    
  }
  
  func addCustomMenu() {
    let defineMenuItem = UIMenuItem(title: "WB-Define", action: #selector(define))
    UIMenuController.shared.menuItems = [defineMenuItem]
  }
  
  public override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    print("viewDidAppear")
    initializeCard()
  }
  
  func initializeCard() {
    frontTextView.text = card.frontText
    backTextView.text = card.backText
  }
  
  @IBAction func defineButtonTapped() {
//    
//    print("Should define the word \(selectedText())")
//    let searchTerm = selectedText()
//    
//    define(term: searchTerm)
  }
  
  func define() {
    
    print("Should define the word \(selectedText())")
    let term = selectedText()
    
    if term.characters.count == 0 {
      print("No text selected")
      return
    }
 
    
    let urlString = "http://www.jisho.org/api/v1/search/words"
    
    let parameters = [
      "keyword" : term
    ]
    
    Alamofire.request(urlString, method: .get, parameters: parameters).responseJSON { (response) in
      
      switch response.result {
      case .success(let value):
        let json = JSON(value)
        
        let word = JapaneseWord(json: json)
        print(word)
        self.addWordToBack(word: word)
        
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func addWordToBack(word: JapaneseWord) {
    let definition = "\(word.term)(\(word.readings[0])) : \(word.definitions[0])"
    backTextView.text = "\(backTextView.text!)\n\(definition)"
  }
  
  func selectedText() -> String {
    
    var result = ""
    
    if frontTextView.selectedRange.length != 0 {
      let text = frontTextView.text as NSString
      result = text.substring(with: frontTextView.selectedRange) as String
    } else if backTextView.selectedRange.length != 0 {
      let text = backTextView.text as NSString
      result = text.substring(with: backTextView.selectedRange) as String
    }
    return result
  }
  
}

extension CardEditorViewController: UITextViewDelegate {
  
  public func textViewDidEndEditing(_ textView: UITextView) {
    if textView == frontTextView {
      card.frontText = textView.text
      print("Front text: \(card.frontText)")
    } else if textView == backTextView {
      card.backText = backTextView.text
      print("Back text: \(card.backText)")
    }
  }
  
  
  
}
