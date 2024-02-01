//
//  MainViewController.swift
//  d
//
//  Created by t2023-m0024 on 1/30/24.
//

import UIKit

class MainViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    private lazy var myImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var todolistButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "todolist".uppercased()
        config.baseBackgroundColor = .blue
        config.baseForegroundColor = .white
        config.buttonSize = .medium
        config.cornerStyle = .medium
        
        let btn = UIButton(configuration: config)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(didTabTodolist), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var catButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "cat".uppercased()
        config.baseBackgroundColor = .green
        config.baseForegroundColor = .white
        config.buttonSize = .medium
        config.cornerStyle = .medium
        
        let btn = UIButton(configuration: config)
        btn.translatesAutoresizingMaskIntoConstraints = false
        if let catImage = UIImage(named: "CatImage") {
            btn.setImage(catImage, for: .normal)
        }
        // Set up action for the button
        btn.addTarget(self, action: #selector(didTabCat), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var profileButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "ProfileDesignViewController".uppercased()
        config.baseBackgroundColor = .blue
        config.baseForegroundColor = .white
        config.buttonSize = .medium
        config.cornerStyle = .medium
        
        let btn = UIButton(configuration: config)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(didTabProfile), for: .touchUpInside)
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
        
        // navigationController에 MainViewController를 내장시킴
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.modalPresentationStyle = .fullScreen
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.rootViewController = navigationController
        }
        
        
        
        guard let url = URL(string: "https://spartacodingclub.kr/css/images/scc-og.jpg") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFit
                imageView.frame = self.myImage.bounds
                self.myImage.addSubview(imageView)
            }
        }
        
        task.resume()
    }
    
    func setup() {
        self.view.backgroundColor = .white
        self.view.addSubview(myImage)
        self.view.addSubview(todolistButton)
        self.view.addSubview(catButton)
        self.view.addSubview(profileButton)
    }
    
    func setupConstraints() {
        
        let verticalSpacing: CGFloat = 85 // Adjust the value as needed
        
        NSLayoutConstraint.activate([
            myImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 17),
            myImage.widthAnchor.constraint(equalToConstant: 240),
            myImage.heightAnchor.constraint(equalToConstant: 128),
        ])
        
        NSLayoutConstraint.activate([
            todolistButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            todolistButton.topAnchor.constraint(equalTo: myImage.bottomAnchor, constant: 81),
        ])
        
        NSLayoutConstraint.activate([
            catButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            catButton.topAnchor.constraint(equalTo: todolistButton.bottomAnchor, constant: verticalSpacing),
        ])
        
        NSLayoutConstraint.activate([
            profileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileButton.topAnchor.constraint(equalTo: catButton.bottomAnchor, constant: verticalSpacing),
        ])
        
        
    }
    
    @objc
    func didTabTodolist() {
        let todoListVC = TodoListViewController()
        let navigationController = UINavigationController(rootViewController: todoListVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }


    
    
    @objc
    func didTabCat() {
        //        let petVC = PetViewController()
        //        present(petVC, animated: true, completion: nil)
    }
    @objc
    func didTabProfile() {
        showProfilePage(segueIdentifier: "showProfileDesign")
    }
    // MARK: - Navigation
    func showProfilePage(segueIdentifier: String) {
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
    func showTodoPage(segueIdentifier: String) {
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
    
}

