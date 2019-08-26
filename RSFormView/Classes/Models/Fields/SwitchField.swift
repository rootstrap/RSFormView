//
//  SwitchField.swift
//  RSFormView
//
//  Created by Germán Stábile on 8/22/19.
//

import Foundation
import UIKit

open class SwitchField {
  
  public var isOn: Bool
  public var attributedTitle: NSAttributedString
  public var name: String
  public var switchtintColor: UIColor = UIColor.dodgerBlue
  public var switchThumbColor: UIColor = UIColor.white
  public var switchBackgroundColor: UIColor = UIColor.white
  
  public init(isOn: Bool, attributedTitle: NSAttributedString, name: String) {
    self.name = name
    self.isOn = isOn
    self.attributedTitle = attributedTitle
  }
}
