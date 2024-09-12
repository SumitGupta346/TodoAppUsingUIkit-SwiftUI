//
//  EditTaskView.swift
//  TodoAppUiKItWithSwiftui
//
//  Created by Sumit on 12/09/24.
//


import SwiftUI

struct EditTaskView: View {
    @Binding var task: Task

    @Environment(\.presentationMode) var presentationMode

    // Computed properties for optional description
    private var descriptionBinding: Binding<String> {
        Binding<String>(
            get: {
                task.description ?? ""
            },
            set: { newValue in
                task.description = newValue.isEmpty ? nil : newValue
            }
        )
    }

    // Computed properties for optional date
    private var dueDateBinding: Binding<Date> {
        Binding<Date>(
            get: {
                task.dueDate ?? Date() // Provide a default date if nil
            },
            set: { newDate in
                task.dueDate = newDate
            }
        )
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Title", text: $task.title)
                    TextField("Description", text: descriptionBinding)
                }

                Section(header: Text("Due Date")) {
                    DatePicker("Due Date", selection: dueDateBinding, displayedComponents: .date)
                }

                Section {
                    Toggle(isOn: $task.isCompleted) {
                        Text("Completed")
                    }
                }
            }
            .navigationTitle("Edit Task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

