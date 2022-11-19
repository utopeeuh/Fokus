//
//  TableViewCell.swift
//  Fokus
//
//  Created by Firzha Ardhia Ramadhan on 19/11/22.
//

import UIKit

class TaskListCell: UITableViewCell {
    
    var titleTask = UILabel()
    var titleTime = UILabel()
    
    var checkedLogo: UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "uncheckedTaskLogo"))
        return imageView
    }()
    var arrowRightLogo: UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "arrowRight"))
        return imageView
    }()

    var titleAndTime = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: "TaskListCell")
        backgroundColor = .blackFokus
        
        
        titleTask.text = "Lorem ipsum dolor sit jamet"
        titleTask.font = UIFont.systemFont(ofSize: 20)
        titleTime.text = "03:00 PM, 10 January 2022"
        titleTime.font = UIFont.systemFont(ofSize: 18)
        titleTime.textColor = .lightGray
        
        
        layer.cornerRadius = 8
        addSubview(checkedLogo)
        
        titleAndTime.addSubview(titleTask)
        titleAndTime.addSubview(titleTime)
        
        addSubview(titleAndTime)
        
        addSubview(arrowRightLogo)
        
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraint() {
        titleAndTime.snp.makeConstraints { make in
            make.height.equalToSuperview().offset(-28)
            make.width.equalToSuperview().offset(-114)
            make.centerY.equalToSuperview()
            make.left.equalTo(checkedLogo.snp.right).offset(14)
        }
        titleTask.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }
        titleTime.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        checkedLogo.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        arrowRightLogo.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.width.equalTo(12)
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
