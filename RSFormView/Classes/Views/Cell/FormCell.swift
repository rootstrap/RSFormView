//
//  FormCell.swift
//  RSFormView
//
//  Created by Mauricio Cousillas on 6/19/19.
//

import UIKit

/**
  Protocol used to notify changes from the cell to the FormView,
  use this to update the formViewModel. Otherwise your data will
  end out of sync.
*/
public protocol FormCellDelegate: class {
  func didUpdate(data: FormField)
}

/**
  Base class for every cell that will be displayed on the FormView.
  To create new types of cells, you need to inherit from this class,
  and override the update method
 */
open class FormTableViewCell: UITableViewCell {
  open weak var delegate: FormCellDelegate?

  open var formItem: FormItem?

  /// Called every time the cell is rendered
  open func update(with formItem: FormItem, and formConfigurator: FormConfigurator) {
    assert(true, "Override this method to set up your cell")
  }

  /// Called when the cell needs to update to it's error state.
  open func updateErrorState() { }
}
