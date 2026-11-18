//
//  ContentView.swift
//  Tracking
//
//  Created by Stephen Truitt on 11/9/26.
//

import SwiftUI

struct ContentView: View {
    // Source of truth for testing the app
    @State private var taskGroups: [TaskGroup] = []
    // keep track of the selected group
    @State private var selectedGroup: TaskGroup?
    // iPad column visiblity
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var isShowingAddGroup = false
    @Environment(\.scenePhase) private var scenePhase
    let saveKey = "SavedTaskGroups"
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            // column 1:  Sidebar
            List(selection: $selectedGroup) {
                ForEach(taskGroups) { group in
                    NavigationLink(value: group) {
                        
                        Label(group.title, systemImage: group.symbolName)
                    }
                }
            }
            .navigationTitle("TrackingApp")
            .listStyle(.sidebar)
            .toolbar {
                Button {
                    isShowingAddGroup = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            
        } detail : {
            // Find the Index of the selected group and display the details of it.
            if let group = selectedGroup {
                if let index = taskGroups.firstIndex(where: { $0.id == group.id}) {
                    TaskGroupDetailView(group: $taskGroups[index])
                }
            } else {
                ContentUnavailableView("Select a Group", systemImage: "sidebar.left")
            }
        }
        .sheet(isPresented: $isShowingAddGroup) {
            NewGroupView { newGroup in
                taskGroups.append(newGroup)
                selectedGroup = newGroup
                
            }
        }
        .onAppear {
            // Loading Data Function
            loadData()
            
        }
        .onChange(of: scenePhase) { oldValue, newValue in
            if newValue == .active {
                print("App is active")
            } else if newValue == .inactive {
                print("Moving to inactive")
            } else if newValue == .background {
                print("User is switching attaction -  SAVE DATA")
                // saveData()
            }
            
        }
    }
    
    func saveData() {
        // Step A: Convert our Array Swift -> JSON
        if let encodedData = try? JSONEncoder().encode(taskGroups){
            //Step B: Save to UserDefault
            UserDefaults.standard.set(encodedData, forKey: saveKey)
        }
    }
    
    func loadData() {
        // Step A: Check if there is any content inside the key 'box'
        if let savedData = UserDefaults.standard.data(forKey: saveKey) {
            // Step B: Decode the data from JSON -> Array
            if let decodedData = try? JSONDecoder().decode([TaskGroup].self,
                from: savedData){
                taskGroups = decodedData
                return
            }
        }
        taskGroups = TaskGroup.sampleData
    }
}


