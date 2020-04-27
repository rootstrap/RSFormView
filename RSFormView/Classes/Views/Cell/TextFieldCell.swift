//
//  FormViewCell.swift
//  RSFormView
//
//  Created by Germán Stábile on 1/25/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import Foundation
import UIKit

public class TextFieldCell: FormTableViewCell {
  
  public static let reuseIdentifier = "TextFieldCellIdentifier"
  
  @IBOutlet public weak var textFieldView: TextFieldView!
  @IBOutlet weak var textFieldViewTrailingConstraint: NSLayoutConstraint!

  let horizontalMargin: CGFloat = 7
    
  override public func awakeFromNib() {
    textFieldView.delegate = self
  }
    
  public override func layoutSubviews() {
    guard let fieldData = formItem?.formFields.first else {
      super.layoutSubviews()
      return
    }
    
    textFieldViewTrailingConstraint.constant =
      fieldData.isHalfField ? bounds.width / 2 : horizontalMargin
    super.layoutSubviews()
  }
  
  override public func update(with formItem: FormItem, and formConfigurator: FormConfigurator) {
    isAccessibilityElement = false
    self.formItem = formItem
    guard let fieldData = formItem.formFields.first else { return }
    
    contentView.backgroundColor = formConfigurator.cellsBackgroundColor
    textFieldView.update(withData: fieldData, formConfigurator: formConfigurator)
  }
  
  override public func updateErrorState() {
    textFieldView.updateErrorState()
  }
  
  public func focus() {
    textFieldView.textField.becomeFirstResponder()
  }
}

extension TextFieldCell: TextFieldDelegate {
  public func didUpdate(textFieldView: TextFieldView, with fieldData: FormField) {
    textFieldView.textField.text = fieldData.value
    delegate?.didUpdate(data: fieldData)
  }
}
