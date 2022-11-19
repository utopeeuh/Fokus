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

    override func viewWillAppear(_ animated: Bool){
        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blackFokus
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        homeFeedTable.reloadData()
        
        view.addSubview(homeFeedTable)
        view.addSubview(profileView)
        
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
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(profileView.height)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
        }
        
        homeFeedTable.snp.makeConstraints { make in
            make.height.equalTo(data.count*100)
            make.top.equalTo(profileView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
        }
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
