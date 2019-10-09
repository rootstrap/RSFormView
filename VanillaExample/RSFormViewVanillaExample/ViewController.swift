//
//  ViewController.swift
//  RSFormViewTester
//
//  Created by Anthony on 10/9/19.
//  Copyright © 2019 Anthony. All rights reserved.
//

import UIKit
import RSFormView

class YourViewController: UIViewController, FormViewDelegate {
  @IBOutlet weak var formView: FormView!
  
  func didUpdateFields(in formView: FormView, allFieldsValid: Bool){
      // TODO
      // Show a visual hint if the form is valid
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    formView.delegate = self
    
    let birthdateField = FormField(name: "Birthdate field",
                                   initialValue: "",
                                   placeholder: "DOB",
                                   fieldType: .date,
                                   isValid: false,
                                   errorMessage: "Please enter a birthdate")
  
    formView.viewModel = BasicFormViewModel(items: [TextFieldCellItem(with: birthdateField)])
  }
}

