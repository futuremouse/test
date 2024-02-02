//
//  ModifyTaskViewModel.swift
//  d
//
//  Created by t2023-m0024 on 2/2/24.
//

import Foundation

class ModifyTaskViewModel {
    func updateTask(id: UUID, newName: String, newModifyDate: Date, newCategoryTitle: String) {
        
        CoreDataManager.shared.updateTask(id: id, newName: newName, newModifyDate: newModifyDate, newCategoryTitle: newCategoryTitle)
    }
    
}


