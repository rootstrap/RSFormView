//
//  FormTableView.swift
//  RSFormView
//
//  Created by Germán Stábile on 1/25/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import Foundation
import UIKit

public protocol FormViewDelegate: class {
  func didUpdateFields(in formView: FormView, allFieldsValid: Bool)
}

@IBDesignable public class FormView: UIView {
    
  @IBOutlet weak var formTableView: UITableView!
  
  public weak var delegate: FormViewDelegate?

  public var viewModel: FormViewModel? {
    didSet {
      viewModel?.customCellSetup?(formTableView)
      reloadVisibleCells()
    }
  }

  public var formConfigurator = FormConfigurator() {
    didSet {
      backgroundColor = formConfigurator.formBackgroundColor
      formTableView.backgroundColor = formConfigurator.formBackgroundColor
      formTableView.isScrollEnabled = formConfigurator.isScrollEnabled
      formTableView.reloadData()
    }
  }
  
  public init(with viewModel: FormViewModel) {
    super.init(frame: CGRect.zero)
    self.viewModel = viewModel
    configureViews()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configureViews()
  }
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
    configureViews()
  }
  
  public override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    configureViews()
  }
  
  /// Updates the error state for every visible FormItems
  public func reloadVisibleCells() {
    for cell in formTableView.visibleCells {
      if let cell = cell as? FormTableViewCell {
        cell.updateErrorState()
      }
    }
  }
  
  /**
   Marks the field with name equal to *fieldName* as invalid with *error* as error message
   
   - Parameters:
      - fieldName: The name of the field to mark as invalid
      - error: The error message to display for the invalid item
  */
  public func markItemInvalid(fieldName: String, error: String) {
    viewModel?.markItemInvalid(fieldName: fieldName, error: error)
    reloadVisibleCells()
  }
}

extension FormView: FormCellDelegate {
  public func didUpdate(data: FormField) {
    checkMatches(updatedField: data)
    reloadVisibleCells()
    delegate?.didUpdateFields(in: self,
                              allFieldsValid: viewModel?.validateFields() ?? false)
  }
}

extension FormView: UITableViewDelegate, UITableViewDataSource {
  public func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return viewModel?.items.count ?? 0
  }
  
  public func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let formItem = viewModel?.items[indexPath.row]

    let reuseId = formItem?.cellIdentifier ?? FormTextCell.reuseIdentifier

    let cell = tableView.dequeueReusableCell(withIdentifier: reuseId,
                                             for: indexPath)

    guard
      let formCell = cell as? FormTableViewCell,
      let item = formItem
    else {
      return cell
    }

    formCell.delegate = self
    formCell.update(with: item, and: formConfigurator)
    return formCell
  }
}
