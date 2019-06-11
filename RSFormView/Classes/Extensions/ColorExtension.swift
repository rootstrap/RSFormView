//
//  ColorExtension.swift
//  RSFormView
//
//  Created by Germán Stábile on 5/9/19.
//

import Foundation

extension UIColor {
  public static let astralBlue = formColor(red: 46, green: 120, blue: 170)
  public static let blizzardBlue = formColor(red: 169, green: 211, blue: 239)
  public static let brightGray = formColor(red: 54, green: 61, blue: 79)
  public static let mineShaftGray = formColor(red: 33, green: 33, blue: 33)
  public static let tundoraGray = formColor(red: 66, green: 66, blue: 66)
  public static let heliotropePurple = formColor(red: 187, green: 134, blue: 252)
  public static let razzmatazzRed = formColor(red: 206, green: 6, blue: 112)
  
  public static func formColor(red: Int, green: Int, blue: Int) -> UIColor {
    return UIColor.init(red: min(CGFloat(red), 255.0) / 255.0,
                        green: min(CGFloat(green), 255.0) / 255.0,
                        blue: min(CGFloat(blue), 255.0) / 255.0,
                        alpha: 1.0)
  }
}
