//
//  ActionViewController.swift
//  WaterBottleExtension
//
//  Created by Matt Amerige on 10/1/16.
//  Copyright © 2016 BuildThings. All rights reserved.
//

import UIKit
import MobileCoreServices
import WaterBottleCard

class ActionViewController: UIViewController {
  
  var cardEditorViewController: CardEditorViewController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    parseSelectedText { (text, error) in
      if let text = text {
        self.cardEditorViewController.card = CardModel(frontText: text, backText: "")
      }
    }
    
    
  }
  
  func parseSelectedText(completion: @escaping (String?, Error?)->()){
    
    for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
      for provider in item.attachments! as! [NSItemProvider] {
        if provider.hasItemConformingToTypeIdentifier(kUTTypeText as String) {
          provider.loadItem(forTypeIdentifier: kUTTypeText as String, options: nil, completionHandler: { (result, error) in
            if let text = result as? String {
              completion(text, error)
            } else {
              completion(nil, error)
            }
          })
        }
      }
    }
  }
  
  
  /*
   Example from apple's documentation
   - (IBAction)done:(id)sender {
   NSExtensionItem *outputItem = [[NSExtensionItem alloc] init];
   outputItem.attributedContentText = self.myTextView.attributedString;
   
   NSArray *outputItems = @[outputItem];
   [self.extensionContext completeRequestReturningItems:outputItems];
   }
   
   */
  @IBAction func done() {
    saveCardToSharedUserDefaultSuite()
    self.extensionContext!.completeRequest(returningItems: nil, completionHandler: nil)
  }
  
  @IBAction func cancelTapped(_ sender: AnyObject) {
    self.extensionContext!.completeRequest(returningItems: nil, completionHandler: nil)
  }
  
  
  //MARK: Segues
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "EmbedCardEditor" {
      cardEditorViewController = segue.destination as! CardEditorViewController
    }
  }
  
  func saveCardToSharedUserDefaultSuite() {
    // Save the card to the shared card array for the main app to use later on
    let sharedDefaults = UserDefaults(suiteName: Secrets.appGroupName)
    
    if let cardData = sharedDefaults?.object(forKey: Constants.userDefaultsCardDataKey) as? Data, let card = cardEditorViewController.card {
      // append to cardData
      
      var cards = NSKeyedUnarchiver.unarchiveObject(with: cardData) as! [CardModel]
      cards.append(card)
      let updatedData = NSKeyedArchiver.archivedData(withRootObject: cards)
      
      sharedDefaults?.setValue(updatedData, forKey: Constants.userDefaultsCardDataKey)
    } else {
      // no cards object exists, create one here
      if let card = cardEditorViewController.card {
        let cards = [card]
        let cardData = NSKeyedArchiver.archivedData(withRootObject: cards)
        sharedDefaults?.setValue(cardData, forKey: Constants.userDefaultsCardDataKey)
      }
    }
  } 
}

















