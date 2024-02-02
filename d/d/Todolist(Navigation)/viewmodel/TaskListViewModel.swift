//
//  TaskListViewModel.swift
//  d
//
//  Created by t2023-m0024 on 1/31/24.
//

import Foundation

class TaskListViewModel {
    var tasks = [TaskViewModel]()
    var categories = [CategoryViewModel]()
    
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
        categories = CoreDataManager.shared.getAllCategories().map { category in
            return CategoryViewModel(category: category)
        }
    }

    func deleteTask(id: UUID) {
        if let taskIndex = tasks.firstIndex(where: { $0.id == id }) {
            let task = tasks[taskIndex]
            
            // 카테고리 삭제 로직을 태스크 삭제 전에 호출
            if let categoryId = task.categoryId {
                deleteCategoryIfNeeded(categoryId: categoryId)
            }

            // Core Data에서 태스크 삭제 로직
            CoreDataManager.shared.delete(id: id)

            // tasks 배열에서 해당 태스크 제거
            tasks.remove(at: taskIndex)
        }
    }

//        // tasks 배열에서 해당 태스크 제거
//        tasks.removeAll { $0.id == id }
//    }
    
    func deleteCategoryIfNeeded(categoryId: UUID) {
        print("deleteCategoryIfNeeded 호출됨, categoryId: \(categoryId)")
        let tasksUsingCategory = tasks.filter { $0.categoryId == categoryId }
        print("해당 카테고리를 사용하는 태스크 수: \(tasksUsingCategory.count)")

        if tasksUsingCategory.isEmpty {
            print("삭제할 조건 충족, 카테고리 삭제 시도")
            CoreDataManager.shared.deleteCategory(id: categoryId)
        } else {
            print("카테고리 삭제 취소, 다른 태스크가 해당 카테고리를 사용 중")
        }
    }


//    func deleteItem(task: TaskViewModel) {
//        CoreDataManager.shared.delete(id: task.id)
//        getAll()
//    }
    
    func getAll() {
        let (fetchedTasks, fetchedCategories) = CoreDataManager.shared.getAllTasksAndCategories()
        self.tasks = fetchedTasks.map { task in
            return TaskViewModel(task: task)
        }
        self.categories = fetchedCategories.map { category in
            return CategoryViewModel(category: category)
        }
    }
    
    func numberOfRows(by section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return numberOfTasks
    }
    
    func getTasksByType() -> (complete: Int, incomplete: Int) {
        let completedCount = tasks.lazy.filter { $0.isCompleted }.count
        let incompleteCount = tasks.lazy.filter { !$0.isCompleted }.count
        return (completedCount, incompleteCount)
    }
    
    func task(by index: Int) -> TaskViewModel {
        return tasks[index]
    }
    
    func tasks(forCategory category: CategoryViewModel) -> [TaskViewModel] {
        let filterClosure: (TaskViewModel) -> Bool = { $0.categoryId == category.id }
        return tasks.filter(filterClosure)
    }
    
    func toggleTaskCompletion(taskId: UUID, isCompleted: Bool) {
        guard let taskIndex = tasks.firstIndex(where: { $0.id == taskId }) else { return }
        tasks[taskIndex].isCompleted = isCompleted
        CoreDataManager.shared.updateTaskCompletion(taskId: taskId, isCompleted: isCompleted)
    }
    
    func categoryTitle(with title: String) -> CategoryViewModel? {
        return categories.first { $0.title == title }
    }
    
    func categoryTitleForSection(_ section: Int) -> String? {
        guard section < categories.count else { return nil }
        return categories[section].title
    }
}
