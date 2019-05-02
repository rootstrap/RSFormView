//
//  FormTextCell.swift
//  Avinew
//
//  Created by Germán Stábile on 3/12/19.
//  Copyright © 2019 TopTier labs. All rights reserved.
//

import Foundation
import UIKit

class FormTextCell: UITableViewCell {
  
  static let reuseIdentifier = "FormTextCellIdentifier"
  @IBOutlet weak var formTextLabel: UILabel!
  
  func update(withAttributedText attributedText: NSAttributedString) {
    formTextLabel.attributedText = attributedText
  }
}
