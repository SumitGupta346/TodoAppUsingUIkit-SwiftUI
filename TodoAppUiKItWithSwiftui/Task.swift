//
//  Task.swift
//  TodoAppUiKItWithSwiftui
//
//  Created by Sumit on 12/09/24.
//

import Foundation

struct Task: Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String
    var description: String?
    var isCompleted: Bool
    var dueDate: Date?
}
