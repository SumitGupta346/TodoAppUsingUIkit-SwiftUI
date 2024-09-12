//
//  AddTaskViewController.swift
//  TodoAppUiKItWithSwiftui
//
//  Created by Sumit on 12/09/24.
//

import UIKit

class AddTaskViewController: UIViewController {
    // UI Elements

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var isCompletedSwitchLabel: UILabel!
    @IBOutlet weak var isCompletedSwitch: UISwitch!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var dueDataLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titletextField: UITextField!
    
    // Closure to pass data back
    var onSave: ((Task) -> Void)?
    
    // Task to edit (if available)
    var taskToEdit: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        configureViewIfEditing()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = taskToEdit == nil ? "Add Task" : "Edit Task"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
    }
    
    private func configureViewIfEditing() {
        if let task = taskToEdit {
            titletextField.text = task.title
            descTextView.text = task.description
            dueDatePicker.date = task.dueDate!
            isCompletedSwitch.isOn = task.isCompleted
        }
    }
    
    @IBAction func saveTaskButtonPressed(_ sender: UIButton) {
        saveTask()
    }
    
    @objc private func saveTask() {
        guard let title = titletextField.text, !title.isEmpty else {
            showAlert(message: "Title is required.")
            return
        }
        
        let description = descTextView.text
        let dueDate = dueDatePicker.date
        let isCompleted = isCompletedSwitch.isOn
        
        let task = Task(title: title, description: description, isCompleted: isCompleted, dueDate: dueDate)
        
        onSave?(task)
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
