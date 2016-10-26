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

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let sharedDefaults = UserDefaults(suiteName: Secrets.appGroupName)
    let data = sharedDefaults?.object(forKey: Constants.userDefaultsCardDataKey) as! [Data]
    
    for datum in data {
      let card = NSKeyedUnarchiver.unarchiveObject(with: datum) as! CardModel
      print(card)
    }
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

