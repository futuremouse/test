//
//  ProfileViewController.swift
//  d
//
//  Created by t2023-m0024 on 1/30/24.
//

import UIKit

// Controller
class ProfileViewController: UIViewController {
    
    private var profileView: ProfileView!
    private var user: User!
    
    override func loadView() {
        view = ProfileView()
        profileView = view as? ProfileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        user = User(userName: "NABAECAMP", userAge: 28)
        bindUserData()
    }
    
    private func bindUserData() {
        profileView.bindData(user: user)
    }
}
