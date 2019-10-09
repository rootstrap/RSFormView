//
//  BasicFormViewModel.swift
//  RSFormView-RSFormView
//
//  Created by Anthony on 10/9/19.
//

import Foundation

public class BasicFormViewModel: FormViewModel {
    public var items: [FormItem] = []
    
    public init(items: [FormItem] = []) {
        self.items = items
    }
}

