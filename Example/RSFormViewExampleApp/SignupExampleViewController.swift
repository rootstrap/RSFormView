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

    configureButton()
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
  func didUpdateFields(in formView: FormView,
                       allFieldsValid: Bool) {
    updateButton(enabled: allFieldsValid)
  }
}

