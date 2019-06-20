//
//  FormViewCell.swift
//  RSFormView
//
//  Created by Germán Stábile on 1/25/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import Foundation
import UIKit

class TextFieldCell: FormTableViewCell {
  
  static let reuseIdentifier = "TextFieldCellIdentifier"
  
  @IBOutlet weak var textFieldView: TextFieldView!

  override func awakeFromNib() {
    textFieldView.delegate = self
  }
  
  override func update(with formItem: FormItem, and formConfigurator: FormConfigurator) {
    isAccessibilityElement = false
    guard let fieldData = formItem.formFields.first else { return }
    textFieldView.update(withData: fieldData, formConfigurator: formConfigurator)
  }
  
  override func updateErrorState() {
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
