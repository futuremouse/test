//
//  CoreDataManager.swift
//  d
//
//  Created by t2023-m0024 on 1/31/24.
//

import CoreData
import Foundation

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "d")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    //CRUD(Create, Read, Update, Delete) 작업을 수행
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do  {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Error saving the staged changes \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getAll() -> [Task] {
        var tasks = [Task]()
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let sortByDueDate = NSSortDescriptor(key: "createDate", ascending: true)
        fetchRequest.sortDescriptors = [sortByDueDate]
        do {
            tasks = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return tasks
    }
    func getAllTasksAndCategories() -> ([Task], [Category]) {
        var tasks = [Task]()
        var categories = [Category]()
        
        // Task 엔티티를 불러오는 로직
        let taskFetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let sortByCreateDate = NSSortDescriptor(key: "createDate", ascending: true)
        taskFetchRequest.sortDescriptors = [sortByCreateDate]
        do {
            tasks = try context.fetch(taskFetchRequest)
        } catch {
            print("Error fetching tasks: \(error)")
        }
        
        // Category 엔티티를 불러오는 로직
        let categoryFetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categories = try context.fetch(categoryFetchRequest)
        } catch {
            print("Error fetching categories: \(error)")
        }
        
        return (tasks, categories)
    }
    
    
    func getAllCategoriesWithTasks(title:String) -> [Category] {
        var categories = [Category]()
        
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        // Optionally, add sort descriptors or predicates
        
        do {
            categories = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Error fetching categories: \(error.localizedDescription)")
        }
        
        return categories
    }
    
    func addNewTask(title: String,createDate: Date, categoryTitle: String) {
        let task = Task(context: context)
        task.title = title
        task.createDate = createDate
        
        task.id = UUID()
        task.isCompleted = false
        task.modifyDate = createDate.advanced(by: 100000)
        
        //        let category = Category(context: context)
        //        category.title = title
        //        category.id = UUID()
        
        let category = getCategories(byTitle: categoryTitle) ?? createCategory(categoryTitle: categoryTitle)
        task.category = category
        
        saveContext()
    }
    
    func updateTask(id: UUID, newName: String, newModifyDate: Date, newCategoryTitle: String) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let tasks = try context.fetch(fetchRequest)
            if let taskToUpdate = tasks.first {
                taskToUpdate.title = newName
                taskToUpdate.modifyDate = newModifyDate
                
                // 카테고리 업데이트 부분
                let category = getCategories(byTitle: newCategoryTitle) ?? createCategory(categoryTitle: newCategoryTitle)
                taskToUpdate.category = category
                
                saveContext()
            }
        } catch {
            // 오류 처리
        }
    }
    
    
    
    private func createCategory(categoryTitle: String) -> Category {
        let category = Category(context: context)
        category.title = categoryTitle
        category.id = UUID()
        return category
    }
    
    func getCategories(byTitle title: String) -> Category? {
        var categories = [Category]()
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        do {
            categories = try context.fetch(fetchRequest)
            return categories.first
        } catch {
            print("Error fetching categories with title \(title): \(error)")
            return nil
        }
    }
    
    func getAllCategories() -> [Category] {
        _ = [Category]()
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            let categories = try context.fetch(fetchRequest)
            return categories
        } catch {
            print("Failed to fetch categories: \(error)")
            return []
        }
    }
    func getCategory(byId id: UUID) -> Category? {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let categories = try context.fetch(fetchRequest)
            return categories.first
        } catch {
            print("Failed to fetch category with id \(id): \(error)")
            return nil
        }
    }
    
    func updateTaskCompletion(taskId: UUID, isCompleted: Bool) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", taskId as CVarArg)
        
        do {
            let tasks = try context.fetch(fetchRequest)
            if let task = tasks.first {
                task.isCompleted = isCompleted
                saveContext()
            }
        } catch {
            print("Error updating task completion: \(error)")
        }
    }
    
    func delete(id: UUID) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "id=%@", id.uuidString)
        
        do {
            let fetchedTasks = try context.fetch(fetchRequest)
            
            for task in fetchedTasks {
                context.delete(task)
            }
            
            saveContext()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func deleteCategory(id: UUID) {
        let categoryFetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        categoryFetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let fetchedCategories = try context.fetch(categoryFetchRequest)
            if let categoryToDelete = fetchedCategories.first {
                // 해당 카테고리를 사용하는 할 일이 있는지 확인
                let taskFetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
                taskFetchRequest.predicate = NSPredicate(format: "category == %@", categoryToDelete)
                let tasksUsingCategory = try context.fetch(taskFetchRequest)
                
                if tasksUsingCategory.isEmpty {
                    context.delete(categoryToDelete)
                    saveContext()
                } else {
                    // 다른 할 일이 해당 카테고리를 사용하는 경우 추가적인 처리 필요
                    print("Cannot delete category: It is being used by some tasks.")
                }
            }
        } catch let error {
            print("Error deleting category: \(error.localizedDescription)")
        }
    }
    
    func addNewCategory(title: String) {
        let category = Category(context: context)
        category.title = title
        // ... additional setup ...
        saveContext()
    }
    
}
