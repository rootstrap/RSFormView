//
//  TextFieldCellITem.swift
//  RSFormView
//
//  Created by Mauricio Cousillas on 6/20/19.
//

import Foundation

/**
 Single field row.
 */
public final class TextFieldCellItem: FormItem {
  override public var cellIdentifier: String {
    return TextFieldCell.reuseIdentifier
  }

  /**
   - Parameters:
   - firstField: the FormField describing the first TextFieldView of the row.
   */
  public convenience init(with field: FormField) {
    self.init(with: [field])
  }
}
