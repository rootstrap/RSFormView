//
//  TextFieldView.swift
//  RSFormView
//
//  Created by Germán Stábile on 1/29/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

public protocol TextFieldDelegate: class {
  func didUpdate(textFieldView: TextFieldView,
                 with fieldData: FormField)
}

@IBDesignable
public class TextFieldView: UIView {
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var errorLabel: UILabel!
  @IBOutlet weak var bottomLineView: UIView!
  @IBOutlet weak var textFieldContainerView: UIView!
  @IBOutlet weak var titleLabelContainerView: UIView!
  @IBOutlet weak var labelToTextFieldConstraint: NSLayoutConstraint!
  @IBOutlet weak var textFieldToBottomLineConstraint: NSLayoutConstraint!
  @IBOutlet weak var bottomLineToErrorLabelConstraint: NSLayoutConstraint!
  @IBOutlet weak var textFieldContainerToErrorLabelConstraint: NSLayoutConstraint!
  
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

  var isValid: Bool {
    return fieldData?.isValid ?? false
  }

  var borderColor: UIColor? {
    didSet {
      setNeedsDisplay()
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

  override public func draw(_ rect: CGRect) {
    super.draw(rect)
    guard let context = UIGraphicsGetCurrentContext() else { return }
    context.resetClip()

    let shouldClip = !(fieldData?.value.isEmpty ?? true) || textField.placeholder?.isEmpty ?? true
    let currentBorderColor = borderColor ?? formConfigurator.validBorderColor
    let rectPath = UIBezierPath(roundedRect: textFieldContainerView.frame,
                                cornerRadius: formConfigurator.borderCornerRadius)
    rectPath.lineWidth = formConfigurator.borderWidth

    if shouldClip {
      let clipPath = UIBezierPath(roundedRect: .infinite,
                                  cornerRadius: formConfigurator.borderCornerRadius)
      let titleLabelPath = UIBezierPath(rect: titleLabelContainerView.frame)
      clipPath.append(titleLabelPath)
      clipPath.usesEvenOddFillRule = true
      /* Clipping paths are used to define in which areas
        the drawing context will actually draw, in this case
        If the titleView is present, we need to create a shape
        that excludes that area, so when we store the border
        that part is not drawn.
        https://developer.apple.com/documentation/uikit/uibezierpath/1624341-addclip
      */
      clipPath.addClip()
    }

    currentBorderColor.setStroke()
    rectPath.stroke()
    // Removed the clipping path, so when we paint the background, it fills the whole shape
    context.resetClip()
    formConfigurator.fieldsBackgroundColor.setFill()
    rectPath.fill()
  }
  
  /// Updates TextFieldView layout according of the validation state of the related FormField
  func updateErrorState() {
    guard let fieldData = fieldData else { return }
    if fieldData.validationMatch == nil {
      //do not override validation match validation
      validate(with: fieldData.value)
    }
    textField.isEnabled = fieldData.isEnabled
    errorLabel.isHidden = !fieldData.shouldDisplayError || fieldData.isValid
    
    let isValid = !fieldData.shouldDisplayError || fieldData.isValid
    
    configureColors(isValid)
    
    let errorText = fieldData.oneTimeErrorMessage ?? fieldData.errorMessage
    errorLabel.text = errorText
    
    errorLabel.accessibilityIdentifier = "Error\(fieldData.name)"
    errorLabel.accessibilityLabel = errorText
    errorLabel.isAccessibilityElement = !errorLabel.isHidden
    errorLabel.accessibilityTraits = .staticText
  }
  
  func configureColors(_ isValid: Bool) {
    backgroundColor = formConfigurator.cellsBackgroundColor
    titleLabel.textColor = isValid ?
      titleValidColor() : formConfigurator.invalidTitleColor
    errorLabel.textColor = formConfigurator.errorTextColor
    textField.textColor = formConfigurator.textColor
    var activeColor = isValid ?
      borderLineValidColor() : formConfigurator.invalidBorderColor
    borderColor = activeColor
    if borderColor == .clear {
      activeColor = isValid ?
        bottomLineValidColor() : formConfigurator.invalidLineColor
      bottomLineView.backgroundColor = activeColor
    }
    textField.tintColor = activeColor
  }
  
  /**
   Updates TextFieldView according to the FormField specifications
   
   - Parameters:
   - data: Model that describes the behaviour of the TextFieldView instance
   - formConfigurator: Model that describes the layout of the TextFieldView instance
   */
  func update(withData data: FormField, formConfigurator: FormConfigurator) {
    fieldData = data
    self.formConfigurator = formConfigurator
    setAccessibility(withData: data)
    populateTextView(withData: data)
    setContraints()

    updateErrorState()
  }
  
  func setContraints() {
    labelToTextFieldConstraint.constant = formConfigurator.labelToTextFieldDistance
    textFieldToBottomLineConstraint.constant = formConfigurator.textFieldToBottomLineDistance
    bottomLineToErrorLabelConstraint.constant = formConfigurator.bottomLineToErrorLabelDistance
    textFieldContainerToErrorLabelConstraint.constant = formConfigurator.textFieldContainerToErrorLabelDistance
  }
  
  func populateTextView(withData data: FormField) {
    updatePlaceHolder(withText: data.placeholder)
    textField.clearButtonMode = (data.fieldType == .date || data.fieldType == .picker) ? .never : .whileEditing
    textField.isSecureTextEntry = data.fieldType == .password
    textField.text = data.value
    titleLabel.text = data.name
    errorLabel.text = data.errorMessage
    titleLabel.isHidden = data.value.isEmpty
    titleLabelContainerView.isHidden = data.value.isEmpty
    if !data.value.isEmpty && data.oneTimeErrorMessage == nil {
      data.shouldDisplayError = true
      validate(with: data.value)
    }
  }
  
  func setAccessibility(withData data: FormField) {
    isAccessibilityElement = false
    titleLabel.isAccessibilityElement = false
    titleLabelContainerView.isAccessibilityElement = false
    textFieldContainerView.isAccessibilityElement = false
    textField.accessibilityIdentifier = data.name
    textField.accessibilityLabel = data.name
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
      && data.value.isValidLength(maxLength: data.maximumTextLength, minLength: data.minimumTextLength)
  }
}

//Date picker related methods
extension TextFieldView {
  @objc func datePickerChangedValue(sender: UIDatePicker) {
    guard let _ = fieldData else { return }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = TextFieldView.dateFormat
    
    let dateString = dateFormatter.string(from: sender.date)
    update(withPickerText: dateString)
  }
}

//General picker related methods
extension TextFieldView: UIPickerViewDelegate, UIPickerViewDataSource {
  public func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    guard let fieldOptions = fieldData?.options else { return 0 }
    return fieldOptions.count
  }
  
  public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    guard let fieldOptions = fieldData?.options else { return "" }
    return fieldOptions[row]
  }
  
  public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    guard let fieldData = fieldData,
      let fieldOptions = fieldData.options else { return }
    let pickerString = fieldOptions[row]
    update(withPickerText: pickerString)
  }
}

extension TextFieldView: UITextFieldDelegate {
  public func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    guard let data = fieldData,
      data.fieldType != .date, data.fieldType != .picker else {
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
  
  public func textFieldShouldClear(_ textField: UITextField) -> Bool {
    guard let data = fieldData else { return true }
    data.value = ""
    data.shouldDisplayError = true
    validate(with: "")
    delegate?.didUpdate(textFieldView: self, with: data)
    return true
  }
  
  public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    if let data = fieldData,
        let options = data.options,
        data.fieldType == .picker,
        textField.text?.isEmpty ?? true {
        update(withPickerText: options[0])
    }
    return true
  }
  
  public func textFieldDidBeginEditing(_ textField: UITextField) {
    titleLabel.textColor = formConfigurator.editingTitleColor
    textField.placeholder = ""
    titleLabel.isHidden = false
    titleLabelContainerView.isHidden = false
    borderColor = formConfigurator.editingBorderColor
    textField.tintColor = formConfigurator.editingBorderColor
    if borderColor == .clear {
      bottomLineView.backgroundColor = formConfigurator.editingLineColor
      textField.tintColor = formConfigurator.editingLineColor
    }
    setNeedsDisplay()
  }
  
  public func textFieldDidEndEditing(_ textField: UITextField) {
    titleLabel.isHidden = fieldData?.value ?? "" == ""
    titleLabelContainerView.isHidden = fieldData?.value ?? "" == ""
    updatePlaceHolder(withText: fieldData?.placeholder ?? "")
    updateErrorState()
    setNeedsDisplay()
  }
}

