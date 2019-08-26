//
//  SwitchCell.swift
//  RSFormView
//
//  Created by Germán Stábile on 8/22/19.
//

import UIKit

class SwitchCell: FormTableViewCell {
  
  public static let reuseIdentifier = "SwitchCellIdentifier"
  
  lazy var switchControl: UISwitch = {
    let switchControl = UISwitch(frame: .zero)
    switchControl.translatesAutoresizingMaskIntoConstraints = false
    
    return switchControl
  }()
  
  lazy var titleLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    
    return label
  }()
  
  var configurator = FormConfigurator()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    configureViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    configureViews()
  }
  
  override public func update(with formItem: FormItem, and formConfigurator: FormConfigurator) {
    guard
      let formItem = formItem as? SwitchItem,
      let switchField = formItem.switchField
    else { return }
    
    titleLabel.attributedText = switchField.attributedTitle
    switchControl.isOn = switchField.isOn
    switchControl.tintColor = switchField.switchtintColor
    switchControl.thumbTintColor = switchField.switchThumbColor
    switchControl.backgroundColor = switchField.switchBackgroundColor
  }
  
  func configureViews() {
    backgroundColor = configurator.cellsBackgroundColor
    selectionStyle = .none
    
    addSubview(switchControl)
    addSubview(titleLabel)
    
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
      titleLabel.trailingAnchor.constraint(equalTo: switchControl.leadingAnchor, constant: 10),
      
      switchControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      switchControl.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
      switchControl.widthAnchor.constraint(equalToConstant: switchControl.intrinsicContentSize.width),
      switchControl.heightAnchor.constraint(equalToConstant: switchControl.intrinsicContentSize.height)
      ])
  }
}
