//
//  TwoTextFieldsCell.swift
//  RSFormView
//
//  Created by Germán Stábile on 1/29/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import Foundation
import UIKit

public class TwoTextFieldsCell: FormTableViewCell {
  
  public static let reuseIdentifier = "TwoTextFieldsCellIdentifier"
  
  @IBOutlet public weak var firstTextField: TextFieldView!
  @IBOutlet public weak var secondTextField: TextFieldView!
  
  override public func awakeFromNib() {
    firstTextField.delegate = self
    secondTextField.delegate = self
  }
  
  override public func update(with formItem: FormItem, and formConfigurator: FormConfigurator) {
    guard formItem.formFields.count == 2 else { return }
    self.formItem = formItem
    
    let firstFieldData = formItem.formFields[0]
    let secondFieldData = formItem.formFields[1]
  
    isAccessibilityElement = false

    contentView.backgroundColor = formConfigurator.cellsBackgroundColor
    update(textFieldView: firstTextField,
           withData: firstFieldData,
           formConfigurator: formConfigurator)
    update(textFieldView: secondTextField,
           withData: secondFieldData,
           formConfigurator: formConfigurator)
  }
  
  public func update(textFieldView: TextFieldView, withData data: FormField, formConfigurator: FormConfigurator) {
    textFieldView.update(withData: data, formConfigurator: formConfigurator)
  }
  
  override public func updateErrorState() {
    firstTextField.updateErrorState()
    secondTextField.updateErrorState()
  }
}

extension TwoTextFieldsCell: TextFieldDelegate {
  public func didUpdate(textFieldView: TextFieldView, with fieldData: FormField) {
    textFieldView.textField.text = fieldData.value
    delegate?.didUpdate(data: fieldData)
  }
}
