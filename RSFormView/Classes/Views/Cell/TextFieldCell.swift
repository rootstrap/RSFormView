//
//  FormViewCell.swift
//  RSFormView
//
//  Created by Germán Stábile on 1/25/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import Foundation
import UIKit

protocol FormCellDelegate: class {
  func didUpdate(data: FormField)
}

protocol FormViewCell: class {
  func updateErrorState()
}

class TextFieldCell: UITableViewCell, FormViewCell {
  
  static let reuseIdentifier = "TextFieldCellIdentifier"
  
  @IBOutlet weak var textFieldView: TextFieldView!
  
  weak var delegate: FormCellDelegate?
  
  override func awakeFromNib() {
    textFieldView.delegate = self
  }
  
  func update(withData data: FormField, formConfigurator: FormConfigurator) {
    contentView.backgroundColor = formConfigurator.fieldsBackgroundColor
    backgroundColor = formConfigurator.fieldsBackgroundColor
    isAccessibilityElement = false
    textFieldView.update(withData: data, formConfigurator: formConfigurator)
  }
  
  func updateErrorState() {
    textFieldView.updateErrorState()
  }
  
  func focus() {
    textFieldView.textField.becomeFirstResponder()
  }
}

extension TextFieldCell: TextFieldDelegate {
  func didUpdate(textFieldView: TextFieldView, with fieldData: FormField) {
    textFieldView.textField.text = fieldData.value
    delegate?.didUpdate(data: fieldData)
  }
}
