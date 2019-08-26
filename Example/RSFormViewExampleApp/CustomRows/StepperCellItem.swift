//
//  StepperCellItem.swift
//  RSFormViewExampleApp
//
//  Created by Mauricio Cousillas on 6/20/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import Foundation
import RSFormView

final class StepperCellItem: FormItem {

  override public var cellIdentifier: String {
    return StepperCell.reuseIdentifier
  }

  convenience init(with field: FormField) {
    self.init(with: [field])
  }
}
