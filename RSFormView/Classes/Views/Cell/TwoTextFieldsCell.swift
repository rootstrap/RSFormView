//
//  TwoTextFieldsCell.swift
//  RSFormView
//
//  Created by Germán Stábile on 1/29/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import Foundation
import UIKit

class TwoTextFieldsCell: UITableViewCell, FormViewCell {
  
  static let reuseIdentifier = "TwoTextFieldsCellIdentifier"
  
  @IBOutlet weak var firstTextField: TextFieldView!
  @IBOutlet weak var secondTextField: TextFieldView!
  
  weak var delegate: FormCellDelegate?
  
  override func awakeFromNib() {
    firstTextField.delegate = self
    secondTextField.delegate = self
  }
  
  func update(withFormItem formItem: FormItem, formConfigurator: FormConfigurator) {
    guard formItem.formFields.count == 2 else { return }
    
    let firstFieldData = formItem.formFields[0]
    let secondFieldData = formItem.formFields[1]
  
    isAccessibilityElement = false
    contentView.backgroundColor = formConfigurator.fieldsBackgroundColor
    backgroundColor = formConfigurator.fieldsBackgroundColor
    
    update(textFieldView: firstTextField,
           withData: firstFieldData,
           formConfigurator: formConfigurator)
    update(textFieldView: secondTextField,
           withData: secondFieldData,
           formConfigurator: formConfigurator)
  }
  
  func update(textFieldView: TextFieldView, withData data: FormField, formConfigurator: FormConfigurator) {
    textFieldView.update(withData: data, formConfigurator: formConfigurator)
  }
  
  func updateErrorState() {
    firstTextField.updateErrorState()
    secondTextField.updateErrorState()
  }
}

extension TwoTextFieldsCell: TextFieldDelegate {
  func didUpdate(textFieldView: TextFieldView, with fieldData: FormField) {
    textFieldView.textField.text = fieldData.value
    delegate?.didUpdate(data: fieldData)
  }
}
