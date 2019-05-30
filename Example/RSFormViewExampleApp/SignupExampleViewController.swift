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

    configureFormColors()
    configureButton()
  }
  
  func configureFormColors() {
    let configurator = FormConfigurator()
    let darkPurple = UIColor.formColor(red: 140, green: 20, blue: 252)
    
    configurator.editingTitleColor = UIColor.astralBlue
    configurator.editingBorderColor = UIColor.astralBlue
    configurator.formBackgroundColor = UIColor.white
    configurator.fieldsBackgroundColor = UIColor.white
    
    configurator.errorTextColor = UIColor.red
    configurator.invalidTitleColor = UIColor.red
    configurator.invalidBorderColor = UIColor.red
    
    configurator.placeholderTextColor = UIColor.gray
    configurator.validTitleColor = UIColor.gray
    configurator.validBorderColor = UIColor.gray
    
    //set lineColor to clear so it is not visible
    configurator.editingLineColor = UIColor.clear
    configurator.invalidLineColor = UIColor.clear
    configurator.validLineColor = UIColor.clear
    
    configurator.borderCornerRadius = 8
    configurator.borderWidth = 1
    
    formView.formConfigurator = configurator
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

