//
//  AddNewTaskViewModel.swift
//  d
//
//  Created by t2023-m0024 on 1/31/24.
//

import Foundation

class AddNewTaskViewModel {
    func addTask(title: String, createDate: Date, categoryTitle: String) {
        CoreDataManager.shared.addNewTask(title: title, createDate: createDate, categoryTitle: categoryTitle)
    }
}

