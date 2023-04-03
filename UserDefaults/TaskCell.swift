//
//  TaskCell.swift
//  UserDefaults
//
//  Created by Арсений Кухарев on 03.04.2023.
//

import UIKit

class TaskCell: UITableViewCell {
    
    //MARK: Properies
    static let identifier = "TaskCell"
    
    private let inputTextField = UITextView()
    private let activitySwitch = UISwitch()
    private let keyboardDissmisTapRecognizer = UITapGestureRecognizer()
    
    private lazy var guide = self.contentView.layoutMarginsGuide
    
    
    //MARK: - SetupUI
    func configureSelf() {
        configureActivitySwitch()
        configureInputTextField()
    }
    
    private func configureInputTextField() {
        self.contentView.addSubview(inputTextField)
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        inputTextField.addDoneButton(title: "Done", target: self, selector: #selector(dissmisKeyboard))
        
        NSLayoutConstraint.activate([
            inputTextField.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            inputTextField.topAnchor.constraint(equalTo: guide.topAnchor),
            inputTextField.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            inputTextField.trailingAnchor.constraint(equalTo: activitySwitch.leadingAnchor, constant: -10)
        ])
    }

    private func configureActivitySwitch() {
        self.contentView.addSubview(activitySwitch)
        activitySwitch.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            activitySwitch.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            activitySwitch.centerYAnchor.constraint(equalTo: guide.centerYAnchor)
        ])
    }
    
    
    //MARK: - @objc
    @objc
    private func dissmisKeyboard() {
        inputTextField.resignFirstResponder()
    }
}

