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
  public var attributedText: NSAttributedString?
  
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
