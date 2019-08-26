//
//  TextCellItem.swift
//  RSFormView
//
//  Created by Mauricio Cousillas on 6/20/19.
//

import Foundation

/**
 Plain text row, no inputs.
 */
public final class TextCellItem: FormItem {
  override public var cellIdentifier: String {
    return FormTextCell.reuseIdentifier
  }

  public convenience init() {
    self.init(with: [])
  }
}
