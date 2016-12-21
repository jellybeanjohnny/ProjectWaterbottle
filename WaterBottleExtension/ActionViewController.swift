//
//  ActionViewController.swift
//  WaterBottleExtension
//
//  Created by Matt Amerige on 10/1/16.
//  Copyright © 2016 BuildThings. All rights reserved.
//

import UIKit
import MobileCoreServices
import SharedCode
import Realm

class ActionViewController: UIViewController {
  
  var cardEditorViewController: CardEditorViewController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    parseSelectedText { (text, error) in
      if let text = text {
        let card = Card()
        card.frontText = text
        self.cardEditorViewController.card = card
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
  
  

  @IBAction func done() {
    
    RealmInterface.shared.save(card: cardEditorViewController.card)
    
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
  
  

  
}

















