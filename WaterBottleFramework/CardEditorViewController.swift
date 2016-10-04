//
//  CardEditorViewController.swift
//  ProjectWaterBottle
//
//  Created by Matt Amerige on 10/1/16.
//  Copyright © 2016 BuildThings. All rights reserved.
//

import UIKit
import Alamofire

public class CardEditorViewController: UIViewController {
  
  @IBOutlet weak var frontTextView: UITextView!
  @IBOutlet weak var backTextView: UITextView!
  
  
  public var card: CardModel!
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    frontTextView.delegate = self
    backTextView.delegate = self
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
    
    print("Should define the word \(selectedText())")
    let searchTerm = selectedText()
    
    let urlString = "http://www.jisho.org/api/v1/search/words"
    
    let parameters = [
      "keyword" : searchTerm
    ]
    
    Alamofire.request(urlString, method: .get, parameters: parameters).responseJSON { (response) in
      print(response.request)  // original URL request
      print(response.response) // HTTP URL response
      print(response.data)     // server data
      print(response.result)   // result of response serialization
      print(response.result.value) // JSON value of the response
      
      
      
    }
    
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
