//
//  TaskTableVC.swift
//  UserDefaults
//
//  Created by Арсений Кухарев on 03.04.2023.
//

import UIKit

class TaskTableVC: UITableViewController {

    //MARK: Properties
    private var tasks: [Int] = Array(repeating: 1, count: 3) {
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
        let addTaskButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        navigationItem.rightBarButtonItem = addTaskButton
    }
    
    
    //MARK: - @objc
    @objc
    private func addTask() {
        tasks.append(1)
        tableView.reloadData()
    }
    
    
    // MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as! TaskCell
        cell.configureSelf()
        return cell
    }
    
    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, sourceView, succes in
            self.tasks.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        
        let swipe = UISwipeActionsConfiguration(actions: [deleteAction])
        swipe.performsFirstActionWithFullSwipe = true
        return swipe
    }
    
}
