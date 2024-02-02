//
//  ModifyTaskViewController.swift
//  d
//
//  Created by t2023-m0024 on 2/2/24.
//

import UIKit

class ModifyTaskViewController: UIViewController {
    var taskViewModel: TaskViewModel?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    lazy var taskNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Task Name"
        return label
    }()
    
    lazy var taskNameTextField: UITextField = {
        let v = UITextField()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.placeholder = "Enter task name"
        v.borderStyle = .roundedRect
        return v
    }()

    lazy var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Category Name"
        return label
    }()
    
    lazy var categoryNameTextField: UITextField = {
        let v = UITextField()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.placeholder = "Enter category name"
        v.borderStyle = .roundedRect
        return v
    }()
    
    lazy var dueOnLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Due On"
        return v
    }()
    
    lazy var dueOnDatePicker: UIDatePicker = {
        let v = UIDatePicker()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.datePickerMode = .date
        v.minimumDate = Date()
        return v
    }()
    
    let viewModel = ModifyTaskViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        title = "Modify Task"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTaskChanges))
        setupView()
//        registerKeyboardNotifications()
        setupInitialValues()
    }

    private func setupInitialValues() {
        taskNameTextField.text = taskViewModel?.title
        categoryNameTextField.text = taskViewModel?.categoryTitle
        dueOnDatePicker.date = taskViewModel?.createDate ?? Date()
    }


//    private func registerKeyboardNotifications() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
    
//    @objc private func keyboardWillShow(notification: Notification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
//            scrollView.contentInset = contentInsets
//            scrollView.scrollIndicatorInsets = contentInsets
//        }
//    }

    @objc private func keyboardWillHide() {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    private func setupView() {
        view.addSubview(scrollView)
        
        [taskNameLabel, taskNameTextField, categoryNameLabel, categoryNameTextField, dueOnLabel, dueOnDatePicker].forEach { subViewToAdd in
            view.addSubview(subViewToAdd)
        }
        
        setupConstraints()
    }

    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            taskNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            taskNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            taskNameTextField.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 8),
            taskNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            taskNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            categoryNameLabel.topAnchor.constraint(equalTo: taskNameTextField.bottomAnchor, constant: 8),
            categoryNameLabel.leadingAnchor.constraint(equalTo: taskNameTextField.leadingAnchor),
            
            categoryNameTextField.topAnchor.constraint(equalTo: categoryNameLabel.bottomAnchor, constant: 8),
            categoryNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            categoryNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            dueOnLabel.topAnchor.constraint(equalTo: categoryNameTextField.bottomAnchor, constant: 8),
            dueOnLabel.leadingAnchor.constraint(equalTo: categoryNameTextField.leadingAnchor),
            
            dueOnDatePicker.topAnchor.constraint(equalTo: categoryNameTextField.bottomAnchor, constant: 8),
            dueOnDatePicker.trailingAnchor.constraint(equalTo: categoryNameTextField.trailingAnchor, constant: 8),
        ])
    }
    
    @objc func saveTaskChanges() {
        view.endEditing(true) // 키보드 숨기기
        print("Save Task Changes called")
        
        guard let taskName = taskNameTextField.text, !taskName.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Task name can't be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            
            return
        }

        guard let taskID = taskViewModel?.id else {
            // 오류 처리: TaskViewModel의 id가 없는 경우
            return
        }

        let modifyDate = dueOnDatePicker.date
        let categoryTitle = categoryNameTextField.text ?? ""
        
        viewModel.updateTask(id: taskID, newName: taskName, newModifyDate: modifyDate, newCategoryTitle: categoryTitle)
        
        navigationController?.popViewController(animated: true)
    }
}
