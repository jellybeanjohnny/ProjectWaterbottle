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
  @IBOutlet weak var definitionLabel: UILabel!
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    contentView.layoutIfNeeded()
    definitionLabel.preferredMaxLayoutWidth = definitionLabel.frame.width
  }
  
}
