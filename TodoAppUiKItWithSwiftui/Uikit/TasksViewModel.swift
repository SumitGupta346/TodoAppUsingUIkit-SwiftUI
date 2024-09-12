//
//  TasksViewModel.swift
//  TodoAppUiKItWithSwiftui
//
//  Created by Sumit on 13/09/24.
//

import Foundation

class TasksViewModel {
    var tasks: [Task] = [] {
        didSet {
            saveTasks()
        }
    }

    private let dataManager = DataManager.shared

    func loadTasks() {
        tasks = dataManager.loadTasks()
    }

    func saveTasks() {
        dataManager.saveTasks(tasks)
    }

    func addTask(_ task: Task) {
        tasks.append(task)
        saveTasks()
    }

    func deleteTask(at index: Int) {
        tasks.remove(at: index)
        saveTasks()
    }

    func toggleTaskCompletion(at index: Int) {
        tasks[index].isCompleted.toggle()
        saveTasks()
    }
}

