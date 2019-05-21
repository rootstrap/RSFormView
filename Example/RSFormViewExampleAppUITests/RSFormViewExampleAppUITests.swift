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
    let emailTextField = app.textFields["EMAIL"]
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
    
    let firstNameTextField = app.textFields["FIRST NAME"]
    firstNameTextField.clearText()
    firstNameTextField.typeText("German")
    
    toolbarNextButton.tap()
    
    let lastNameTextField = app.textFields["LAST NAME"]
    lastNameTextField.typeText("German")
    
    toolbarNextButton.tap()
    
    let passwordField = app.secureTextFields["PASSWORD"]
    UIPasteboard.general.string = "holahola"
    passwordField.doubleTap()
    app.menuItems["Paste"].tap()
    
    toolbarNextButton.tap()
    let confirmPasswordField = app.secureTextFields["CONFIRM PASSWORD"]
    UIPasteboard.general.string = "holaholahola"
    confirmPasswordField.doubleTap()
    app.menuItems["Paste"].tap()
    
    sleep(1)
    confirmPasswordField.clearText(text: "holaholahola")
    
    UIPasteboard.general.string = "holahola"
    confirmPasswordField.doubleTap()
    app.menuItems["Paste"].tap()
    
    sleep(1)
    
    let addressTextField = app.textFields["ADDRESS"]
    addressTextField.tap()
    addressTextField.typeText("Some address")
    
    toolbarNextButton.tap()
    
    let cityTextField = app.textFields["CITY"]
    cityTextField.typeText("New York")
    
    toolbarNextButton.tap()
    
    let stateTextField = app.textFields["STATE"]
    stateTextField.typeText("NY")
    
    sleep(1)
    
    let zipCodeField = app.textFields.matching(identifier: "ZIP CODE").element(boundBy: 0)
    zipCodeField.tap()
    zipCodeField.typeText("12345")
    
    app.textFields["DOB"].tap()
    
    let datePickers = app.datePickers
    datePickers.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "September")
    datePickers.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "13")
    datePickers.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "1989")
    
    app.textFields.matching(identifier: "AGE").element(boundBy: 0).tap()
    
    let agePicker = app.pickers
    agePicker.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "4")
    
    toolbarDoneButton.tap()
    
    let button = app.buttons["Collect Data"]
    XCTAssertTrue(button.isEnabled)
    button.tap()
    
    sleep(1)
    
    XCTAssertTrue(app.buttons["OK"].exists)
    
    //TODO: Test collected data is valid
  }
}
