//
//  FormConfiguratior.swift
//  RSFormView
//
//  Created by Germán Stábile on 5/10/19.
//

import Foundation

public class FormConfigurator {
  
  //scrollable property
  public var isScrollEnabled = true
  
  //backgroud colors
  public var formBackgroundColor = UIColor.white
  public var fieldsBackgroundColor = UIColor.clear
  public var cellsBackgroundColor = UIColor.white
  
  //title colors
  public var validTitleColor = UIColor.darkGray
  public var invalidTitleColor = UIColor.bitterSweetRed
  public var editingTitleColor = UIColor.dodgerBlue
  
  //bottom line colors
  public var editingLineColor = UIColor.dodgerBlue
  public var invalidLineColor = UIColor.bitterSweetRed
  public var validLineColor = UIColor.lightGray
  
  //text colors
  public var placeholderTextColor = UIColor.brightGray
  public var textColor = UIColor.brightGray
  
  //border colors
  public var validBorderColor = UIColor.clear
  public var invalidBorderColor = UIColor.clear
  public var editingBorderColor = UIColor.clear
  
  //error text color
  public var errorTextColor = UIColor.bitterSweetRed
  
  public var borderCornerRadius: CGFloat = 8
  public var borderWidth: CGFloat = 1
  
  //fonts
  public var errorFont = UIFont.systemFont(ofSize: 13)
  public var titleFont = UIFont.boldSystemFont(ofSize: 12)
  public var placeholderFont = UIFont.systemFont(ofSize: 14)
  public var textFont = UIFont.systemFont(ofSize: 15)
  
  public var labelToTextFieldDistance: CGFloat = 8
  public var textFieldToBottomLineDistance: CGFloat = 5
  public var bottomLineToErrorLabelDistance: CGFloat = 5
  public var textFieldContainerToErrorLabelDistance: CGFloat = 5
  
  public init() {}
}

public class DarkModeConfigurator: FormConfigurator {
  override public init() {
    super.init()
    formBackgroundColor = UIColor.mineShaftGray
    fieldsBackgroundColor = UIColor.tundoraGray
    cellsBackgroundColor = UIColor.tundoraGray
    
    validLineColor = UIColor.white
    
    placeholderTextColor = UIColor.white
    textColor = UIColor.white
    
    validTitleColor = UIColor.white
  }
}
