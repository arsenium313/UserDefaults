//
//  TaskTableVC.swift
//  UserDefaults
//
//  Created by Арсений Кухарев on 03.04.2023.
//

import UIKit

class TaskTableVC: UITableViewController {

    //MARK: Properties
    private var tasks: [Task] = []
    
    private var taskCounter: [Int] = [] {
        willSet {
            navigationItem.title = "Задачи - \(newValue.count)"
        }
    }
    
    //MARK: - View Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        configureNavigationItem()
    }

    
    //MARK: - SetupUI
    private func configureNavigationItem() {
        navigationItem.title = "Задачи - \(tasks.count)"
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTasks))
        let addTaskButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        navigationItem.rightBarButtonItems = [saveButton, addTaskButton]
    }
    
    
    //MARK: - @objc
    @objc
    private func addTask() {
        let task = Task(task: "", isOn: true)
        taskCounter.append(0)
        tableView.reloadData()
    }
    
    @objc
    private func saveTasks() {
        print("saved!")
    }
    
    // MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskCounter.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as! TaskCell
        cell.configureSelf()
        cell.inputTextField.delegate = self
        return cell
    }
    
    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, sourceView, succes in
            self.taskCounter.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        
        let swipe = UISwipeActionsConfiguration(actions: [deleteAction])
        swipe.performsFirstActionWithFullSwipe = true
        return swipe
    }
    
}

extension TaskTableVC: UITextViewDelegate {
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        guard !textView.text.isEmpty else { return true }
        let trimmedText = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return true }
        
        let task = Task(task: trimmedText, isOn: true)
        self.tasks.append(task)
        print(tasks.count)
        return true
    }
    
}
