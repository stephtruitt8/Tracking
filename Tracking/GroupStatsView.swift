//
//  GroupStatsView.swift
//  Tracking
//
//  Created by Stephen Truitt on 11/16/26.
//

import SwiftUI

struct GroupStatsView: View {
    var task: [TaskItem]
    var completedCount: Int {task.filter {$0.isCompleted}.count}
    var progress: Double { task.isEmpty ? 0 : Double(completedCount) / Double(task.count) }
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.3)
                    .foregroundColor(.cyan)
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .foregroundColor(.cyan)
                    .rotationEffect(.degrees(-90))
                Text("\(Int(progress * 100))%") // Interpolation
                    .font(.caption)
                    .bold()
            }
            .frame(width: 60, height: 60)
            .padding()
            
            VStack{
                Text("Task Progress")
                    .font(.headline)
                    .foregroundStyle(.brown)
                Text("\(completedCount) / \(task.count) Completed")
                    .font(.title2)
                    .bold()
            }
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
