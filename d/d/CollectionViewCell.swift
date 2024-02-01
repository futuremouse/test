//
//  CollectionViewCell.swift
//  d
//
//  Created by t2023-m0024 on 1/30/24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MyCell"
    
    private let pictureImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = .systemBackground
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
        configureCell()
    }
    
    private func setUI() {
        self.addSubview(pictureImageView)
    }
    
    private func configureCell() {
        pictureImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pictureImageView.topAnchor.constraint(equalTo: self.topAnchor),
            pictureImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            // 이미지 뷰의 크기를 셀과 같게 설정
            pictureImageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            pictureImageView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
    // 이미지 뷰에 이미지를 설정
    func setImage(named imageName: String) {
        pictureImageView.image = UIImage(named: imageName) ?? UIImage()
    }
    
}
