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
  var attributedText: NSAttributedString?
  
  public init(formFields: [FormField]) {
    self.formFields = formFields
  }
}

open class FormField {
  public var name: String
  public var value: String
  public var placeholder: String
  public var validationType: ValidationType
  public var errorMessage: String
  public var oneTimeErrorMessage: String?
  public var isValid: Bool
  public var shouldDisplayError = false
  public var isPasswordField: Bool
  public var capitalizeValue = true
  public var uppercaseValue = false
  public var validationMatch: String? //the name of the field that this field should be matching
  public var isEnabled = true
  public var minimunDate: Date?
  public var maximumDate: Date?
  public var customValidationBlock: ((String) -> (Bool))? // a block for custom validations, the result of this validation will have precedence over validationType
  
  public init(name: String, value: String,
       placeholder: String, validationType: ValidationType,
       isValid: Bool, errorMessage: String,
       isPasswordField: Bool = false,
       validationMatch: String? = nil) {
    self.name = name
    self.value = value
    self.placeholder = placeholder
    self.isValid = isValid
    self.validationType = validationType
    self.errorMessage = errorMessage
    self.isPasswordField = isPasswordField
    self.validationMatch = validationMatch
  }
}
