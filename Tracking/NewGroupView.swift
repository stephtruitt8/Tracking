//
//  NewGroupView.swift
//  Tracking
//
//  Created by Stephen Truitt on 11/16/26.
//

import SwiftUI

struct NewGroupView: View {
    @State private var groupName = ""
    @State private var selectedIcon = ""
    @Environment(\.dismiss) var dismiss
    let icons = ["list.bullet", "bookmark.fill", "star.fill", "house.fill", "flag.fill"]
    var onSave: (TaskGroup) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                // SECTION 1: NAME of the group
                Section("Group Name"){
                    TextField("e.g, 'Work', 'Important', 'Budget'...", text: $groupName)
                }
                // SECTION 2: Icon Picker
                Section("Select Icon") {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]){
                        ForEach(icons, id: \.self) { icon in
                            Image(systemName: icon)
                                .font(.title2)
                                .frame(width: 40, height:40)
                                .background(selectedIcon == icon ? Color.purple.opacity(0.2) : Color.clear)
                                .foregroundStyle(selectedIcon == icon ? Color.purple : Color.gray)
                                .clipShape(Circle())
                                .onTapGesture {
                                    selectedIcon = icon
                                }
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("New Group")
            .toolbar {
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancel") {dismiss()}
                }
                ToolbarItem(placement: .confirmationAction){
                    Button("Save") {
                        let newGroup = TaskGroup(title: groupName, symbolName: selectedIcon, task: [])
                        onSave(newGroup)
                        dismiss()
                    }
                    .disabled(groupName.isEmpty)
                    
                }
            }
        }
    }
}
