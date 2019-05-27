//
//  ViewExtension.swift
//  RSFormView
//
//  Created by Germán Stábile on 4/30/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  func addNibView(inBundle bundle: Bundle? = nil) -> UIView {
    let name = String(describing: type(of: self))
    let selfNib = UINib(nibName: name, bundle: bundle)
    guard let view = selfNib.instantiate(withOwner: self, options: nil).first
      as? UIView else { return UIView() }
    
    view.frame = bounds
    view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    addSubview(view)
    return view
  }
  
  func addBorder(color: UIColor = UIColor.black, weight: CGFloat = 1.0, backgroundColor: UIColor = UIColor.white) {
    layer.borderColor = color.cgColor
    layer.borderWidth = weight
    layer.backgroundColor = backgroundColor.cgColor
  }
  
  func setRoundBorders(_ cornerRadius: CGFloat = 10.0) {
    clipsToBounds = true
    layer.cornerRadius = cornerRadius
  }
}
