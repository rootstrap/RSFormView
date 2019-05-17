//
//  FormViewModel.swift
//  RSFormView
//
//  Created by Germán Stábile on 4/30/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import Foundation

public enum FieldType {
  case email
  case numeric
  case date
  case usState
  case usPhone
  case fiveDigitZipCode
  case regular
  case expiration
  case password
  case picker
}

public enum ValidationType {
  case email
  case nonEmpty
  case none
  case usState
  case expiration
  case fiveDigitZipCode
  case usPhone
  case numeric
  case custom(evaluator: (String) -> (Bool))
}

public protocol FormViewModel: class {
  /// Data Source of the FormView, its value will define the amount of rows, text fields per row, and row behaviour.
  var items: [FormItem] { get set }
  
  /// Returns a bool stating if all fields in FormView are valid. A default implementation is provided.
  func validateFields() -> Bool
  
  /// Returns every FormField in items
  func fields() -> [FormField]
}

public extension FormViewModel {
  func markItemInvalid(fieldName: String, error: String) {
    if let field = fields().first(where: { $0.name == fieldName }) {
      field.isValid = false
      field.oneTimeErrorMessage = error
    }
  }
  
  func fields() -> [FormField] {
    return items.flatMap({ $0.formFields })
  }
  
  func validateFields() -> Bool {
    let invalidFields = fields().filter({ !$0.isValid })
    return invalidFields.isEmpty
  }
}
