//
//  FormItem.swift
//  Pods
//
//  Created by Germán Stábile on 8/22/19.
//

import Foundation

/**
 Base FormItem class, this defines the base behaviour that a row will have.
 **You should not use concrete instances of this class in your codebase.**
 Instead use `TextFieldCellItem`, `TwoTextFieldCellItem`, `TextCellItem` or one of your own.
 
 For custom rows, inherit from this base class, and override the `cellIdentifier` value.
 */
open class FormItem {
  public let formFields: [FormField]
  
  /// Override this identifier to define which UITableViewCell will be used.
  open var cellIdentifier: String {
    return TextFieldCell.reuseIdentifier
  }
  
  /// Set with the desired attributed text for text only rows, leave empty for TextFieldView rows
  public var attributedText: NSAttributedString?
  
  /// Set with the desired contraints configurations for text only rows, leave empty for TextFieldView rows
  public var contraintsConfigurator: ConstraintsConfigurator = ConstraintsConfigurator()
  
  /**
   - Parameters:
   - fields: the FormFields describing the item.
   */
  public init(with fields: [FormField]) {
    self.formFields = fields
  }
}
