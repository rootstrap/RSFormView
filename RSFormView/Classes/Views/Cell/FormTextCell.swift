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
  @IBOutlet weak var headerLabelTopMargin: NSLayoutConstraint!
  @IBOutlet weak var headerLabelBottomMargin: NSLayoutConstraint!
  
  func update(withFormItem formItem: FormItem, formConfigurator: FormConfigurator) {
    headerLabelTopMargin.constant = formItem.contraintsConfigurator.headerLabelTopMargin
    headerLabelBottomMargin.constant = formItem.contraintsConfigurator.headerLabelBottomMargin
    contentView.backgroundColor = formConfigurator.fieldsBackgroundColor
    backgroundColor = formConfigurator.fieldsBackgroundColor
    formTextLabel.attributedText = formItem.attributedText
  }
}
