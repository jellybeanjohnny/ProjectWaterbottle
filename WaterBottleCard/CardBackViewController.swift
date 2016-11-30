//
//  CardBackViewController.swift
//  ProjectWaterBottle
//
//  Created by Matt Amerige on 11/29/16.
//  Copyright © 2016 BuildThings. All rights reserved.
//

import UIKit

class CardBackViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var definitions: [JapaneseDefinition] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
  }
  
}

extension CardBackViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return definitions.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DefinitionCell", for: indexPath) as! DefinitionTableViewCell
    
    configure(cell: cell, forRowAt: indexPath)
    
    return cell
  }
  
  
  func configure(cell: DefinitionTableViewCell, forRowAt indexPath: IndexPath) {
    let entry = definitions[indexPath.row]
    
    var term = ""
    
    if let word = entry.word {
      if word.characters.count > 0 {
        term += word
      }
      
    }
    
    if let reading = entry.reading {
      if reading.characters.count > 0 {
        term += " (\(reading))"
      }
      
    }
    
    cell.termLabel.text = term
    cell.definitionTextView.text = entry.formatedDefinitions
  }
  
}
