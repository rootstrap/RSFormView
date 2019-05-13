//
//  TextFieldView.swift
//  RSFormView
//
//  Created by Germán Stábile on 1/29/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import Foundation
import UIKit

protocol TextFieldDelegate: class {
  func didUpdate(textFieldView: TextFieldView,
                 with fieldData: FormField)
}

class TextFieldView: UIView {
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var errorLabel: UILabel!
  @IBOutlet weak var bottomLine: UIView!
  
  var actualView: UIView?
  
  static let dateFormat = "MM/dd/yyyy"
  
  var lastCursorPosition: Int?
  
  weak var delegate: TextFieldDelegate?
  var fieldData: FormField? {
    didSet {
      configureFormPicker()
      setKeyboardType()
    }
  }
  
  var formConfigurator = FormConfigurator()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configureViews()
  }
  
  func updateErrorState() {
    guard let fieldData = fieldData else { return }
    if fieldData.validationMatch == nil {
      //do not override validation match validation
      validate(with: fieldData.value)
    }
    textField.isEnabled = fieldData.isEnabled
    errorLabel.isHidden = !fieldData.shouldDisplayError || fieldData.isValid
    
    let isValid = !fieldData.shouldDisplayError || fieldData.isValid
    
    bottomLine.backgroundColor = isValid ?
      bottomLineValidColor() : formConfigurator.invalidLineColor
    titleLabel.textColor = isValid ?
      titleValidColor() : formConfigurator.invalidTitleColor
    
    errorLabel.text = fieldData.oneTimeErrorMessage ?? fieldData.errorMessage
  }
  
  func update(withData data: FormField, formConfigurator: FormConfigurator) {
    fieldData = data
    self.formConfigurator = formConfigurator
    actualView?.backgroundColor = formConfigurator.fieldsBackgroundColor
    updatePlaceHolder(withText: data.placeholder)
    textField.clearButtonMode = data.fieldType == .date ? .never : .whileEditing
    textField.isSecureTextEntry = data.fieldType == .password
    textField.text = data.value
    titleLabel.text = data.name
    errorLabel.text = data.errorMessage
    titleLabel.isHidden = data.value.isEmpty
    if !data.value.isEmpty && data.oneTimeErrorMessage == nil {
      data.shouldDisplayError = true
      validate(with: data.value)
    }
    updateErrorState()
  }
  
  func updatePlaceHolder(withText text: String) {
    let font = formConfigurator.placeholderFont
    textField.attributedPlaceholder =
      NSAttributedString(string: text,
                         attributes: [
                          .foregroundColor: formConfigurator.placeholderTextColor,
                          .font: font
        ])
  }
  
  @objc func tappedView() {
    textField.becomeFirstResponder()
  }
  
  func validate(with text: String) {
    guard let data = fieldData else { return }
    data.isValid = data.value.isValid(type: data.validationType ?? data.defaultValidationType)
  }
}

//Date picker related methods
extension TextFieldView {
  @objc func datePickerChangedValue(sender: UIDatePicker) {
    guard let data = fieldData else { return }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = TextFieldView.dateFormat
    
    let dateString = dateFormatter.string(from: sender.date)
    textField.text = dateString
    fieldData?.value = dateString
    delegate?.didUpdate(textFieldView: self, with: data)
  }
}

extension TextFieldView: UITextFieldDelegate {
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    guard let data = fieldData,
      data.fieldType != .date else {
        return false
    }
    
    if let text = textField.text,
      let textRange = Range(range, in: text) {
      let updatedText = text.replacingCharacters(in: textRange,
                                                 with: string)
      
      processTextUpdates(with: text,
                         updatedText: updatedText,
                         data: data)
    }
    
    return false
  }
  
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    guard let data = fieldData else { return true }
    data.value = ""
    data.shouldDisplayError = true
    validate(with: "")
    delegate?.didUpdate(textFieldView: self, with: data)
    return true
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    titleLabel.textColor = formConfigurator.editingTitleColor
    bottomLine.backgroundColor = formConfigurator.editingLineColor
    textField.placeholder = ""
    titleLabel.isHidden = false
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    titleLabel.isHidden = fieldData?.value ?? "" == ""
    updatePlaceHolder(withText: fieldData?.placeholder ?? "")
    updateErrorState()
  }
}
