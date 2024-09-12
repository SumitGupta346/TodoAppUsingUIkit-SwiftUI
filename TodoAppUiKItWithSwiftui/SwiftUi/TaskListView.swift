//
//  TaskListView.swift
//  TodoAppUiKItWithSwiftui
//
//  Created by Sumit on 12/09/24.
//

import SwiftUI


struct TaskListView: View {
    @StateObject private var viewModel = TaskListViewModel()
    @State private var showEditTaskView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tasks) { task in
                    HStack {
                        Text(task.title)
                        Spacer()
                        Button(action: {
                            viewModel.toggleTaskCompletion(task: task)
                        }) {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.isCompleted ? .blue : .gray)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .contentShape(Rectangle()) // Makes the entire HStack tappable
                    .onTapGesture {
                        viewModel.selectTask(forEditing: task)
                        showEditTaskView = true
                    }
                }
                .onDelete(perform: viewModel.deleteTask)
                .onMove(perform: viewModel.moveTask)
            }
            .navigationTitle("Tasks")
            .toolbar {
                EditButton()
            }
            .sheet(item: $viewModel.selectedTask) { task in
                if let index = viewModel.tasks.firstIndex(where: { $0.id == task.id }) {
                    EditTaskView(task: $viewModel.tasks[index])
                } else {
                    Text("Task not found")
                }
            }
            .onAppear {
                viewModel.loadTasks()
            }
            .onChange(of: viewModel.tasks) { _ in
                viewModel.saveTasks()
            }
        }
    }
}
