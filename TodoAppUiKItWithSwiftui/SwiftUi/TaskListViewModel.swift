//
//  TaskListViewModel.swift
//  TodoAppUiKItWithSwiftui
//
//  Created by Sumit on 12/09/24.
//


import Combine
import Foundation

class TaskListViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var selectedTask: Task?

    private var dataManager = DataManager.shared

    init() {
        loadTasks()
    }

    func loadTasks() {
        tasks = dataManager.loadTasks()
    }

    func toggleTaskCompletion(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
            saveTasks()
        }
    }

    func saveTasks() {
        dataManager.saveTasks(tasks)
    }


    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        saveTasks()
    }

    func moveTask(from source: IndexSet, to destination: Int) {
        tasks.move(fromOffsets: source, toOffset: destination)
        saveTasks()
    }

    func selectTask(forEditing task: Task) {
        selectedTask = task
    }
}
