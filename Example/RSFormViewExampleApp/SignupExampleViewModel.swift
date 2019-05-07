//
//  SignupExampleViewModel.swift
//  RSFormViewExampleApp
//
//  Created by Germán Stábile on 4/30/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import Foundation
import RSFormView

class SignupExampleViewModel: FormViewModel {
  var items: [FormItem] = []
  
  init() {
    items = [nameItem(), emailItem(), addressItem(),
             cityStateItem(), zipDOBItem(), passwordItem(), confirmPasswordItem()]
  }
  
  enum FieldName: String {
    case firstName = "FIRST NAME"
    case lastName = "LAST NAME"
    case city = "CITY"
    case state = "STATE"
    case zip = "ZIP CODE"
    case birthdate = "DOB"
    case email = "EMAIL"
    case password = "PASSWORD"
    case confirmPassword = "CONFIRM PASSWORD"
    case address = "ADDRESS"
  }
  
  func nameItem() -> FormItem {
    return FormItem(formFields: [firstNameField(), lastNameField()])
  }
  
  func firstNameField() -> FormField {
    let firstNameField = FormField(name: FieldName.firstName.rawValue, //Identifier for the field
      value: "John", //Provide a default value for the field
      placeholder: FieldName.firstName.rawValue, //A place holder for when theres no value
      validationType: .nonEmpty, //validation type describes the validtaion to be made as well as the keyboard used
      isValid: true, //wether is valid in its initial state
      errorMessage: "Please enter a first name") //message displayed when the value doesn't pass the validation
    
    return firstNameField
  }
  
  func emailItem() -> FormItem {
    let emailField = FormField(name: FieldName.email.rawValue,
                               value: "",
                               placeholder: FieldName.email.rawValue,
                               validationType: .email,
                               isValid: false,
                               errorMessage: "Please enter a valid email")
    
    emailField.capitalizeValue = false
    
    return FormItem(formFields: [emailField])
  }
  
  func lastNameField() -> FormField {
    let lastNameField = FormField(name: FieldName.lastName.rawValue,
                                  value: "",
                                  placeholder: FieldName.lastName.rawValue,
                                  validationType: .nonEmpty,
                                  isValid: false,
                                  errorMessage: "Please enter a last name")
    lastNameField.customValidationBlock = { [weak self] value in
      let nameField = self?.fields().first { $0.name == FieldName.firstName.rawValue }
      let nameValue = nameField?.value ?? ""
      return value.count > 5 && value == nameValue
    }
    return lastNameField
  }
  
  func addressItem() -> FormItem {
    let addressField = FormField(name: FieldName.address.rawValue,
                                 value: "",
                                 placeholder: FieldName.address.rawValue,
                                 validationType: .nonEmpty,
                                 isValid: false,
                                 errorMessage: "Please enter an address")
    
    return FormItem(formFields: [addressField])
  }
  
  func cityStateItem() -> FormItem {
    let cityField = FormField(name: FieldName.city.rawValue,
                              value: "",
                              placeholder: FieldName.city.rawValue,
                              validationType: .nonEmpty,
                              isValid: false,
                              errorMessage: "Please enter a city")
    
    let stateField = FormField(name: FieldName.state.rawValue,
                               value: "",
                               placeholder: FieldName.state.rawValue,
                               validationType: .usState,
                               isValid: false,
                               errorMessage: "Please enter a valid state")
    
    return FormItem(formFields: [cityField, stateField])
  }
  
  func zipDOBItem() -> FormItem {
    let zipField = FormField(name: FieldName.zip.rawValue,
                             value: "",
                             placeholder: FieldName.zip.rawValue,
                             validationType: .zip,
                             isValid: false,
                             errorMessage: "Please enter a Zip Code")
    
    let birthdateField = FormField(name: FieldName.birthdate.rawValue,
                                   value: "",
                                   placeholder: FieldName.birthdate.rawValue,
                                   validationType: .date,
                                   isValid: false,
                                   errorMessage: "Please enter a birthdate")
    
    return FormItem(formFields: [zipField, birthdateField])
  }
  
  func passwordItem() -> FormItem {
    let passwordField = FormField(name: FieldName.password.rawValue,
                                  value: "",
                                  placeholder: FieldName.password.rawValue,
                                  validationType: .nonEmpty,
                                  isValid: false,
                                  errorMessage: "Please enter a valid password",
                                  isPasswordField: true)
    
    return FormItem(formFields: [passwordField])
  }
  
  func confirmPasswordItem() -> FormItem {
    let confirmPasswordField = FormField(name: FieldName.confirmPassword.rawValue,
                                         value: "",
                                         placeholder: FieldName.confirmPassword.rawValue,
                                         validationType: .nonEmpty,
                                         isValid: false,
                                         errorMessage: "Passwords don't match",
                                         isPasswordField: true,
                                         validationMatch: FieldName.password.rawValue)
    
    return FormItem(formFields: [confirmPasswordField])
  }
}

