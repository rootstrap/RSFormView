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
  
  var firstFormField: FormField?
  var secondFormField: FormField?
  var formItem: FormItem?
  weak var delegate: FormCellDelegate?
  
  override func awakeFromNib() {
    firstTextField.delegate = self
    secondTextField.delegate = self
  }
  
  func update(withFormItem formItem: FormItem) {
    guard formItem.formFields.count > 1 else { return }
    self.formItem = formItem
    firstFormField = formItem.formFields[0]
    secondFormField = formItem.formFields[1]
    
    guard let firstFormField = firstFormField,
      let secondFormField = secondFormField else { return }
    update(textFieldView: firstTextField, withData: firstFormField)
    update(textFieldView: secondTextField, withData: secondFormField)
  }
  
  func update(textFieldView: TextFieldView, withData data: FormField) {
    textFieldView.update(withData: data)
  }
  
  func update(fieldData: FormField, withText text: String) {
    fieldData.value = text
    fieldData.shouldDisplayError = true
    fieldData.isValid = fieldData.value.isValid(type: fieldData.validationType)
    delegate?.didUpdate(data: fieldData)
  }
  
  func updateErrorState() {
    firstTextField.updateErrorState()
    secondTextField.updateErrorState()
  }
}

extension TwoTextFieldsCell: TextFieldDelegate {
  func didUpdate(textFieldView: TextFieldView, text: String) {
    guard let data = textFieldView == firstTextField ?
      firstFormField : secondFormField else { return }
    textFieldView.textField.text = text
    update(fieldData: data, withText: text)
    update(textFieldView: textFieldView, withData: data)
  }
}
