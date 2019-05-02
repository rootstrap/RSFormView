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
    updateButton(enabled: false)
  }
  
  func updateButton(enabled: Bool) {
    getDataButton.backgroundColor = enabled ? UIColor.green : UIColor.gray
    getDataButton.isEnabled = enabled
  }
  
  @IBAction func getDataButtonTapped() {
    
  }
}

extension SignupExampleViewController: FormViewDelegate {
  func didUpdateFields(allFieldsValid: Bool) {
    updateButton(enabled: allFieldsValid)
  }
}

