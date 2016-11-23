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
    let cell = tableView.dequeueReusableCell(withIdentifier: "DefinitionCell", for: indexPath)
    
    let entry = entries[indexPath.row]
    
    cell.textLabel?.text = entry.word
    cell.detailTextLabel?.text = entry.reading
    
    print(entry)
    
    return cell
  }
  
}
