//
//  DummyVC.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 16/11/22.
//

import UIKit
import SnapKit

class DummyVC: UIViewController {
    
    let data = ["hahaha", "hiihih", "diididid"]
    
    let button: UIButton = {
        
        let container = UIButton()
        
        container.backgroundColor = .red
        container.layer.borderColor = UIColor.white.cgColor
        container.layer.borderWidth = 1
        container.setTitleColor(.white, for: .selected)
        
        
        container.setTitle("Not selected", for: .normal)
        container.setTitle("hello world!", for: .selected)
        
        
        container.isUserInteractionEnabled = true
        
        
        return container
    }()
    
    private let homeFeedTable: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TaskListCell.self, forCellReuseIdentifier: "TaskListCell")
        tableView.isScrollEnabled = true
        tableView.backgroundColor = .clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return tableView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.addSubview(button)
        
        view.backgroundColor = .systemBackground
        
//        view.addSubview(homeFeedTable)
//
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        homeFeedTable.reloadData()
        
        view.addSubview(homeFeedTable)
        
        homeFeedTable.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.height.equalTo(data.count*100)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        button.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }
       

    }
    
}

extension DummyVC: UITableViewDelegate, UITableViewDataSource {
    
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
