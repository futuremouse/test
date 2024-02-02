//
//  ProfileViewController.swift
//  d
//
//  Created by t2023-m0024 on 1/30/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var profileView: ProfileView!
    private var viewModel: ProfileViewModel!

    override func loadView() {
        view = ProfileView()
        profileView = view as? ProfileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        let user = User(name: "NABAECAMP", age: 28)
        viewModel = ProfileViewModel(user: user)
        bindUserData()
    }
    
    private func bindUserData() {
        profileView.configure(with: viewModel)
    }
}
