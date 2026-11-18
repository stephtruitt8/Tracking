//
//  TaskModels.swift
//  Tracking
//
//  Created by Stephen Truitt on 11/9/26.
//

import Foundation

struct TaskItem: Identifiable, Hashable, Codable{
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
}

struct TaskGroup: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var symbolName: String
    var task: [TaskItem]
}

// MOCK- DATA / fake data for Testing
extension TaskGroup {
    static let sampleData: [TaskGroup] = [
        TaskGroup(title: "School", symbolName: "book.fill", task: [
            TaskItem(title: "Submit Assignments"),
            TaskItem(title: "Prepare lecture", isCompleted: true)
        ]),
        TaskGroup(title: "Home", symbolName: "house.fill", task: [
            TaskItem(title: "Buy Groceries", isCompleted: true),
        TaskItem(title: "Clean the Room"),
        ]),
        TaskGroup(title: "Kingdom Hearts", symbolName: "house.fill", task: [
            TaskItem(title: "Get Hearts", isCompleted: true),
        TaskItem(title: "Find the Light"),
        ])
    ]
}
