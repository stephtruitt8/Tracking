//
//  TaskGroupDetailView.swift
//  Tracking
//
//  Created by Stephen Truitt on 11/9/26.
//

import SwiftUI

struct TaskGroupDetailView: View {
    @Binding var group: TaskGroup
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        List {
            
            Section {
                if sizeClass == .regular {
                    GroupStatsView(task: group.task)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color(.secondarySystemBackground))
                }
                
            }
            
            ForEach($group.task) { $task in
                HStack {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    // if the task is complete
                    // show circle as checkmark
                    // else
                    // show circle as empty
                        .foregroundStyle(task.isCompleted ? .blue : .red)
                        .onTapGesture {
                            withAnimation {
                                task.isCompleted.toggle()
                            }
                        }
                    TextField("Task title", text: $task.title)
                        .strikethrough(task.isCompleted)
                        .foregroundStyle(task.isCompleted ? .gray : .black)
                }
            }
            .onDelete { index in
                group.task.remove(atOffsets: index)
            }
        }
        .navigationTitle(group.title)
        .toolbar {
            Button("Add Task") {
                withAnimation {
                    group.task.append(TaskItem(title: ""))
                }
            }
        }
    }
}
