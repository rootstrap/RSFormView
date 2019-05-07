//
//  FormViewModel.swift
//  RSFormView
//
//  Created by Germán Stábile on 4/30/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import Foundation

public enum ValidationType {
  case email
  case nonEmpty
  case numeric
  case date
  case usState
  case phone
  case zip
  case none
  case expiration
}

public protocol FormViewModel: class {
  var items: [FormItem] { get set }
  func validateFields() -> Bool
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
