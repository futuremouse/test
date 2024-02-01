//
//  TodoListViewController.swift
//  d
//
//  Created by t2023-m0024 on 1/31/24.
//

import UIKit

class TodoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    var viewModel = TaskListViewModel()
    
    lazy var tableView: UITableView = {
        let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.dataSource = self
        v.delegate = self
        v.register(TodoTableViewCell.self, forCellReuseIdentifier: "TodoCell")
        
        v.estimatedRowHeight = 200
        v.rowHeight = UITableView.automaticDimension
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        title = "To Do List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask))
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        tableView.register(TodoHeaderView.self, forHeaderFooterViewReuseIdentifier: "myHeader")
        
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "myCell")
        
        fetchTasks()
        setupTableLayout()
        
    }
    
    func fetchTasks() {
        viewModel.getAll()
        tableView.reloadData()
    }
    
    func setupTableLayout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
    }
    // MARK: - TableView DataSource
    // 카테고리 수만큼 섹션을 반환
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.categories.count
    }
    
    // 각 섹션에 속한 태스크의 수를 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // section 인덱스에 해당하는 카테고리의 태스크 수를 반환
        let category = viewModel.categories[section]
        return viewModel.tasks(forCategory: category).count
    }
        
//        return viewModel.numberOfTasks
//        if section == 0 {
//            return viewModel.categories.count
//        }
//        else {
//            return viewModel.numberOfTasks
//        }
//        
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as? TodoTableViewCell else {
            return UITableViewCell()
        }
        // indexPath.section 인덱스에 해당하는 카테고리를 찾고
        // 해당 카테고리에 속한 태스크 목록에서 indexPath.row에 해당하는 태스크를 가져옴
        let category = viewModel.categories[indexPath.section]
        let task = viewModel.tasks(forCategory: category)[indexPath.row]
        
        // 셀에 태스크 데이터를 설정
        cell.configure(with: task)
        
        
//        let taskViewModel = viewModel.task(by: indexPath.row)
//        cell.configure(with: taskViewModel)
        
        return cell
    }
    
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "myHeader") as? TodoHeaderView else {
            return nil
        }
        
        let headerTitle = viewModel.categoryTitleForSection(section) ?? "No Category"
        headerView.headerTitleLabel.text = headerTitle

        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30 // 헤더 뷰의 높이 설정
    }
    
}
//    func completeTask(at indexPath: IndexPath) {
//        let task = viewModel.task(by: indexPath.row)
//        // 작업을 완료 상태로 설정하거나 해제하는 로직을 구현
//    }

// MARK: - Extension

extension TodoListViewController: TodoTableViewCellDelegate {
    func didValueChanged(taskId: UUID, isCompleted: Bool) {
        if let taskIndex = viewModel.tasks.firstIndex(where: { $0.id == taskId }) {
            viewModel.tasks[taskIndex].toggleCompletion()
            
            // Update the task's completion status in the viewModel
            viewModel.toggleTaskCompletion(taskId: taskId)
            
            // Fetch the updated tasks from Core Data through viewModel
            viewModel.getAll()
            
            // Reload the table view to reflect the changes
            self.tableView.reloadData()
        }
    }
    
    @objc
    func addNewTask() {
        navigationController?.pushViewController(AddNewTaskViewController(), animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getAll()
        tableView.reloadData()
    }
    
}

