//
//  DetailTaskVC.swift
//  Fokus
//
//  Created by Firzha Ardhia Ramadhan on 30/11/22.
//

import UIKit
import SnapKit

class DetailTaskVC: UIViewController {
    
    private let pomodoroCycle = PomodoroDetail(title: "Pomodoros", value: "4 Cycles")
    private let workDuration = PomodoroDetail(title: "Work", value: "20:00")
    private let shortBreakDuration = PomodoroDetail(title: "Short Break", value: "10:00")
    private let longBreakDuration = PomodoroDetail(title: "Long Break", value: "25:00")


    private let whiteNoiseView : OptionsCollectionView = {
        let collectionView = OptionsCollectionView(title: "White Noise", options: ["ON", "OFF"])
        collectionView.selectedIndex = 0
        return collectionView
    }()
    
    private let btnStartTask: UIButton = {
        let btn = UIButton()
        btn.setTitle("Start", for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.turq.cgColor
        btn.layer.cornerRadius = 60
        btn.setTitleColor(.turq, for: .normal)
        return btn
    }()
    
    private let btnMarkDoneTask: UIButton = {
        let btn = UIButton()
        btn.setTitle("Mark as done📝", for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.turq.cgColor
        btn.layer.cornerRadius = 8
        btn.setTitleColor(.turq, for: .normal)
        return btn
    }()
    
    private let btnDeleteTask: UIButton = {
        let btn = UIButton()
        btn.setTitle("Delete Task", for: .normal)
        btn.setTitleColor(.systemRed, for: .normal)
        btn.backgroundColor = UIColor.clear
        return btn
    }()

    
    private let taskTitle: UILabel = {
        let title = UILabel()
        title.text = "This is my title"
        title.font = .atkinsonRegular(size: 24)
        return title
    }()
    
    private let taskScheduleLabel: UILabel = {
        let title = UILabel()
        title.text = "03.00 PM 15 Jul 2022"
        title.font = .atkinsonRegular(size: 16)
        return title
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blackFokus

        btnMarkDoneTask.addTarget(self, action: #selector(onClickDoneTask), for: .touchUpInside)
        
        view.addSubview(taskTitle)
        view.addSubview(btnStartTask)
        view.addSubview(taskScheduleLabel)
        view.addSubview(pomodoroCycle)
        view.addSubview(workDuration)
        view.addSubview(shortBreakDuration)
        view.addSubview(longBreakDuration)
        view.addSubview(whiteNoiseView)
        
        view.addSubview(btnMarkDoneTask)
        view.addSubview(btnDeleteTask)

        
        configureConstraints()
        // Do any additional setup after loading the view.
    }
    
    func configureConstraints(){
                
        taskTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
//            make.top.equalToSuperview()
//            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
        
        btnStartTask.snp.makeConstraints { make in
            make.top.equalTo(taskTitle.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(120)
        }
        
        taskScheduleLabel.snp.makeConstraints { make in
            make.top.equalTo(btnStartTask.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
        }
        
        pomodoroCycle.snp.makeConstraints { make in
            make.top.equalTo(taskScheduleLabel.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
        }
        
        workDuration.snp.makeConstraints { make in
            make.top.equalTo(pomodoroCycle.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        shortBreakDuration.snp.makeConstraints { make in
            make.top.equalTo(workDuration.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        longBreakDuration.snp.makeConstraints { make in
            make.top.equalTo(shortBreakDuration.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        whiteNoiseView.snp.makeConstraints { make in
            make.top.equalTo(longBreakDuration.snp.bottom).offset(16)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
        
        btnMarkDoneTask.snp.makeConstraints { make in
            make.top.equalTo(whiteNoiseView.snp.bottom).offset(40)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        btnDeleteTask.snp.makeConstraints { make in
            make.top.equalTo(btnMarkDoneTask.snp.bottom).offset(20)
            make.width.equalToSuperview().offset(-300)
            make.centerX.equalToSuperview()
            make.height.equalTo(22)
        }

    }
    
    @objc func onClickDoneTask () {
        
    }

}