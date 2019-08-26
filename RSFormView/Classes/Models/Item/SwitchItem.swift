//
//  SwitchFormItem.swift
//  RSFormView
//
//  Created by Germán Stábile on 8/22/19.
//

import Foundation

public final class SwitchItem: FormItem {
  override public var cellIdentifier: String {
    return SwitchCell.reuseIdentifier
  }
  
  public var switchField: SwitchField?
  
  public convenience init(switchField: SwitchField) {
    self.init(with: [])
    self.switchField = switchField
  }
}
