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
    app.launch()
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testHeader() {
    let headerLabel = app.staticTexts["HeaderLabel"]
    XCTAssertTrue(headerLabel.exists)
    XCTAssertTrue(headerLabel.label == "This is one simple example of the awesome forms you can achieve with RSFormView!")
  }
  
  func testButtonInitialState() {
    let button = app.buttons["Collect Data"]
    XCTAssertFalse(button.isEnabled)
    XCTAssertTrue(button.label == "Get Entered Data")
  }
  
  func testForm() {
    let emailTextField = app.textFields["EMAIL"]
    emailTextField.tap()
    emailTextField.typeText("german.stabile")

    //TODO: Test Invalid Email
    
    emailTextField.typeText("@gmail.com")
    
    XCTAssertFalse(app.staticTexts["Please enter a valid email"].exists)
    
    let toolbarDoneButton = app.buttons["Toolbar Done Button"]
    let toolbarNextButton = app.buttons["Toolbar Next Button"]
    toolbarNextButton.tap()
    
    let firstNameTextField = app.textFields["FIRST NAME"]
    let deleteString = (firstNameTextField.value as! String).map { _ in XCUIKeyboardKey.delete.rawValue }.joined(separator: "")
    
    firstNameTextField.typeText(deleteString)
    firstNameTextField.typeText("Malandro")
    
    toolbarNextButton.tap()
    
    let lastNameTextField = app.textFields["LAST NAME"]
    lastNameTextField.typeText("Malandro")
    
    toolbarNextButton.tap()
    
    let passwordField = app.secureTextFields["PASSWORD"]
    UIPasteboard.general.string = "holahola"
    passwordField.doubleTap()
    app.menuItems["Paste"].tap()
    
    toolbarNextButton.tap()
    let confirmPasswordField = app.secureTextFields["CONFIRM PASSWORD"]
    UIPasteboard.general.string = "holaholahola"
    sleep(1)
    confirmPasswordField.doubleTap()
    app.menuItems["Paste"].tap()
    
    sleep(1)
    //TODO: Test Invalid Confirm Password
    
    let confirmDeleteString = "holaholahola".map { _ in XCUIKeyboardKey.delete.rawValue }.joined(separator: "")
    confirmPasswordField.typeText(confirmDeleteString)
    
    UIPasteboard.general.string = "holahola"
    confirmPasswordField.doubleTap()
    app.menuItems["Paste"].tap()
    
    sleep(1)
    //TODO: Test Valid Confirm Password
    
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
    
    let zipCodeField = app.textFields["ZIP CODE"]
    zipCodeField.tap()
    zipCodeField.typeText("12345")
    
    app.textFields["DOB"].tap()
    
    let datePickers = XCUIApplication().datePickers
    datePickers.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "September")
    datePickers.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "13")
    datePickers.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "1989")
    
    toolbarDoneButton.tap()
    
    let button = app.buttons["Collect Data"]
    XCTAssertTrue(button.isEnabled)
    button.tap()
    
    sleep(1)
    
    XCTAssertTrue(app.buttons["OK"].exists)
    //TODO: Test collected data is valid
  }
}
