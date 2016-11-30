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

  
  public var card: Card!
  
  var searchTerm: String?
  
  var cardBackViewController: CardBackViewController!
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    
    addCustomMenu()
    
    
  }
  
  func addCustomMenu() {
    let defineMenuItem = UIMenuItem(title: "WB-Define", action: #selector(define))
    UIMenuController.shared.menuItems = [defineMenuItem]
  }
  
  public override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    initializeCard()
  }
  
  func initializeCard() {
    frontTextView.text = card.frontText
  }
  
  /// Defines the selected word and adds it to the back of the card
  func define() {
    
    searchTerm = selectedText()
    highlightSelectedText()
    
    performSegue(withIdentifier: "ShowDefinitions", sender: nil)
    
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
    card.frontAttributedText = frontTextView.attributedText
  }
  
  public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowDefinitions" {
      let definitionsVC = segue.destination as! DefinitionsViewController
      definitionsVC.searchTerm = searchTerm
      definitionsVC.delegate = self
    } else if segue.identifier == "EmbedCardBack" {
      cardBackViewController = segue.destination as! CardBackViewController
    }
  }
  
}


//MARK: - DefinitionsViewController Delegate
extension CardEditorViewController: DefinitionsViewControllerDelegate {
  
  func definitionsViewController(_ controller: DefinitionsViewController, didSelect definition: JapaneseDefinition) {
    cardBackViewController.add(definition: definition)
  }
  
}

