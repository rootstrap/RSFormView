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
  var customCellSetup: ((UITableView?) -> Void)? {
    return { tableView in
      tableView?.register(StepperCell.self, forCellReuseIdentifier: StepperCell.reuseIdentifier)
    }
  }

  var items: [FormItem] = []
  
  init() {
    items = [emailItem(), nameItem(), birthDateItem(), genderItem(), siblingsItem(), passwordItem(),
             confirmPasswordItem(), addressHeaderItem(),
             addressItem(), cityStateItem(), zipItem(), switchItem()]
  }
  
  enum FieldName: String {
    case numberOfSiblings = "NUMBER OF SIBLINGS"
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
    case age = "AGE"
    case gender = "GENDER"
    case boludo = "BOLUDO"
  }
  
  var collectedData: String {
    var data = ""
    
    fields().forEach {
      data += "\($0.name): \($0.value) \n"
    }
    
    return data
  }

  func siblingsItem() -> FormItem {
    return StepperCellItem(with: FormField(name: FieldName.numberOfSiblings.rawValue, //Identifier for the field
                          initialValue: "10", //Provide a default value for the field
                          placeholder: "",
                          fieldType: .integer, //field type describes the behaviour the field will expect and provide a default validation
                          isValid: true, //wether is valid in its initial state
                          errorMessage: "Please enter a value") //message displayed when the value doesn't pass the validation
                        )
  }
  
  func nameItem() -> FormItem {
    return TwoTextFieldCellItem(firstField: firstNameField(), secondField: lastNameField())
  }
  
  func firstNameField() -> FormField {
    let firstNameField = FormField(name: FieldName.firstName.rawValue, //Identifier for the field
                                   initialValue: "John", //Provide a default value for the field
                                   placeholder: FieldName.firstName.rawValue, //A place holder for when theres no value
                                   fieldType: .regular, //field type describes the behaviour the field will expect and provide a default validation
                                   isValid: true, //wether is valid in its initial state
                                   errorMessage: "Please enter a first name") //message displayed when the value doesn't pass the validation
    firstNameField.maximumTextLength = 6 //maximum number of characters allowed on textfield
    firstNameField.minimumTextLength = 3 //minimum number of characters allowed on textfield
    return firstNameField
  }
  
  func emailItem() -> FormItem {
    let emailField = FormField(name: FieldName.email.rawValue,
                               initialValue: "",
                               placeholder: FieldName.email.rawValue,
                               fieldType: .email,
                               isValid: false,
                               errorMessage: "Please enter a valid email")
    
    return TextFieldCellItem(with: emailField)
  }
  
  func lastNameField() -> FormField {
    let lastNameField = FormField(name: FieldName.lastName.rawValue,
                                  initialValue: "",
                                  placeholder: FieldName.lastName.rawValue,
                                  fieldType: .regular,
                                  isValid: false,
                                  errorMessage: "Please enter a last name")
    lastNameField.validationType = .custom(evaluator: { [weak self] value in
      let nameField = self?.fields().first { $0.name == FieldName.firstName.rawValue }
      let nameValue = nameField?.value ?? ""
      return value.count > 5 && value == nameValue
    })
    return lastNameField
  }
  
  func addressHeaderItem() -> FormItem {
    let item = TextCellItem()
    item.contraintsConfigurator.headerLabelTopMargin = CGFloat(50)
    item.contraintsConfigurator.headerLabelBottomMargin = CGFloat(5)
    item.attributedText = NSAttributedString(string: "Enter your address",
                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.8),
                                                          NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)])
    return item
  }
  
  func addressItem() -> FormItem {
    let addressField = FormField(name: FieldName.address.rawValue,
                                 initialValue: "",
                                 placeholder: FieldName.address.rawValue,
                                 fieldType: .regular,
                                 isValid: false,
                                 errorMessage: "Please enter an address")
    
    return TextFieldCellItem(with: addressField)
  }
  
  func cityStateItem() -> FormItem {
    let cityField = FormField(name: FieldName.city.rawValue,
                              initialValue: "",
                              placeholder: FieldName.city.rawValue,
                              fieldType: .regular,
                              isValid: false,
                              errorMessage: "Please enter a city")
    
    let stateField = FormField(name: FieldName.state.rawValue,
                               initialValue: "",
                               placeholder: FieldName.state.rawValue,
                               fieldType: .usState,
                               isValid: false,
                               errorMessage: "Please enter a valid state")
    
    return TwoTextFieldCellItem(firstField: cityField, secondField: stateField)
  }
  
  func switchItem() -> FormItem {
    let attributedText = NSAttributedString(string: "Enter your address",
                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.8),
                                                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)])
    let switchField = SwitchField(isOn: false, attributedTitle: attributedText, name: FieldName.boludo.rawValue)
    
    return SwitchItem(switchField: switchField)
  }
  
  func zipItem() -> FormItem {
    let zipField = FormField(name: FieldName.zip.rawValue,
                             initialValue: "",
                             placeholder: FieldName.zip.rawValue,
                             fieldType: .fiveDigitZipCode,
                             isValid: false,
                             errorMessage: "Please enter a Zip Code")
    
    return TextFieldCellItem(with: zipField)
  }
  
  func birthDateItem() -> FormItem {
    let birthdateField = FormField(name: FieldName.birthdate.rawValue,
                                   initialValue: "",
                                   placeholder: FieldName.birthdate.rawValue,
                                   fieldType: .date,
                                   isValid: false,
                                   errorMessage: "Please enter a birthdate")
    
    return TextFieldCellItem(with: birthdateField)
  }
  
  func genderItem() -> FormItem {
    let genderOptions = ["male", "female"]
    let genderField = FormField(name: FieldName.gender.rawValue,
                                initialValue: "",
                                placeholder: FieldName.gender.rawValue,
                                fieldType: .picker,
                                isValid: false,
                                errorMessage: "Please select your gender")
    genderField.options = genderOptions
    
    return TextFieldCellItem(with: genderField)
  }
  
  func passwordItem() -> FormItem {
    let passwordField = FormField(name: FieldName.password.rawValue,
                                  initialValue: "",
                                  placeholder: FieldName.password.rawValue,
                                  fieldType: .password,
                                  isValid: false,
                                  errorMessage: "Please enter a valid password")
    passwordField.minimumTextLength = 8
    
    return TextFieldCellItem(with: passwordField)
  }
  
  func confirmPasswordItem() -> FormItem {
    let confirmPasswordField = FormField(name: FieldName.confirmPassword.rawValue,
                                         initialValue: "",
                                         placeholder: FieldName.confirmPassword.rawValue,
                                         fieldType: .password,
                                         isValid: false,
                                         errorMessage: "Passwords don't match")
    confirmPasswordField.validationMatch = FieldName.password.rawValue

    return TextFieldCellItem(with: confirmPasswordField)
  }
}

