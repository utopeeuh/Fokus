//
//  HomeVC.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 20/11/22.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    private let homeVM = HomeViewModel()
    
    private let profileView = ProfileView()
    
    private var taskList : [TaskModel] = []{
        didSet {
            refreshData()
        }
    }
    
    private let titleListContainer: UILabel = {
        let title = UILabel()
        title.text = "Task anda ✏️"
        title.font = .atkinsonRegular(size: 24)
        return title
    }()
    
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let homeFeedTable: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TaskListCell.self, forCellReuseIdentifier: "TaskListCell")
        tableView.isScrollEnabled = true
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return tableView
    }()
    
    private let btnAddNewTask: UIButton = {
        let btn = UIButton()
        btn.setTitle("Buat task baru 📝", for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.turq.cgColor
        btn.layer.cornerRadius = 8
        btn.setTitleColor(.turq, for: .normal)
        return btn
    }()

    override func viewWillAppear(_ animated: Bool){
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = false
        taskList = homeVM.getTaskList()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blackFokus
        
        profileView.delegate = self
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        homeFeedTable.isScrollEnabled = false
        
        btnAddNewTask.addTarget(self, action: #selector(addTaskOnClick), for: .touchUpInside)
        
        scrollView.addSubview(homeFeedTable)
        scrollView.addSubview(btnAddNewTask)
        
        view.addSubview(profileView)
        view.addSubview(titleListContainer)
        view.addSubview(scrollView)
        
        configureConstraints()
    }
    
    func configureConstraints(){
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(profileView.height)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
        }
        
        titleListContainer.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(20)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleListContainer.snp.bottom).offset(20)
            make.centerX.bottom.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
        }
        
        homeFeedTable.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(taskList.count*100)
            make.width.equalToSuperview()
        }
        
        btnAddNewTask.snp.makeConstraints { make in
            make.top.equalTo(homeFeedTable.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
    @objc func onClickTaskList(){
        let controller = CreateTaskVC()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func addTaskOnClick(){
        let controller = CreateTaskVC()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func refreshData(){
        homeFeedTable.reloadData()
        
//        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width-40, height: Double(taskList.count+1)*100)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width-40, height: CGFloat( Double(taskList.count+1))*100)

        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
        homeFeedTable.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(taskList.count*100)
            make.width.equalToSuperview()
        }
        
        btnAddNewTask.snp.remakeConstraints { make in
            make.top.equalTo(homeFeedTable.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(60)
        }
    }
}

extension HomeVC: ProfileViewDelegate {
    func editNameOnClick() {
        print("Edit")
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskListCell", for: indexPath) as! TaskListCell
        cell.task = taskList[indexPath.row]
        print(taskList[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(taskList[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = DetailTaskVC()
        controller.task = taskList[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
