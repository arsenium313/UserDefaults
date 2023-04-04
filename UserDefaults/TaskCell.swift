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
    
    let inputTextView = UITextView()
    private let activitySwitch = UISwitch()
    
    var inputText: String = "" {
        willSet { inputTextView.text = newValue }
    }
    
    var switchIsOn: Bool = true {
        willSet { activitySwitch.isOn = newValue }
    }
    
    var indexTag: Int = 0 {
        willSet {
            inputTextView.tag = newValue
            activitySwitch.tag = newValue
        }
    }
    
    var switchDelegate: SwitchDelegate! = nil
    
    private lazy var guide = self.contentView.layoutMarginsGuide
    
    
    //MARK: - SetupUI
    func configureSelf() {
        self.selectionStyle = .none
    
        configureActivitySwitch()
        configureInputTextField()
    }
    
    private func configureInputTextField() {
        self.contentView.addSubview(inputTextView)
        inputTextView.translatesAutoresizingMaskIntoConstraints = false
        inputTextView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        inputTextView.font = UIFont.systemFont(ofSize: 20)
        inputTextView.addDoneButton(title: "Done", target: self, selector: #selector(dismissKeyboard))
        inputTextView.isSelectable = false
        
        NSLayoutConstraint.activate([
            inputTextView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            inputTextView.topAnchor.constraint(equalTo: guide.topAnchor),
            inputTextView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            inputTextView.trailingAnchor.constraint(equalTo: activitySwitch.leadingAnchor, constant: -10)
        ])
    }

    private func configureActivitySwitch() {
        self.contentView.addSubview(activitySwitch)
        activitySwitch.translatesAutoresizingMaskIntoConstraints = false
        activitySwitch.isOn = true
        activitySwitch.addTarget(self, action: #selector(changeTaskActivityStatus), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            activitySwitch.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            activitySwitch.centerYAnchor.constraint(equalTo: guide.centerYAnchor)
        ])
        
    }
    
    
    //MARK: - @objc
    @objc
    private func dismissKeyboard() {
        inputTextView.resignFirstResponder()
    }
    
    @objc
    private func changeTaskActivityStatus() {
        activitySwitch.isOn ? (self.contentView.alpha = 1) : (self.contentView.alpha = 0.3)
        switchDelegate.switchValueChange(activitySwitch)
    }
}

