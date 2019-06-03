//
//  StringExtension.swift
//  RSFormView
//
//  Created by Germán Stábile on 4/30/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import Foundation

extension String {
  func isValid(type: ValidationType) -> Bool {
    var isValid = true
    switch type {
    case .email:
      isValid = isEmailFormatted()
    case .integer:
      isValid = isInteger()
    case .double(let maxDecimalPlaces):
        isValid = isValidDouble(maxDecimalPlaces: maxDecimalPlaces)
    case .usState:
      isValid = AddressManager.validateState(state: self)
    case .usPhone:
      isValid = isPhoneNumber()
    case .fiveDigitZipCode:
      isValid = isZipCode()
    case .expiration:
      isValid = isExpirationDate()
    case .nonEmpty:
      isValid = !isEmpty
    case .custom(let evaluator):
      isValid = evaluator(self)
    default:
      break
    }
    return isValid
  }
  
  //Regex fulfill RFC 5322 Internet Message format
  func isEmailFormatted() -> Bool {
    let predicate = NSPredicate(format: "SELF MATCHES %@", "[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(\\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*@([A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])?")
    return predicate.evaluate(with: self)
  }
  
  func isInteger() -> Bool {
    return Int(self) != nil
  }
    
  // Credit to Markus Bodner for the tutorial this code is sourced from
  // https://www.markusbodner.com/2017/06/20/how-to-verify-and-limit-decimal-number-inputs-in-ios-with-swift/
  func isValidDouble(maxDecimalPlaces: Int) -> Bool {
    // Use NumberFormatter to check if we can turn the string into a number
    // and to get the locale specific decimal separator.
    let formatter = NumberFormatter()
    formatter.allowsFloats = true // Default is true, be explicit anyways
    let decimalSeparator = formatter.decimalSeparator ?? "."  // Gets the locale specific decimal separator. If for some reason there is none we assume "." is used as separator.
    // Check if we can create a valid number. (The formatter creates a NSNumber, but
    // every NSNumber is a valid double, so we're good!)
    if formatter.number(from: self) != nil {
        // Split our string at the decimal separator
        let split = self.components(separatedBy: decimalSeparator)
        // Depending on whether there was a decimalSeparator we may have one
        // or two parts now. If it is two then the second part is the one after
        // the separator, aka the digits we care about.
        // If there was no separator then the user hasn't entered a decimal
        // number yet and we treat the string as empty, succeeding the check
        let digits = split.count == 2 ? split.last ?? "" : ""
        
        // Finally check if we're <= the allowed digits
        return digits.count <= maxDecimalPlaces    // TODO: Swift 4.0 replace with digits.count, YAY!
    }
    return false // couldn't turn string into a valid number
  }
  
  func isPhoneNumber() -> Bool {
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", "^\\d{3}-\\d{3}-\\d{4}$")
    return phoneTest.evaluate(with: self)
  }
  
  func isZipCode() -> Bool {
    return isInteger() && count == 5
  }
  
  func isExpirationDate() -> Bool {
    guard count == 7 else { return false }
    guard let month = Int(prefix(2)),
      month <= 12 else { return false }
    guard let year = Int(suffix(4)),
      year >= Calendar.current.component(.year, from: Date()) else { return false }
    guard self[index(startIndex, offsetBy: 2)] == "/" else { return false }
    
    return true
  }
  
  func isValidLength(maxLength: Int?, minLength: Int?) -> Bool  {
    var isValid = true
    if let textMinLength = minLength,
      count < textMinLength {
      isValid = false
    }
    
    if let textMaxLength = maxLength,
      textMaxLength > 0, count > textMaxLength {
      isValid = false
    }
    return isValid
  }
}
