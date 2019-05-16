//
//  XCUIElementExtension.swift
//  RSFormViewExampleAppUITests
//
//  Created by Germán Stábile on 5/16/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import XCTest

extension XCUIElement {
  
  func swipeAround() {
    swipeUp()
    swipeUp()
    swipeDown()
    swipeDown()
  }
  
  func clearText(text: String? = nil) {
    guard let stringValue = value as? String ?? text else {
      return
    }
    
    tap()
    let deleteString = stringValue.map { _ in XCUIKeyboardKey.delete.rawValue }.joined(separator: "")
    typeText(deleteString)
  }
}
