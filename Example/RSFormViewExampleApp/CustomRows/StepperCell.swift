//
//  StepperRow.swift
//  RSFormViewExampleApp
//
//  Created by Mauricio Cousillas on 6/20/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import UIKit
import RSFormView

class StepperCell: FormTableViewCell {
  static let reuseIdentifier = "StepperCell"

  private let margin: CGFloat = 24
  private let spacing: CGFloat = 8
  let titleLabel = UILabel()
  let valueLabel = UILabel()
  let stepper = UIStepper()
  let inputContainerView = UIView()

  var field: FormField?

  var configurator: FormConfigurator?

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupViews()
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }

  override func draw(_ rect: CGRect) {
    super.draw(rect)
    let path = UIBezierPath(rect: CGRect(x: margin,
                                         y: rect.height - margin / 2,
                                         width: rect.width - margin * 2,
                                         height: 1))
    (configurator?.validLineColor ?? .lightGray).setFill()
    path.fill()
  }

  override func update(with formItem: FormItem, and formConfigurator: FormConfigurator) {
    guard let field = formItem.formFields.first else { return }

    self.field = field
    self.configurator = formConfigurator

    stepper.value = Double(field.value) ?? 0
    titleLabel.text = field.name
    valueLabel.text = field.value

    updateViewStyles(with: formConfigurator)
  }

  private func setupViews() {
    selectionStyle = .none

    inputContainerView.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false

    let constraints = [
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing),
      titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: margin),
      titleLabel.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: -spacing),
      inputContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin),
      inputContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      inputContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
    ]

    contentView.addSubview(titleLabel)
    contentView.addSubview(inputContainerView)
    NSLayoutConstraint.activate(constraints)
    setUpInputContainerView()
  }

  private func setUpInputContainerView() {
    valueLabel.translatesAutoresizingMaskIntoConstraints = false
    stepper.translatesAutoresizingMaskIntoConstraints = false


    let constraints = [
      valueLabel.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: margin),
      stepper.topAnchor.constraint(equalTo: inputContainerView.topAnchor),
      stepper.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor),
      valueLabel.rightAnchor.constraint(equalTo: stepper.leftAnchor),
      valueLabel.centerYAnchor.constraint(equalTo: stepper.centerYAnchor),
      stepper.rightAnchor.constraint(equalTo: inputContainerView.rightAnchor, constant: -margin)
    ]

    inputContainerView.addSubview(valueLabel)
    inputContainerView.addSubview(stepper)
    stepper.addTarget(self, action: #selector(stepperChanged(_:)), for: .valueChanged)

    NSLayoutConstraint.activate(constraints)
  }

  private func updateViewStyles(with configurator: FormConfigurator) {
    valueLabel.textColor = configurator.validTitleColor
    valueLabel.font = configurator.textFont
    titleLabel.font = configurator.titleFont
    titleLabel.textColor = configurator.validTitleColor
    stepper.tintColor = configurator.validTitleColor
    backgroundColor = configurator.cellsBackgroundColor
  }

  @objc func stepperChanged(_ sender: UIStepper) {
    guard let field = field else { return }
    field.value = "\(sender.value)"
    valueLabel.text = field.value
    delegate?.didUpdate(data: field)
  }
}
