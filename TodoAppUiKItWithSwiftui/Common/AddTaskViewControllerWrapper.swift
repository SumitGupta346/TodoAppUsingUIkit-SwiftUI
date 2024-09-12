//
//  AddTaskViewControllerWrapper.swift
//  TodoAppUiKItWithSwiftui
//
//  Created by Sumit on 12/09/24.
//

import SwiftUI
import UIKit

struct AddTaskViewControllerWrapper: UIViewControllerRepresentable {
    @Binding var tasks: [Task]
    var onSave: (Task) -> Void

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = AddTaskViewController()
        viewController.onSave = { task in
            onSave(task)
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
