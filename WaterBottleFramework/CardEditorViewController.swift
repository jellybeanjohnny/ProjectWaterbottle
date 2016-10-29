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
  
  /// Defines the selected word and adds it to the back of the card
  func define() {
    
    let term = selectedText()
    highlightSelectedText()
    
    
    if term.characters.count == 0 {
      let alertController = UIAlertController(title: "No Text Selected", message: "First select text then tap WB-Define", preferredStyle: .alert)
      let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
      alertController.addAction(okayAction)
      present(alertController, animated: true, completion: nil)
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
    
    if backTextView.text.characters.count == 0 {
      backTextView.text = "\(definition)"
    } else {
      backTextView.text = "\(backTextView.text!)\n\n\(definition)"
    }
    card.backText = backTextView.text
  }
  
  func selectedText() -> String {
    
    var result = ""
    
    if frontTextView.selectedRange.length != 0 {
      let text = frontTextView.text as NSString
      result = text.substring(with: frontTextView.selectedRange) as String
    }
    return result
  }
  
  func highlightSelectedText() {
    let range = frontTextView.selectedRange
    let text = NSMutableAttributedString(attributedString: frontTextView.attributedText)
    let attributes = [
      NSForegroundColorAttributeName : UIColor.red,
      NSFontAttributeName: UIFont.boldSystemFont(ofSize: UIFont.highlightedFontSize)]
    text.addAttributes(attributes, range: range)
    frontTextView.attributedText = text
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
