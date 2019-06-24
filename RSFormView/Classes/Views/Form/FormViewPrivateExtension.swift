//
//  FormViewPrivateExtension.swift
//  IQKeyboardManagerSwift
//
//  Created by Germán Stábile on 5/13/19.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

internal extension FormView {
  func configureViews() {
    IQKeyboardManager.shared.enable = true
    _ = addNibView(inBundle: Constants.formViewBundle)
    
    formTableView.delegate = self
    formTableView.dataSource = self
    viewModel?.customCellSetup?(formTableView)

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
  
  func checkMatches(updatedField: FormField) {
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
}
