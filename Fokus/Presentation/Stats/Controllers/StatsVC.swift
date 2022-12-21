//
//  StatsVC.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 13/12/22.
//

import Foundation
import SnapKit

class StatsVC: UIViewController {
    
    private let statsVm = StatsViewModel()
    
    private var currDate : Date!
    
    private let dateIterator = DateIterator()
    
    private let topFiller : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGrey
        return view
    }()
    
    private let dateLabel = DateLabel()
    
    private let pomodoroButton = StatsButton(text: "Pomodoro")
    
    private let taskButton = StatsButton(text: "Task")
    
    //TODO: Add titles to sections
    
    private let pomodoroSection : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private var pomodoroHeader : UILabel = {
        let label = UILabel()
        label.text = "Pomodoro"
        label.font = .atkinsonBold(size: 18)
        label.textColor = .whiteFokus
        return label
    }()
    
    private var cyclesCreated = PomodoroDetail(title: "Siklus dibuat", value: "")
    private var cyclesFinished = PomodoroDetail(title: "Siklus diselesaikan", value: "")
    private var totalWork = PomodoroDetail(title: "Total durasi (kerja)", value: "")
    private var avgWork = PomodoroDetail(title: "Rata-rata durasi (kerja)", value: "")
    
    private let taskSection : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private var taskHeader : UILabel = {
        let label = UILabel()
        label.text = "Tasks"
        label.font = .atkinsonBold(size: 18)
        label.textColor = .whiteFokus
        return label
    }()
    
    private var tasksCreated = PomodoroDetail(title: "Dibuat", value: "")
    private var tasksFinished = PomodoroDetail(title: "Diselesaikan", value: "")
    private var tasksFinishedWithoutPomodoro = PomodoroDetail(title: "Diselesaikan tanpa pomodoro", value: "")
    
    override func viewDidAppear(_ animated: Bool) {
        refreshStats()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blackFokus
        
        currDate = dateIterator.currDate
        
        dateIterator.delegate = self
        
        dateLabel.date = Date()
        
        pomodoroButton.delegate = self
        
        taskButton.delegate = self
        taskButton.isActive = false
        
        // Add subviews
        
        let components = [topFiller, dateIterator, dateLabel, pomodoroButton, taskButton, pomodoroSection, taskSection]
        
        components.forEach { subview in
            view.addSubview(subview)
        }
        
        let pomodoroComponents = [pomodoroHeader, cyclesCreated, cyclesFinished, totalWork, avgWork]
        pomodoroComponents.forEach { view in
            pomodoroSection.removeArrangedSubview(view)
            pomodoroSection.addArrangedSubview(view)
        }
        
        let taskComponents = [taskHeader, tasksCreated , tasksFinished, tasksFinishedWithoutPomodoro]
        
        taskComponents.forEach { view in
            taskSection.addArrangedSubview(view)
        }
        
        configureConstraints()
    }
    
    func refreshStats(){
        
        statsVm.setMonth(month: currDate)
        
        // Pomodoro stats
        cyclesCreated.setDetailValue(value: "\(statsVm.cyclesCreated)")
        cyclesFinished.setDetailValue(value: "\(statsVm.cyclesFinished)")
        totalWork.setDetailValue(value: "\(statsVm.totalWork) min")
        avgWork.setDetailValue(value: "\(statsVm.avgWork) min")
        
        // Task stats
        tasksCreated.setDetailValue(value: "\(statsVm.tasksCreated)")
        tasksFinished.setDetailValue(value: "\(statsVm.tasksFinished)")
        tasksFinishedWithoutPomodoro.setDetailValue(value: "\(statsVm.tasksFinishedWithoutPomodoro)")
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
        
        pomodoroSection.snp.makeConstraints { make in
            make.top.equalTo(taskButton.snp.bottom).offset(20)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
        
        taskSection.snp.makeConstraints { make in
            make.top.equalTo(pomodoroSection.snp.bottom).offset(20)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
    }
}

extension StatsVC: DateIteratorDelegate {
    func dateIterator(willDisplay date: Date) {
        dateLabel.date = date
        currDate = date
        refreshStats()
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
