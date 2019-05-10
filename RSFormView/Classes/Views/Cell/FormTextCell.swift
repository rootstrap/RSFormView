//
//  FormTextCell.swift
//  RSFormView
//
//  Created by Germán Stábile on 3/12/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import Foundation
import UIKit

class FormTextCell: UITableViewCell {
  
  static let reuseIdentifier = "FormTextCellIdentifier"
  @IBOutlet weak var formTextLabel: UILabel!
  
  func update(withAttributedText attributedText: NSAttributedString, formConfigurator: FormConfigurator) {
    contentView.backgroundColor = formConfigurator.fieldsBackgroundColor
    backgroundColor = formConfigurator.fieldsBackgroundColor
    formTextLabel.attributedText = attributedText
  }
}
