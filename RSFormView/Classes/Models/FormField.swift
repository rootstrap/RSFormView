//
//  FormField.swift
//  RSFormView
//
//  Created by Germán Stábile on 1/28/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import Foundation

open class FormItem {
  var formFields: [FormField]
  
  /// Set with the desired attributed text for text only rows, leave empty for TextFieldView rows
  public var attributedText: NSAttributedString?
  
  /**
   - Parameters:
      - firstField: the FormField describing the first TextFieldView of the row, leave empty for text only row.
      - secondField: the FormField describing the second TextFieldView of the row, leave empty for text only row and rows with only one TextFieldView
  */
  public init(firstField: FormField? = nil, secondField: FormField? = nil) {
    var fields: [FormField] = []
    [firstField, secondField].forEach {
      if let field = $0 {
        fields.append(field)
      }
    }
    
    self.formFields = fields
  }
}

open class FormField {
  /// The identifier of the FormField
  public var name: String
  
  /// The current text entry of the FormField
  public var value: String
  
  /// Placeholder shown on the TextFieldView when value is empty
  public var placeholder: String
  
  /// Defines the kind of TextFieldView we wish to define
  public var fieldType: FieldType
  
  /// Defines the predefined or custom validation we want to apply to the text entry
  public var validationType: ValidationType?
  
  /// Defines the error message to be displayed when the text entry is invalid
  public var errorMessage: String
  
  /// Defines the error message to be displayed when the FormField is manually marked invalid
  public var oneTimeErrorMessage: String?
  
  /// Whether the text entry was valid or not
  public var isValid: Bool
  
  /// Whether the TextFieldView should show error or not when on invalid state
  /// The var will initially be false and set to true when a change is made to the associated TextFieldView
  public var shouldDisplayError = false
  
  /// Whether the text in TextFieldView should be capitalized or not
  public var capitalizeValue = true
  
  /// Whether the text in TextFieldView should be uppercased or not
  public var uppercaseValue = false
  
  /// The name of the field that this field should be matching
  public var validationMatch: String?
  
  /// Whether or not the text field within TextFieldView should be enabled or not
  public var isEnabled = true
  
  /// The minimum selectable date for *.date* FormFields
  public var minimumDate: Date?
  
  /// The maximum selectable date for *.date* FormFields
  public var maximumDate: Date?
  
  /// Source data for *.picker* FormFields
  public var options: [String]?
  
  /// The default validation type for a given fieldType, this will be overriden by setting the FormField's *validationType*
  var defaultValidationType: ValidationType {
    var validationType: ValidationType = .none
    switch fieldType {
    case .usPhone:
      validationType = .usPhone
    case .email:
      validationType = .email
    case .expiration:
      validationType = .expiration
    case .regular, .date:
      validationType = .nonEmpty
    case .fiveDigitZipCode:
      validationType = .fiveDigitZipCode
    case .password:
      validationType = .nonEmpty
    case .numeric:
      validationType = .numeric
    case .usState:
      validationType = .usState
    case .picker:
      validationType = .nonEmpty
    }
    
    return validationType
  }
  
  public init(name: String,
              initialValue: String,
              placeholder: String,
              fieldType: FieldType,
              isValid: Bool,
              errorMessage: String) {
    self.name = name
    self.value = initialValue
    self.placeholder = placeholder
    self.isValid = isValid
    self.fieldType = fieldType
    self.errorMessage = errorMessage
  }
}
