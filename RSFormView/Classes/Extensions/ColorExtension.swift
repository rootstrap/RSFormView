//
//  ColorExtension.swift
//  RSFormView
//
//  Created by Germán Stábile on 5/9/19.
//

import Foundation

extension UIColor {
  public static let brightGray = formColor(red: 54, green: 61, blue: 79)
  public static let mineShaftGray = formColor(red: 33, green: 33, blue: 33)
  public static let tundoraGray = formColor(red: 66, green: 66, blue: 66)
  public static let dodgerBlue = formColor(red: 53, green: 170, blue: 255)
  public static let bitterSweetRed = formColor(red: 255, green: 98, blue: 98)
  
  public static func formColor(red: Int, green: Int, blue: Int) -> UIColor {
    return UIColor.init(red: min(CGFloat(red), 255.0) / 255.0,
                        green: min(CGFloat(green), 255.0) / 255.0,
                        blue: min(CGFloat(blue), 255.0) / 255.0,
                        alpha: 1.0)
  }
}
