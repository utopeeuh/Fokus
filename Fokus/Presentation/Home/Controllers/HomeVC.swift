//
//  HomeVC.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 20/11/22.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    let data = ["hahaha", "hiihih", "diididid"]
    
    private let profileView = ProfileView()
    
    private let homeFeedTable: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TaskListCell.self, forCellReuseIdentifier: "TaskListCell")
        tableView.isScrollEnabled = true
        tableView.backgroundColor = .clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return tableView
    }()
    
    private let titleListContainer: UILabel = {
        let title = UILabel()
        title.text = "Your tasks ✏️"
        title.font = .atkinsonRegular(size: 24)
        return title
    }()
    
    private let btnAddNewTask: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add new task 📝", for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.turq.cgColor
        btn.layer.cornerRadius = 8
        btn.setTitleColor(.turq, for: .normal)
        return btn
    }()

    override func viewWillAppear(_ animated: Bool){
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blackFokus
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        homeFeedTable.reloadData()
        
        btnAddNewTask.addTarget(self, action: #selector(addTaskOnClick), for: .touchUpInside)
        
        view.addSubview(homeFeedTable)
        view.addSubview(profileView)
        view.addSubview(titleListContainer)
        view.addSubview(btnAddNewTask)
        
        configureConstraints()
    }
    
    func configureConstraints(){
        
//        view.subviews.forEach { view in
//            view.snp.makeConstraints { make in
//                make.centerX.equalToSuperview()
//                make.width.equalToSuperview().offset(-40)
//            }
//        }
//
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
        
        homeFeedTable.snp.makeConstraints { make in
            make.height.equalTo(data.count*100)
            make.top.equalTo(titleListContainer.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
        }
        
        btnAddNewTask.snp.makeConstraints { make in
            make.top.equalTo(homeFeedTable.snp.bottom).offset(20)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
    @objc func addTaskOnClick(){
        let controller = CreateTaskVC()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskListCell", for: indexPath) as! TaskListCell
        cell.titleTask.text = data[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
