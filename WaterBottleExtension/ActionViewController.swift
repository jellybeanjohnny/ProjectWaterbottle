//
//  ActionViewController.swift
//  WaterBottleExtension
//
//  Created by Matt Amerige on 10/1/16.
//  Copyright © 2016 BuildThings. All rights reserved.
//

import UIKit
import MobileCoreServices
import WaterBottleFramework

class ActionViewController: UIViewController {
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print(self.extensionContext?.inputItems)
    
    parseSelectedText { (text, error) in
      print(text)
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
    // Return any edited content to the host app.
    // This template doesn't do anything, so we just echo the passed in items.
        
    self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
  }
  
  @IBAction func cancelTapped(_ sender: AnyObject) {
    self.extensionContext!.completeRequest(returningItems: nil, completionHandler: nil)
  }
  
  
  //MARK: Segues
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "EmbedCardEditor" {
      let destinationVC = segue.destination as! CardEditorViewController
      
    }
  }
  
  
}

















