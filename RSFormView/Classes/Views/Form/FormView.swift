//
//  FormTableView.swift
//  RSFormView
//
//  Created by Germán Stábile on 1/25/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

public protocol FormViewDelegate: class {
  func didUpdateFields(allFieldsValid: Bool)
}

@IBDesignable public class FormView: UIView {
    
  @IBOutlet weak var formTableView: UITableView!
  
  public weak var delegate: FormViewDelegate?
  public var viewModel: FormViewModel?
  public var formConfigurator = FormConfigurator() {
    didSet {
      backgroundColor = formConfigurator.formBackgroundColor
      formTableView.backgroundColor = formConfigurator.formBackgroundColor
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
  
  public func reloadVisibleCells() {
    for cell in formTableView.visibleCells {
      if let cell = cell as? FormViewCell {
        cell.updateErrorState()
      }
    }
  }
  
  public func markItemInvalid(fieldName: String, error: String) {
    viewModel?.markItemInvalid(fieldName: fieldName, error: error)
    reloadVisibleCells()
  }
  
  fileprivate func configureViews() {
    IQKeyboardManager.shared.enable = true
    _ = addNibView(inBundle: Constants.formViewBundle)
    
    formTableView.delegate = self
    formTableView.dataSource = self
    
    let nib = UINib(nibName: "FormViewCell", bundle: Constants.formViewBundle)
    formTableView.register(nib,
                           forCellReuseIdentifier: TextFieldCell.reuseIdentifier)
    let twoTextFieldsNib = UINib(nibName: "TwoTextFieldsCell",
                                 bundle: Constants.formViewBundle)
    formTableView.register(twoTextFieldsNib,
                           forCellReuseIdentifier: TwoTextFieldsCell.reuseIdentifier)
    let textCellNib = UINib(nibName: "FormTextCell", bundle: Constants.formViewBundle)
    formTableView.register(textCellNib,
                           forCellReuseIdentifier: FormTextCell.reuseIdentifier)
  }
  
  fileprivate func checkMatches(updatedField: FormField) {
    guard let fields =
      viewModel?.fields() else { return }
    if let validationMatch = updatedField.validationMatch {
      if let matchField =
        fields.first(where: { $0.name == validationMatch }) {
        updatedField.isValid = matchField.value == updatedField.value
        return
      }
    }
    let validationMatches =
      fields.filter({ $0.validationMatch == updatedField.name })
    
    for validationMatch in validationMatches {
      validationMatch.isValid = validationMatch.value == updatedField.value
    }
  }
  
  fileprivate func update(field: FormField) {
    guard let items = viewModel?.items,
      !items.isEmpty else { return }
    
    for item in items {
      if let index =
        item.formFields.firstIndex(where: { $0.name == field.name }) {
        item.formFields[index] = field
        return
      }
    }
  }
  
  fileprivate func textFieldCell(forRowAt indexPath: IndexPath,
                                 in tableView: UITableView,
                                 with rowFields: [FormField]?) -> UITableViewCell {
    if rowFields?.count == 1,
      let fieldData = rowFields?.first,
      let cell = tableView
        .dequeueReusableCell(withIdentifier: TextFieldCell.reuseIdentifier,
                             for: indexPath) as? TextFieldCell {
      cell.update(withData: fieldData, formConfigurator: formConfigurator)
      cell.delegate = self
      return cell
    }
    
    let cell = tableView.dequeueReusableCell(withIdentifier: TwoTextFieldsCell.reuseIdentifier,
                                             for: indexPath)
    if let formItem = viewModel?.items[indexPath.row],
      formItem.formFields.count == 2,
      let cell = cell as? TwoTextFieldsCell {
      cell.delegate = self
      cell.update(withFormItem: formItem, formConfigurator: formConfigurator)
    }
    
    return cell
  }
}

extension FormView: FormCellDelegate {
  func didUpdate(data: FormField) {
    update(field: data)
    checkMatches(updatedField: data)
    reloadVisibleCells()
    delegate?.didUpdateFields(allFieldsValid: viewModel?.validateFields() ?? false)
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
    let rowFields = formItem?.formFields
    
    if let attributtedText = formItem?.attributedText,
      rowFields?.isEmpty ?? true,
      let cell = tableView
        .dequeueReusableCell(withIdentifier: FormTextCell.reuseIdentifier,
                             for: indexPath) as? FormTextCell {
      cell.update(withAttributedText: attributtedText, formConfigurator: formConfigurator)
      return cell
    }
    
    return textFieldCell(forRowAt: indexPath,
                         in: tableView,
                         with: rowFields)
  }
  
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) as? TextFieldCell {
      cell.focus()
    }
  }
}
