//
//  TaskViewModel.swift
//  d
//
//  Created by t2023-m0024 on 1/31/24.
//

import Foundation
import CoreData

struct TaskViewModel {
    var task: Task

    var id: UUID {
        task.id ?? UUID()
    }

    var title: String {
        task.title ?? ""
    }

    var isCompleted: Bool {
        get {
            task.isCompleted
        }
        set {
            task.isCompleted = newValue
            // Optionally, update the task in Core Data here or notify someone to do it
        }
    }
    
    var categoryId: UUID? {
        task.category?.id
    }
    
    

    // Add a method to handle the completion toggle
    mutating func toggleCompletion() {
        isCompleted.toggle()
        // Save the change or notify the view model responsible for saving
    }
}

struct CategoryViewModel {
    let id: UUID
    let title: String
    
    init(category: Category) {
        // Directly assign values from the Category entity
        id = category.id ?? UUID()
        title = category.title ?? ""
    }
}

