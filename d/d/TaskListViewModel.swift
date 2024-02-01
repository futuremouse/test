//
//  TaskListViewModel.swift
//  d
//
//  Created by t2023-m0024 on 1/31/24.
//

import Foundation

class TaskListViewModel {
    var tasks = [TaskViewModel]()
    var categories: [CategoryViewModel] = []
    
    init() {
        getAll()
    }
    
    var numberOfTasks: Int {
        tasks.count
    }
    var numberOfCategories: Int {
        categories.count
    }
    
    func addCategory(title: String) {
        CoreDataManager.shared.addNewCategory(title: title)
        // 카테고리 목록 갱신
        categories = CoreDataManager.shared.getAllCategories().map(CategoryViewModel.init)
    }
    
    func deleteItem(task: TaskViewModel) {
        CoreDataManager.shared.delete(id: task.id)
        getAll()
    }
    
    func getAll() {
        tasks = CoreDataManager.shared.getAll().map(TaskViewModel.init)
    }
    
    func numberOfRows(by section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return numberOfTasks
    }
    
    func getTasksByType() -> (complete: Int, Incomplete: Int) {
        let completedCount = tasks.lazy.filter({ $0.isCompleted }).count
        let incompleteCount = tasks.lazy.filter({ !$0.isCompleted }).count
        
        return (completedCount, incompleteCount)
    }
    
    func task(by index: Int) -> TaskViewModel {
        tasks[index]
    }
    
    func tasks(forCategory category: CategoryViewModel) -> [TaskViewModel] {
        let filterClosure: (TaskViewModel) -> Bool = { $0.categoryId == category.id }
        return tasks.filter(filterClosure)
    }
    
    func toggleTaskCompletion(taskId: UUID) {
        CoreDataManager.shared.toggleCompleted(id: taskId)
        // Optionally, refresh your tasks data after this operation
    }
    
    
    
    func categoryTitle (with title: String) {
        _ = CoreDataManager.shared.getCategories(byTitle: title)
    }
    
    func categoryTitleForSection(_ section: Int) -> String? {
        
        guard section < categories.count else { return nil }
        return categories[section].title
    }
}
