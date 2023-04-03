//
//  UITextView ext.swift
//  UserDefaults
//
//  Created by Арсений Кухарев on 03.04.2023.
//

import UIKit

extension UITextView {
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        
        let flexibleWidth = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButtonItem = UIBarButtonItem(title: title, style: .done, target: target, action: selector)
        
        toolBar.items = [flexibleWidth, doneButtonItem]
        self.inputAccessoryView = toolBar
    }
    
}
