//
//  FormConfiguratior.swift
//  RSFormView
//
//  Created by Germán Stábile on 5/10/19.
//

import Foundation

public class FormConfigurator {
  public var formBackgroundColor = UIColor.white
  public var fieldsBackgroundColor = UIColor.white
  
  public var validTitleColor = UIColor.darkGray
  public var invalidTitleColor = UIColor.red
  public var editingTitleColor = UIColor.astralBlue.withAlphaComponent(0.8)
  public var editingLineColor = UIColor.blizzardBlue
  public var invalidLineColor = UIColor.red
  public var validLineColor = UIColor.lightGray
  public var placeholderTextColor = UIColor.brightGray
  public var textColor = UIColor.brightGray
  public var errorTextColor = UIColor.red
  
  public var validBorderColor = UIColor.lightGray.cgColor
  public var invalidBorderColor = UIColor.red.cgColor
  public var editingBorderColor = UIColor.astralBlue.withAlphaComponent(0.8).cgColor
  public var invalidBorderWidth = CGFloat(2)
  public var validBorderWidth = CGFloat(1)
  public var editingBorderWidth = CGFloat(1)
  
  public var borderCornerRadius = CGFloat(8)
  public var borderWidth = CGFloat(1)
  
  public var errorFont = UIFont.systemFont(ofSize: 13)
  public var titleFont = UIFont.boldSystemFont(ofSize: 12)
  public var placeholderFont = UIFont.systemFont(ofSize: 14)
  public var textFont = UIFont.systemFont(ofSize: 15)
  
  public init() {}
}
