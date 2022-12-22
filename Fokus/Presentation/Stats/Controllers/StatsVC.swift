//
//  StatsVC.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 13/12/22.
//

import Foundation
import SnapKit
import Charts

class StatsVC: UIViewController {
    
    private let statsVm = StatsViewModel()
    
    private var currDate : Date!
    
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 833)
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    // MARK: - Date iterator
    
    private let dateIterator = DateIterator()
    
    private let topFiller : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGrey
        return view
    }()
    
    private let dateLabel = DateLabel()
    
    // MARK: - Graph
    
    private let pomodoroButton = StatsButton(text: "Pomodoro")
    
    private let taskButton = StatsButton(text: "Task")
    
    private let pomodoroLineChart = StatsLineChart()
    private let taskLineChart = StatsLineChart()
    
    // MARK: - Stat numbers
    
    // Pomodoro stats

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
    
    // Task stats
    
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
    
    // MARK: - Load view
    
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
        
        // Pomodoro section
        let pomodoroComponents = [pomodoroHeader, cyclesCreated, cyclesFinished, totalWork, avgWork]
        pomodoroComponents.forEach { view in
            pomodoroSection.removeArrangedSubview(view)
            pomodoroSection.addArrangedSubview(view)
        }
        
        // Task section
        
        let taskComponents = [taskHeader, tasksCreated , tasksFinished, tasksFinishedWithoutPomodoro]
        
        taskComponents.forEach { view in
            taskSection.addArrangedSubview(view)
        }
        
        // Add all subviews
        
        view.addSubview(topFiller)
        view.addSubview(dateIterator)
        
        let components = [dateLabel, pomodoroButton, taskButton, taskLineChart, pomodoroLineChart,pomodoroSection, taskSection]
        
        components.forEach { subview in
            scrollView.addSubview(subview)
        }
        
        view.addSubview(scrollView)
        
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

        pomodoroLineChart.setData(data: statsVm.pomodoroLineData)
        taskLineChart.setData(data: statsVm.taskLineData)
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
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(dateIterator.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        
        dateLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(20)
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
        
        pomodoroLineChart.snp.makeConstraints { make in
            make.top.equalTo(taskButton.snp.bottom).offset(20)
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(pomodoroLineChart.frame.height)
            make.centerX.equalToSuperview()
        }
        
        taskLineChart.snp.makeConstraints { make in
            make.edges.equalTo(pomodoroLineChart)
        }
        
        pomodoroSection.snp.makeConstraints { make in
            make.top.equalTo(pomodoroLineChart.snp.bottom).offset(20)
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
            taskLineChart.isHidden = true
            pomodoroLineChart.isHidden = false
        }
        
        else {
            pomodoroButton.isActive = false
            taskLineChart.isHidden = false
            pomodoroLineChart.isHidden = true
        }
    }
}
