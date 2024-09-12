//
//  TasksTableViewController.swift
//  TodoAppUiKItWithSwiftui
//
//  Created by Sumit on 12/09/24.
//

import UIKit

class TasksTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var viewModel = TasksViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "TaskTableViewCell")
        viewModel.loadTasks()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadTasks()
        tableView.reloadData()
    }
    
    @objc func addTask() {
        let addTaskVC = AddTaskViewController()
        let navController = UINavigationController(rootViewController: addTaskVC)
        addTaskVC.onSave = { [weak self] task in
            self?.viewModel.addTask(task)
            self?.tableView.reloadData()
        }
        present(navController, animated: true, completion: nil)
    }
    
    // UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        let task = viewModel.tasks[indexPath.row]
        
        cell.titleLabel.text = task.title
        
        // Create SF Symbol image based on the task state
        let systemImageName = task.isCompleted ? "checkmark.circle.fill" : "circle"
        let symbolImage = UIImage(systemName: systemImageName)
        
        // Configure the image view
        cell.accessoryImageView.image = symbolImage
        cell.accessoryImageView.tintColor = task.isCompleted ? .blue : .gray
        
        return cell
    }
    
    // UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteTask(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.toggleTaskCompletion(at: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Tasks" // This will appear as the header title at the top
    }
    
    // Increase the height for the header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50 // Increase height to avoid text truncation
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Assuming a single section for simplicity
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 28) // Customize font size
            header.textLabel?.textColor = .black // Customize text color
            header.textLabel?.textAlignment = .left // Align text to the left
        }
    }
}
