//
//  TwoTextFieldCellItem.swift
//  RSFormView
//
//  Created by Mauricio Cousillas on 6/20/19.
//

import Foundation

/**
 Double field row.
 */
public final class TwoTextFieldCellItem: FormItem {
  override public var cellIdentifier: String {
    return TwoTextFieldsCell.reuseIdentifier
  }

  /**
   - Parameters:
   - firstField: the FormField describing the first TextFieldView of the row.
   - secondField: the FormField describing the second TextFieldView of the row.
   */
  public convenience init(firstField: FormField, secondField: FormField) {
    self.init(with: [firstField, secondField])
  }
}
