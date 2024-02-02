//
//  TodoListViewController.swift
//  d
//
//  Created by t2023-m0024 on 1/31/24.
//

import UIKit

class TodoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tasks: [TaskViewModel] = []
    var selectedTaskViewModel: TaskViewModel?
    
    var viewModel = TaskListViewModel()
    
    lazy var tableView: UITableView = {
        let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.dataSource = self
        v.delegate = self
        v.register(TodoTableViewCell.self, forCellReuseIdentifier: "TodoCell")
        v.register(TodoHeaderView.self, forHeaderFooterViewReuseIdentifier: "myHeader")
        v.estimatedRowHeight = 200
        v.rowHeight = UITableView.automaticDimension
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        title = "To Do List"
        navigationController?.navigationBar.prefersLargeTitles = true

        // 할 일 추가 버튼
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask))
        
        // 수정 버튼
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTask))
        
//        // 삭제 버튼
//        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTask))
        
        // 버튼들을 오른쪽 네비게이션 아이템에 추가
        navigationItem.rightBarButtonItems = [addButton, editButton]
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
//        tableView.register(TodoHeaderView.self, forHeaderFooterViewReuseIdentifier: "myHeader")
        
//        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "myCell")
        
        fetchTasks()
        setupTableLayout()
        //        viewModel.getAll()
        //test용
        print(tasks)

    }
    
    func fetchTasks() {
        viewModel.getAll()
        self.tasks = viewModel.tasks  // viewModel에서 가져온 데이터로 tasks 배열 업데이트
        tableView.reloadData()
    }
    
    func setupTableLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
}

// MARK: - Extension

extension TodoListViewController: TodoTableViewCellDelegate {
    
    // MARK: - TableView DataSource
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        print("선택된 행: \(row), 섹션: \(section), 총 할 일 수: \(tasks.count)")

        let category = viewModel.categories[section]
        let tasksInCategory = viewModel.tasks(forCategory: category)
        if row < tasksInCategory.count {
            selectedTaskViewModel = tasksInCategory[row]
            print("선택된 Task: \(selectedTaskViewModel?.title ?? "제목 없음")")
        } else {
            print("선택된 인덱스가 배열 범위를 벗어났습니다.")
        }
    }

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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as? TodoTableViewCell else {
            return UITableViewCell()
        }
        let category = viewModel.categories[indexPath.section]
        let task = viewModel.tasks(forCategory: category)[indexPath.row]
        cell.viewModel = task
        cell.delegate = self
        return cell
    }
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "myHeader") as? TodoHeaderView else {
            return nil
        }

        let headerTitle = viewModel.categoryTitleForSection(section) ?? "No Category"
        print("Section \(section): Header Title is '\(headerTitle)'")  // 로그 출력
        headerView.headerTitleLabel.text = headerTitle

        return headerView
    }

    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }
    // MARK: - TableViewCell Delegate
    
    func didValueChanged(taskId: UUID, isCompleted: Bool) {
        viewModel.toggleTaskCompletion(taskId: taskId, isCompleted: isCompleted)
        
        if let index = viewModel.tasks.firstIndex(where: { $0.id == taskId }) {
            let indexPath = IndexPath(row: index, section: 0) // 섹션 인덱스를 설정
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - Action
    
    @objc
    func addNewTask() {
        navigationController?.pushViewController(AddNewTaskViewController(), animated: true)
    }
    
    @objc func editTask() {
        guard let selectedTask = selectedTaskViewModel else {
            return
        }
        let modifyVC = ModifyTaskViewController()
        modifyVC.taskViewModel = selectedTask
        navigationController?.pushViewController(modifyVC, animated: true)
    }

//    @objc
//    func deleteTask() {
//        // 선택된 TaskViewModel을 삭제하는 로직
//        if let selectedTask = selectedTaskViewModel {
//            // 할 일 삭제
//            viewModel.deleteTask(id: selectedTask.id)
//            
//            fetchTasks()
//
//            // 카테고리 삭제 로직 호출 (필요한 경우)
//            if let categoryId = selectedTask.categoryId {
//                print("deleteTask 내에서 deleteCategoryIfNeeded 호출, categoryId: \(categoryId)")
//                viewModel.deleteCategoryIfNeeded(categoryId: categoryId)
//            } else {
//                print("Selected task has no associated categoryId.")
//            }
//
//            print("Deleting task: \(selectedTask.title)")
//
//            // 선택된 TaskViewModel 초기화
//            selectedTaskViewModel = nil
//
//            // 테이블 뷰 업데이트
//            fetchTasks()
//        } else {
//            print("No selected task available to delete.")
//        }
//    }
    

    // MARK: - View lifeCycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getAll()
        tableView.reloadData()
        
    }
}




