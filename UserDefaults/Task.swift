//
//  Task.swift
//  UserDefaults
//
//  Created by Арсений Кухарев on 03.04.2023.
//

import Foundation

class Task: Codable {
    var task: String
    var id: String
    var isOn: Bool
    
    init(task: String, isOn: Bool) {
        self.task = task
        self.id = UUID().uuidString
        self.isOn = isOn
    }
}

extension Task {
    
    static let userDefaultsKey = "udKey"
    
    static func save(_ tasks: [Task]) {
        let data = try? JSONEncoder().encode(tasks)
        UserDefaults.standard.set(data, forKey: Task.userDefaultsKey)
    }
    
    static func loadTask() -> [Task] {
        var tasksToReturn: [Task] = []
        
        if let data = UserDefaults.standard.data(forKey: Task.userDefaultsKey),
           let tasks =  try? JSONDecoder().decode([Task].self, from: data) {
            tasksToReturn = tasks
        }
        return tasksToReturn
    }

}

