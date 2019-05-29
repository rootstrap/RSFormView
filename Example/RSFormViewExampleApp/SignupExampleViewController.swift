//
//  ViewController.swift
//  RSFormViewExampleApp
//
//  Created by Germán Stábile on 4/30/19.
//  Copyright © 2019 Rootstrap. All rights reserved.
//

import UIKit
import RSFormView

class SignupExampleViewController: UIViewController {
  
  @IBOutlet weak var formView: FormView!
  @IBOutlet weak var getDataButton: UIButton!
  
  var viewModel = SignupExampleViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    formView.viewModel = viewModel
    formView.delegate = self
    
    let configurator = FormConfigurator()
    configureFormColors(formConfigurator: configurator)

    formView.formConfigurator = configurator
    configureButton()
  }
  
  func configureFormColors(formConfigurator: FormConfigurator) {
    
    let darkPurple = UIColor.formColor(red: 140, green: 20, blue: 252)
    
    formConfigurator.editingTitleColor = darkPurple
    formConfigurator.editingBorderColor = darkPurple
    formConfigurator.formBackgroundColor = UIColor.white
    formConfigurator.fieldsBackgroundColor = UIColor.white
    
    formConfigurator.errorTextColor = UIColor.orange
    formConfigurator.invalidTitleColor = UIColor.orange
    formConfigurator.invalidBorderColor = UIColor.orange
    
    formConfigurator.placeholderTextColor = UIColor.gray
    formConfigurator.validTitleColor = UIColor.gray
    formConfigurator.validBorderColor = UIColor.gray
    
    //set lineColor to clear so it is not visible
    formConfigurator.editingLineColor = UIColor.clear
    formConfigurator.invalidLineColor = UIColor.clear
    formConfigurator.validLineColor = UIColor.clear
    
    formConfigurator.borderCornerRadius = 20
    formConfigurator.borderWidth = 2
  }
  
  
  func configureButton() {
    getDataButton.clipsToBounds = true
    getDataButton.layer.cornerRadius = 8
    updateButton(enabled: false)
  }
  
  func updateButton(enabled: Bool) {
    getDataButton.backgroundColor = enabled ?
      UIColor.astralBlue : UIColor.brightGray.withAlphaComponent(0.4)
    getDataButton.isEnabled = enabled
  }
  
  @IBAction func getDataButtonTapped() {
    let alert = UIAlertController(title: "Collected data",
                                  message: viewModel.collectedData,
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
    
    present(alert, animated: true)
  }
}

extension SignupExampleViewController: FormViewDelegate {
  func didUpdateFields(allFieldsValid: Bool) {
    updateButton(enabled: allFieldsValid)
  }
}

