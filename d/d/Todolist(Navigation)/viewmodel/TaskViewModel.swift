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
        get {
            return task.title ?? ""
        }
        set(newTitle) {
            task.title = newTitle
        }
    }
    
    var createDate: Date {

        task.createDate ?? Date()
    }
    
    var modifyDate: Date {
        task.modifyDate ?? Date()
    }
    
    var isCompleted: Bool {
        get {
            task.isCompleted
        }
        set {
            task.isCompleted = newValue
            CoreDataManager.shared.updateTaskCompletion(taskId: id, isCompleted: newValue) // Core Data 업데이트
        }
    }
    
    var categoryId: UUID? {
        task.category?.id
    }
    
    var categoryTitle: String {
        task.category?.title ?? "No Category"
    }
}

extension TaskViewModel {
    mutating func toggleCompletion() {
        isCompleted.toggle()
        CoreDataManager.shared.updateTaskCompletion(taskId: id, isCompleted: isCompleted)
    }
}


struct CategoryViewModel {
    let id: UUID
    let title: String
    
    init(category: Category) {
        id = category.id ?? UUID()
        title = category.title ?? ""
    }
}

