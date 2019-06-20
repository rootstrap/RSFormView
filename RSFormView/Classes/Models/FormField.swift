//
//  FormField.swift
//  RSFormView
//
//  Created by Germán Stábile on 1/28/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import Foundation

open class ConstraintsConfigurator {
  public var headerLabelTopMargin: CGFloat = 30
  public var headerLabelBottomMargin: CGFloat = 12.5
  
  public init() {}
}

/**
 Base FormItem class, this defines the base behaviour that a row will have.
 **You should not use concrete instances of this class in your codebase.**
 Instead use `TextFieldCellItem`, `TwoTextFieldCellItem`, `TextCellItem` or one of your own.

 For custom rows, inherit from this base class, and override the `cellIdentifier` value.
 */
open class FormItem {
  public let formFields: [FormField]

  /// Override this identifier to define which UITableViewCell will be used.
  open var cellIdentifier: String {
    return TextFieldCell.reuseIdentifier
  }
  
  /// Set with the desired attributed text for text only rows, leave empty for TextFieldView rows
  public var attributedText: NSAttributedString?
  
  /// Set with the desired contraints configurations for text only rows, leave empty for TextFieldView rows
  public var contraintsConfigurator: ConstraintsConfigurator = ConstraintsConfigurator()

  /**
   - Parameters:
   - fields: the FormFields describing the item.
   */
  public init(with fields: [FormField]) {
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
  public var errorMessage: String?
  
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
  
  /// The minimum character length allowed for the text in a TextFieldView
  public var minimumTextLength: Int?
  
  /// The maximum character length allowed for the text in a TextFieldView
  public var maximumTextLength: Int?
  
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
    case .integer:
      validationType = .integer
    case .double(let maxDecimalPlaces):
      validationType = .double(maxDecimalPlaces: maxDecimalPlaces)
    case .usState:
      validationType = .usState
    case .picker:
      validationType = .nonEmpty
    }
    
    return validationType
  }
  
  public init(name: String,
              initialValue: String,
              placeholder: String = "",
              fieldType: FieldType,
              isValid: Bool,
              errorMessage: String? = nil) {
    self.name = name
    self.value = initialValue
    self.placeholder = placeholder
    self.isValid = isValid
    self.fieldType = fieldType
    self.errorMessage = errorMessage
  }
}
