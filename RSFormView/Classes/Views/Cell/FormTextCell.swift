//
//  FormTextCell.swift
//  RSFormView
//
//  Created by Germán Stábile on 3/12/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import Foundation
import UIKit

public class FormTextCell: FormTableViewCell {
  
  public static let reuseIdentifier = "FormTextCellIdentifier"
  @IBOutlet public weak var formTextLabel: UILabel!
  @IBOutlet public weak var headerLabelTopMarginConstraint: NSLayoutConstraint!
  @IBOutlet public weak var headerLabelBottomMarginConstraint: NSLayoutConstraint!
  
  override public func update(with formItem: FormItem, and formConfigurator: FormConfigurator) {
    self.formItem = formItem
    
    contentView.backgroundColor = formConfigurator.cellsBackgroundColor
    headerLabelTopMarginConstraint.constant = formItem.contraintsConfigurator.headerLabelTopMargin
    headerLabelBottomMarginConstraint.constant = formItem.contraintsConfigurator.headerLabelBottomMargin
    formTextLabel.attributedText = formItem.attributedText
  }
}
