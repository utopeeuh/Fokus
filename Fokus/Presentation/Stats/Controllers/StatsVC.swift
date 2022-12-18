//
//  StatsVC.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 13/12/22.
//

import Foundation
import SnapKit

class StatsVC: UIViewController {
    
    private let dateIterator = DateIterator()
    
    private let topFiller : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGrey
        return view
    }()
    
    private let dateLabel = DateLabel()
    
    private let pomodoroButton = StatsButton(text: "Pomodoro")
    
    private let taskButton = StatsButton(text: "Task")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blackFokus
        
        dateIterator.delegate = self
        
        dateLabel.date = Date()
        
        pomodoroButton.delegate = self
        taskButton.delegate = self
        
        taskButton.isActive = false
        
        view.addSubview(topFiller)
        view.addSubview(dateIterator)
        view.addSubview(dateLabel)
        view.addSubview(pomodoroButton)
        view.addSubview(taskButton)
        
        configureConstraints()
    }
    
    func configureConstraints(){
        
        topFiller.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.bottom.equalTo(dateIterator.snp.top)
        }
        
        dateIterator.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview()
            make.height.equalTo(dateIterator.frame.height)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(dateIterator.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        pomodoroButton.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(pomodoroButton.frame.size)
        }
        
        taskButton.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
            make.left.equalTo(pomodoroButton.snp.right).offset(20)
        }
    }
}

extension StatsVC: DateIteratorDelegate {
    func dateIterator(willDisplay date: Date) {
        dateLabel.date = date
    }
}

extension StatsVC: StatsButtonDelegate {
    func onButtonTapped(tapped button: StatsButton) {
        if button == pomodoroButton {
            taskButton.isActive = false
        }
        
        else {
            pomodoroButton.isActive = false
        }
    }
}
