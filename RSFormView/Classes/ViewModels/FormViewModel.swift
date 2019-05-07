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
}

public extension FormViewModel {
  func markItemInvalid(fieldName: String, error: String) {
    let flatFields = items.flatMap({ $0.formFields })
    if let field = flatFields.first(where: { $0.name == fieldName }) {
      field.isValid = false
      field.oneTimeErrorMessage = error
    }
  }
  
  func validateFields() -> Bool {
    let flatFields = items.flatMap({ $0.formFields })
    let invalidFields = flatFields.filter({ !$0.isValid })
    return invalidFields.isEmpty
  }
}
