//
//  TableViewCell.swift
//  Fokus
//
//  Created by Firzha Ardhia Ramadhan on 19/11/22.
//

import UIKit

class TaskListCell: UITableViewCell {
    
    private var titleTask = UILabel()
    private var timeTask = UILabel()
    
    private var checkedLogo: UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "uncheckedTaskLogo"))
        return imageView
    }()
    
    private var arrowRightLogo: UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "arrowRight"))
        return imageView
    }()

    private var titleAndTime = UIView()
    private var containerList = UIView()
    
    let spacer = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: "TaskListCell")
        
        backgroundColor = .clear
        selectionStyle = .none
        
        containerList.backgroundColor = .darkGrey
        containerList.layer.cornerRadius = 8
        
        titleTask.font = .atkinsonRegular(size: 20)
        timeTask.font = .atkinsonRegular(size: 18)
        timeTask.textColor = .lightGray
        
        titleAndTime.addSubview(titleTask)
        titleAndTime.addSubview(timeTask)
        
        containerList.addSubview(checkedLogo)
        containerList.addSubview(titleAndTime)
        containerList.addSubview(arrowRightLogo)
        
        addSubview(containerList)
        addSubview(spacer)
        
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
        
        timeTask.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        checkedLogo.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        arrowRightLogo.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        spacer.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalToSuperview()
        }
        
        containerList.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalTo(80)
        }
    }

    func setTask(task: TaskModel){
        if task.dateFinished != nil {
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: (task.title)!)
            
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: attributeString.length))
            
            attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: NSRange(location: 0, length: attributeString.length))
            
            titleTask.attributedText = attributeString
            
            checkedLogo.image = UIImage(named: "checkedTaskLogo")
        }
        else {
            titleTask.text = task.title
        }
        
        if task.reminder != nil {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a, dd MMM YYYY"
            timeTask.text = formatter.string(from: (task.reminder)!)
        }
        else {
            titleTask.snp.remakeConstraints { make in
                make.width.centerY.equalToSuperview()
            }
            
            timeTask.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        
        checkedLogo.image = UIImage(named: "uncheckedTaskLogo")
        
        titleTask.attributedText = nil
        
        timeTask.isHidden = false
        
        titleTask.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
}
