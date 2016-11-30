//
//  DefinitionsViewController.swift
//  ProjectWaterBottle
//
//  Created by Matt Amerige on 11/11/16.
//  Copyright © 2016 BuildThings. All rights reserved.
//

import UIKit

protocol DefinitionsViewControllerDelegate {
  func definitionsViewController(_ controller: DefinitionsViewController, didSelect definition: JapaneseDefinition)
}

class DefinitionsViewController: UIViewController {
  

  var delegate: DefinitionsViewControllerDelegate?
  
  @IBOutlet weak var tableView: UITableView!
  
  var searchTerm: String!
  
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
    tableView.estimatedRowHeight = 80
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
    cell.definitionTextView.text = entry.formatedDefinitions
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.definitionsViewController(self, didSelect: entries[indexPath.row])
    dismiss(animated: true, completion: nil)
  }
  
}

