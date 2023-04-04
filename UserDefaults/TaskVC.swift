//
//  TaskVC.swift
//  UserDefaults
//
//  Created by Арсений Кухарев on 03.04.2023.
//

import UIKit

class TaskVC: UIViewController {

    //MARK: Properties
    private let tableView = UITableView()
    private let textField = UITextField()
    
    private var tasks: [Task] = Task.loadTask()
    
    //MARK: - View Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setupUI()
    }
    
    //MARK: - SetupUI
    private func setupUI() {
        configureTextField()
        configureTableView()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "Задачи"
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTasks))
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTable))
        self.navigationItem.rightBarButtonItems = [saveButton, editButton]
    }
    
    private func configureTextField() {
        self.view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textField.font = UIFont.systemFont(ofSize: 30)
        textField.delegate = self
        textField.placeholder = "Введите задачу..."
        
        textField.layer.cornerRadius = 12
        textField.textAlignment = .left
        
        let guide = self.view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: guide.topAnchor),
            textField.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func configureTableView() {
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    //MARK: - @objc
    @objc
    private func saveTasks() {
        Task.save(tasks)
    }
    
    @objc
    private func editTable() {
        self.tableView.isEditing ? self.tableView.setEditing(false, animated: true) : self.tableView.setEditing(true, animated: true)
        let cell =  tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TaskCell
        
        self.tableView.isEditing ? (cell.inputTextField.isSelectable = true) : (cell.inputTextField.isSelectable = false)
        self.tableView.isEditing ? (cell.inputTextField.isEditable = true) : (cell.inputTextField.isEditable = false)
        print(cell.inputTextField.isSelectable)
        print(cell.inputTextField.isEditable)
        print("  ")
    }
    
}

//MARK: - TableView DataSource / Delegate
extension TaskVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as! TaskCell
        cell.configureSelf()
        cell.inputTextField.text = tasks[indexPath.row].task
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tasks.remove(at: indexPath.row)
        tableView.reloadData()
        saveTasks()
    }
    
}


//MARK: - TextField Delegate
extension TaskVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let task = Task(task: textField.text!, isOn: true)
        tasks.append(task)
        textField.text = nil
        textField.resignFirstResponder()
        tableView.reloadData()
        return true
    }
}
