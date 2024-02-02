//
//  ProfileViewModel.swift
//  d
//
//  Created by t2023-m0024 on 2/1/24.
//

// ProfileViewModel.swift

import Foundation

class ProfileViewModel {
    var name: String = ""
    var age: String = ""

    init(user: User) {
        self.name = "Name: \(user.name)"
        self.age = "Age: \(user.age)"
    }
}
