//
//  XCUIAppExtension.swift
//  RSFormViewExampleAppUITests
//
//  Created by sol manini on 5/31/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import XCTest

extension XCUIApplication {
  
  func textField(with identifier: String) -> XCUIElement {
    return textFields.matching(identifier: identifier).element(boundBy: 0)
  }
  
  func secureTextField(with identifier: String) -> XCUIElement {
    return secureTextFields.matching(identifier: identifier).element(boundBy: 0)
  }
  
  func menuItem(with identifier: String) -> XCUIElement {
    return menuItems.matching(identifier: identifier).element(boundBy: 0)
  }
  
}
