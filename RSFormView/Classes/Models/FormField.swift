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
  public var fieldType: FieldType
  public var validationType: ValidationType?
  public var errorMessage: String
  public var oneTimeErrorMessage: String?
  public var isValid: Bool
  public var shouldDisplayError = false
  public var capitalizeValue = true
  public var uppercaseValue = false
  public var validationMatch: String? //the name of the field that this field should be matching
  public var isEnabled = true
  public var minimunDate: Date?
  public var maximumDate: Date?
  public var options: [String]?
  
  var defaultValidationType: ValidationType {
    var validationType: ValidationType = .none
    switch fieldType {
    case .usPhone:
      validationType = .usPhone
    case .email:
      validationType = .email
    case .date:
      validationType = .date
    case .expiration:
      validationType = .expiration
    case .regular:
      validationType = .nonEmpty
    case .zip:
      validationType = .zip
    case .password:
      validationType = .nonEmpty
    case .numeric:
      validationType = .numeric
    case .usState:
      validationType = .usState
    }
    
    return validationType
  }
  
  public init(name: String, value: String,
              placeholder: String, fieldType: FieldType,
              isValid: Bool, errorMessage: String,
              validationMatch: String? = nil) {
    self.name = name
    self.value = value
    self.placeholder = placeholder
    self.isValid = isValid
    self.fieldType = fieldType
    self.errorMessage = errorMessage
    self.validationMatch = validationMatch
  }
}
