//
//  DefinitionTableViewCell.swift
//  ProjectWaterBottle
//
//  Created by Matt Amerige on 11/22/16.
//  Copyright © 2016 BuildThings. All rights reserved.
//

import UIKit

class DefinitionTableViewCell: UITableViewCell {
  
  @IBOutlet weak var termLabel: UILabel!
  @IBOutlet weak var definitionTextView: UITextView!
  
  override func layoutSubviews() {
    super.layoutSubviews()
    definitionTextView.textContainerInset = .zero
  }
}
