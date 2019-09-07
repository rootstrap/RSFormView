//
//  RSFormViewExampleAppUITests.swift
//  RSFormViewExampleAppUITests
//
//  Created by Germán Stábile on 5/14/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import XCTest

class RSFormViewExampleAppUITests: XCTestCase {
  var app: XCUIApplication!

  override func setUp() {
    continueAfterFailure = false
    
    app = XCUIApplication()
  }
  
  func testButtonInitialState() {
    app.launch()
    let button = app.buttons["Collect Data"]
    XCTAssertFalse(button.isEnabled)
    XCTAssertTrue(button.label == "Get Entered Data")
  }
  
  func testForm() {
    app.launch()
    let emailTextField = app.textField(with: "EMAIL")
    emailTextField.tap()
    emailTextField.typeText("german.stabile")
    
    let toolbarDoneButton = app.buttons["Toolbar Done Button"]
    let toolbarNextButton = app.buttons["Toolbar Next Button"]
    
    toolbarDoneButton.tap()
    let table = app.tables.element(boundBy: 0)
    table.swipeAround()
    
    let errorLabel = app.staticTexts["ErrorEMAIL"]
    XCTAssertTrue(errorLabel.exists)
    XCTAssertTrue(errorLabel.label == "Please enter a valid email")
    
    emailTextField.tap()
    emailTextField.typeText("@gmail.com")
    toolbarDoneButton.tap()
    table.swipeAround()
    
    XCTAssertFalse(errorLabel.exists)
    
    emailTextField.tap()
    toolbarNextButton.tap()
    
    let firstNameTextField = app.textField(with: "FIRST NAME")
    firstNameTextField.clearText()
    firstNameTextField.typeText("German")
    
    toolbarNextButton.tap()
    
    let lastNameTextField = app.textField(with: "LAST NAME")
    lastNameTextField.typeText("Stabile")
    
    app.textField(with: "DOB").tap()
    
    let datePickers = app.datePickers
    datePickers.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "September")
    datePickers.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "13")
    datePickers.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "1989")
    
    app.textField(with: "GENDER").tap()

    let genderPicker = app.pickers
    genderPicker.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "female")
    
    toolbarNextButton.tap()
    
    let passwordField = app.secureTextField(with: "PASSWORD")
    UIPasteboard.general.string = "holahola"
    passwordField.press(forDuration: 1.1)
    app.menuItems["Paste"].tap()
    
    toolbarNextButton.tap()
    let confirmPasswordField = app.secureTextField(with: "CONFIRM PASSWORD")
    UIPasteboard.general.string = "holaholahola"
    confirmPasswordField.press(forDuration: 1.1)
    app.menuItems["Paste"].tap()
    
    sleep(1)
    confirmPasswordField.clearText(text: "holaholahola")
    
    UIPasteboard.general.string = "holahola"
    confirmPasswordField.press(forDuration: 1.1)
    app.menuItems["Paste"].tap()
    
    sleep(1)
    
    let addressTextField = app.textField(with: "ADDRESS")
    addressTextField.tap()
    addressTextField.typeText("Some address")
    
    toolbarNextButton.tap()
    
    let cityTextField = app.textField(with: "CITY")
    cityTextField.tap()
    cityTextField.typeText("New York")
    
    toolbarNextButton.tap()
    
    let stateTextField = app.textField(with: "STATE")
    stateTextField.typeText("NY")
    
    sleep(1)
    
    let zipCodeField = app.textField(with: "ZIP CODE")
    zipCodeField.tap()
    zipCodeField.typeText("12345")
    
    toolbarDoneButton.tap()
    
    let button = app.buttons["Collect Data"]
    XCTAssertTrue(button.isEnabled)
    button.tap()
    
    sleep(1)
    
    XCTAssertTrue(app.buttons["OK"].exists)
    
    //TODO: Test collected data is valid
  }
}
