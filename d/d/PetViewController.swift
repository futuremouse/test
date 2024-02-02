//
//  PetViewController.swift
//  d
//
//  Created by t2023-m0024 on 2/1/24.
//

struct Cat: Decodable {
    let url: String
    let width: Int
    let height: Int
}

import UIKit

class PetViewController: UIViewController {
    
    let catImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "photo.artframe")
        return imageView
    }()

    // 이미지 뷰의 크기 조정을 위한 제약조건
    var widthConstraint: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        super.viewDidLoad()
        setupViews()
        loadCatImage()
        configureNavigationBar()
    }

    private func setupViews() {
        view.addSubview(catImageView)
        setupConstraints()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Cat"
        let refreshButton = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(refreshCatImage))
        navigationItem.rightBarButtonItem = refreshButton
    }

    @objc private func refreshCatImage() {
        loadCatImage()
    }
    
    private func setupConstraints() {
        widthConstraint = catImageView.widthAnchor.constraint(equalToConstant: 300) // 초기 가로 제약
        heightConstraint = catImageView.heightAnchor.constraint(equalToConstant: 300) // 초기 세로 제약

        NSLayoutConstraint.activate([
            catImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            catImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            widthConstraint,
            heightConstraint
        ])
    }

    private func loadCatImage() {
        let urlString = "https://api.thecatapi.com/v1/images/search"
      
        guard let url = URL(string: urlString) else {
            return
        }
      
        let request = URLRequest(url: url)
      
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error in
            if error != nil || data == nil {
                print("API 요청 실패")
                return
            }

            let jsonDecoder = JSONDecoder()
            guard let cats = try? jsonDecoder.decode([Cat].self, from: data!),
                  let cat = cats.first,
                  let imageUrl = URL(string: cat.url) else {
                print("JSON 파싱 실패")
                return
            }

            URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
                guard let data = data, let image = UIImage(data: data) else {
                    return
                }
                
                DispatchQueue.main.async {
                    self?.catImageView.image = image
                    // API에서 받은 이미지 크기에 따라 이미지 뷰 크기 조정
                    self?.widthConstraint.constant = min(CGFloat(cat.width), self?.view.frame.width ?? 300)
                    self?.heightConstraint.constant = min(CGFloat(cat.height), self?.view.frame.height ?? 300)
                }

            }.resume()
        })
      
        task.resume()
    }
}
