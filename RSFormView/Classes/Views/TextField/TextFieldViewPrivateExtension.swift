//
//  TextFieldViewPrivateExtension.swift
//  RSFormView
//
//  Created by Germán Stábile on 5/13/19.
//

import Foundation

internal extension TextFieldView {
  func configureViews() {
    actualView = addNibView(inBundle: Constants.formViewBundle)
    
    textField.delegate = self
    textField.font = formConfigurator.textFont
    textField.textColor = formConfigurator.textColor
    
    titleLabel.font = formConfigurator.titleFont
    titleLabel.textColor = formConfigurator.textColor
    titleLabel.backgroundColor = formConfigurator.fieldsBackgroundColor
    titleLabelContainerView.backgroundColor = formConfigurator.fieldsBackgroundColor
    
    errorLabel.font = formConfigurator.errorFont
    errorLabel.textColor = formConfigurator.errorTextColor
    
    textFieldContainerView.addBorder(color: formConfigurator.validBorderColor,
                         weight: formConfigurator.borderWidth,
                         backgroundColor: formConfigurator.fieldsBackgroundColor)
    textFieldContainerView.setRoundBorders(formConfigurator.borderCornerRadius)
    
    setContraints() 
    
    actualView?.sendSubviewToBack(textFieldContainerView)
    
    let tapGesture = UITapGestureRecognizer(target: self,
                                            action: #selector(tappedView))
    addGestureRecognizer(tapGesture)
    updateErrorState()
  }
  
  func saveCursorPosition() {
    if let selectedRange = textField.selectedTextRange {
      lastCursorPosition = textField.offset(from: textField.beginningOfDocument,
                                            to: selectedRange.start)
    }
  }
  
  func setCursorPosition(isDeleting: Bool = false) {
    guard let lastCursorPosition = lastCursorPosition,
      fieldData?.fieldType != .usPhone,
      fieldData?.fieldType != .expiration,
      textField.selectedTextRange != nil else {
        self.lastCursorPosition = nil
        return
    }
    
    if let newPosition = textField.position(from: textField.beginningOfDocument,
                                            offset: lastCursorPosition + (isDeleting ? -1 : 1)) {
      textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
    }
    
    self.lastCursorPosition = nil
  }
  
  func titleValidColor() -> UIColor {
    return textField.isFirstResponder ? formConfigurator.editingTitleColor : formConfigurator.validTitleColor
  }
  
  func bottomLineValidColor() -> UIColor {
    return textField.isFirstResponder ?
      formConfigurator.editingLineColor : formConfigurator.validLineColor
  }
  
  func borderLineValidColor() -> CGColor {
    return textField.isFirstResponder ?
      formConfigurator.editingBorderColor.cgColor : formConfigurator.validBorderColor.cgColor
  }
  
  func setKeyboardType() {
    guard let fieldData = fieldData else { return }
    switch fieldData.fieldType {
    case .integer, .usPhone, .fiveDigitZipCode, .expiration:
      textField.keyboardType = .numberPad
    case .double:
        textField.keyboardType = .decimalPad
    case .email:
      textField.keyboardType = .emailAddress
    default:
      textField.keyboardType = .default
    }
  }
  
  func configureFormPicker() {
    guard let fieldData = fieldData,
      fieldData.fieldType == .date ||
      fieldData.fieldType == .picker else {
        textField.inputView = nil
        return
    }
    if fieldData.fieldType == .date {
      setDatePicker(with: fieldData)
    } else {
      setGeneralPicker(with: fieldData)
    }
  }
  
  func setDatePicker(with fieldData: FormField) {
    let datePicker = UIDatePicker()
    if fieldData.value != "" {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = TextFieldView.dateFormat
      if let date = dateFormatter.date(from: fieldData.value) {
        datePicker.date = date
      }
    }
    datePicker.datePickerMode = .date
    datePicker.minimumDate = fieldData.minimumDate
    datePicker.maximumDate = fieldData.maximumDate
    datePicker.addTarget(self,
                         action: #selector(datePickerChangedValue),
                         for: .valueChanged)
    textField.inputView = datePicker
  }
  
  func setGeneralPicker(with fieldData: FormField) {
    let picker = UIPickerView()
    
    if let options = fieldData.options,
      let index = options.firstIndex(of: fieldData.value) {
      picker.selectRow(index, inComponent: 0, animated: false)
    }
    
    picker.delegate = self
    textField.inputView = picker
  }
  
  func processTextUpdates(with text: String, updatedText: String, data: FormField) {
    var updatedText = updatedText
    if data.fieldType == .usPhone &&
      textField.text?.count ?? 0 < updatedText.count &&
      [3, 7].contains(updatedText.count) {
      updatedText += "-"
    }
    
    if data.fieldType == .expiration {
      updatedText = processExpirationDate(previousText: text,
                                          updatedText: updatedText)
    }
    
    propagateUpdates(previousText: text, updatedText: updatedText, data: data)
  }
  
  func propagateUpdates(previousText: String, updatedText: String, data: FormField) {
    var updatedText = updatedText
    updatedText = data.capitalizeValue ? updatedText.capitalized : updatedText
    updatedText = data.uppercaseValue ? updatedText.uppercased() : updatedText
    if data.fieldType == .usState {
      updatedText = updatedText.count > 2 ? updatedText.capitalized : updatedText.uppercased()
    }
    let isDeleting = updatedText.count < previousText.count
    data.oneTimeErrorMessage = nil
    data.value = updatedText
    data.shouldDisplayError = true
    
    validate(with: updatedText)
    saveCursorPosition()
    delegate?.didUpdate(textFieldView: self, with: data)
    setCursorPosition(isDeleting: isDeleting)
  }
  
  func processExpirationDate(previousText: String, updatedText: String) -> String {
    if updatedText.count < previousText.count {
      //if deleting we don't need to do any manipulation
      return updatedText
    }
    
    var resultingText = ""
    switch previousText.count {
    case 0:
      resultingText = processExpirationMonthFirstCharacter(updatedText: updatedText)
    case 1:
      resultingText = processExpirationMonth(previousText: previousText,
                                             updatedText: updatedText)
    default:
      resultingText = updatedText
    }
    
    return resultingText
  }
  
  func processExpirationMonthFirstCharacter(updatedText: String) -> String {
    //if first character is bigger than 1 put zero at the begginning
    //since its typing a month
    if Int(updatedText) ?? 0 <= 1 {
      return updatedText
    } else {
      return "0\(updatedText)/"
    }
  }
  
  func processExpirationMonth(previousText: String, updatedText: String) -> String {
    if Int(updatedText) ?? 0 > 12 {
      return previousText
    } else {
      return "\(updatedText)/"
    }
  }
  
  func update(withPickerText pickerText: String) {
    guard let data = fieldData else { return }
    textField.text = pickerText
    data.value = pickerText
    delegate?.didUpdate(textFieldView: self, with: data)
  }
}
