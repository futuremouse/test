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
        config.title = "TODOLIST"
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
        config.title = "CAT"
        config.baseBackgroundColor = .green
        config.baseForegroundColor = .white
        config.buttonSize = .medium
        config.cornerStyle = .medium
        
        let btn = UIButton(configuration: config)
        btn.translatesAutoresizingMaskIntoConstraints = false
        if let catImage = UIImage(named: "CatImage") {
            btn.setImage(catImage, for: .normal)
        }
        btn.addTarget(self, action: #selector(didTabCat), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var profileButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "ProfileDesignViewController"
        config.baseBackgroundColor = .blue
        config.baseForegroundColor = .white
        config.buttonSize = .medium
        config.cornerStyle = .medium
        
        let btn = UIButton(configuration: config)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(didTabProfile), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var RandomVideoButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "RandomVideoViewController"
        config.baseBackgroundColor = .blue
        config.baseForegroundColor = .white
        config.buttonSize = .medium
        config.cornerStyle = .medium
        
        let btn = UIButton(configuration: config)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(didTabRandom), for: .touchUpInside)
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        setupView()
        setupConstraints()
    }
        
        // navigationController에 MainViewController를 내장시킴
//        let navigationController = UINavigationController(rootViewController: self)
//        navigationController.modalPresentationStyle = .fullScreen
//        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//            windowScene.windows.first?.rootViewController = navigationController
//        }

    private func setupView() {
  
        view.backgroundColor = .systemBackground
        
        [myImage, todolistButton, catButton, profileButton, RandomVideoButton].forEach { subViewToAdd in
            view.addSubview(subViewToAdd)
        }
        
    }
    
    func setupConstraints() {
        
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
            catButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            catButton.topAnchor.constraint(equalTo: todolistButton.bottomAnchor, constant: 45),
        ])
        
        NSLayoutConstraint.activate([
            profileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileButton.topAnchor.constraint(equalTo: catButton.bottomAnchor, constant: 45),
        ])
        
        NSLayoutConstraint.activate([
            RandomVideoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            RandomVideoButton.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 45),
        ])
        
    }
    
    @objc
    func didTabTodolist() {
        
//        let vc = TodoListViewController()
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true)
        
        let todoListVC = TodoListViewController()
        let navigationController = UINavigationController(rootViewController: todoListVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }

//    @objc
//    func didTabCat() {
//        let petVC = PetViewController()
//        petVC.modalPresentationStyle = .fullScreen
//        present(petVC, animated: true, completion: nil)
        
//        let petVC = PetViewController()
//        let navigationController = UINavigationController(rootViewController: petVC)
//        navigationController.modalPresentationStyle = .fullScreen
//        present(navigationController, animated: true, completion: nil)
//
//    }
    
    @objc func didTabCat() {
        let petVC = PetViewController()
        if let navigationController = self.navigationController {
            navigationController.pushViewController(petVC, animated: true)
        } else {
            print("네비게이션 컨트롤러가 없음")
        }
    }

    @objc
    func didTabProfile() {
        showProfilePage(segueIdentifier: "showProfileDesign")
    }
    
    @objc
    func didTabRandom() {
        let randomVideoVC = RandomVideoViewController()
        present(randomVideoVC, animated: true, completion: nil)
    }
    // MARK: - Navigation
    func showProfilePage(segueIdentifier: String) {
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
    
}

