//
//  TodoHeaderView.swift
//  d
//
//  Created by t2023-m0024 on 1/31/24.
//

import UIKit

class TodoHeaderView: UITableViewHeaderFooterView {
    
    static let reuseIdentifier = "myHeader"
    
    lazy var headerTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
//        label.numberOfLines = 0
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(headerTitleLabel)
        
        // Activate layout constraints for headerTitleLabel
        NSLayoutConstraint.activate([
            headerTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            headerTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            headerTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            headerTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

//    override func sizeThatFits(_ size: CGSize) -> CGSize {
//        
//        let calculatedSize = contentView.systemLayoutSizeFitting(size, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
//        return calculatedSize
//    }
    
}
