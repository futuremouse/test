//
//  TodoTableViewCell.swift
//  d
//
//  Created by t2023-m0024 on 1/31/24.
//

import UIKit

protocol TodoTableViewCellDelegate: AnyObject {
    func didValueChanged(taskId: UUID, isCompleted: Bool)
}

class TodoTableViewCell: UITableViewCell {
    
    
    weak var delegate: TodoTableViewCellDelegate?
    
    var viewModel: TaskViewModel? {
        didSet {
            if let viewModel = viewModel {
                configure(with: viewModel)
            }
        }
    }
    
    
    lazy var taskNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var dueOrCompletedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font =  UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var completeSwitch: UISwitch = {
        let toggleSwitch = UISwitch()
        toggleSwitch.addTarget(self, action: #selector(switchToggle(_:)), for: .valueChanged)
        toggleSwitch.translatesAutoresizingMaskIntoConstraints = false
        return toggleSwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:
                    "TodoCell")
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(taskNameLabel)
        contentView.addSubview(dueOrCompletedLabel)
        contentView.addSubview(completeSwitch)
        
        setupConstraints()
    }
    
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            taskNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            taskNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            taskNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            dueOrCompletedLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 16),
            dueOrCompletedLabel.leadingAnchor.constraint(equalTo: taskNameLabel.leadingAnchor),
            dueOrCompletedLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            completeSwitch.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 16),
            completeSwitch.trailingAnchor.constraint(equalTo: taskNameLabel.trailingAnchor),
            completeSwitch.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
        ])
    }
    
    //    func configure(with viewModel: TaskViewModel?) {
    //        guard let viewModel = viewModel else { return }
    //        
    //        taskNameLabel.text = viewModel.title
    //        completeSwitch.isOn = viewModel.isCompleted
    //        
    //    }
    func configure(with task: TaskViewModel) {
        let attributedString = NSMutableAttributedString(string: task.title)
        
        if task.isCompleted {
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributedString.length))
            taskNameLabel.font = UIFont.italicSystemFont(ofSize: 16)
        } else {
            taskNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        }
        
        taskNameLabel.attributedText = attributedString
        
        dueOrCompletedLabel.text = task.isCompleted ? "Completed on: \(task.modifyDate.formatted(date: .abbreviated, time: .omitted))" : "Due on: \(task.createDate.formatted(date: .abbreviated, time: .omitted))"
        
        completeSwitch.isOn = task.isCompleted
        //        completedLabel.textColor = task.completed ? .green : .red
    }
    
    @objc func switchToggle(_ sender: Any) {
        guard let switchControl = sender as? UISwitch else {
            print("Switch not found")
            return
        }
        print("Switch toggled: \(switchControl.isOn)")
        viewModel?.toggleCompletion()
        switchControl.isOn = viewModel?.isCompleted ?? false
        if let taskId = viewModel?.id {
            delegate?.didValueChanged(taskId: taskId, isCompleted: switchControl.isOn)
        }
    }
    
    
}
