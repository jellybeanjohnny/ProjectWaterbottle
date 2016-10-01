//
//  ActionViewController.swift
//  WaterBottleExtension
//
//  Created by Matt Amerige on 10/1/16.
//  Copyright © 2016 BuildThings. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    parseSelectedText { (text, error) in
      print(text)
    }
    
    
  }
  
  func parseSelectedText(completion: @escaping (String?, Error?)->()){
    
    for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
      for provider in item.attachments! as! [NSItemProvider] {
        if provider.hasItemConformingToTypeIdentifier(kUTTypeText as String) {
          // This is an image. We'll load it, then place it in our image view.
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
    // Return any edited content to the host app.
    // This template doesn't do anything, so we just echo the passed in items.
    self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
  }
  
}
