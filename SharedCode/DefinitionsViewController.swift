//
//  DefinitionsViewController.swift
//  ProjectWaterBottle
//
//  Created by Matt Amerige on 11/11/16.
//  Copyright © 2016 BuildThings. All rights reserved.
//

import UIKit

class DefinitionsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var prototypeCell: DefinitionTableViewCell! {
      return tableView.dequeueReusableCell(withIdentifier: "DefinitionCell") as! DefinitionTableViewCell
  }
  
  var searchTerm: String!
  
  @IBOutlet weak var navBar: UINavigationBar!
  var entries: [JapaneseDefinition] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    loadDefinitions()
  }
  
  func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 95
  }
  
  func loadDefinitions() {
    JishoAPIClient.definitions(forTerm: searchTerm) { (definitions, error) in
      if let definitions = definitions {
        self.entries = definitions
        self.tableView.reloadData()
      }
    }
  }
  
}

//MARK: - Tableview Delegate & Datasource
extension DefinitionsViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return entries.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DefinitionCell", for: indexPath) as! DefinitionTableViewCell
    
    configure(cell: cell, forRowAt: indexPath)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    let prototypeCell = DefinitionTableViewCell(style: .default, reuseIdentifier: "DefinitionCell")
    configure(cell: prototypeCell, forRowAt: indexPath)
    
    prototypeCell.definitionLabel.sizeToFit()
    prototypeCell.termLabel.sizeToFit()
    
    return prototypeCell.bounds.height
    
  }
  
  func configure(cell: DefinitionTableViewCell, forRowAt indexPath: IndexPath) {
    let entry = entries[indexPath.row]
    
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
    cell.definitionLabel.text = entry.formatedDefinitions
  }
  
}
