//
//  CreateTaskVC.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 26/11/22.
//

import Foundation
import UIKit
import SnapKit
import DateTimePicker

class CreateTaskVC: UIViewController {
    
    private var taskVm = TaskViewModel()
    private var statsVm = StatsViewModel()
    
    public var isEditTask: Bool = false
    public var task:TaskModel?
    
    public var editCompletion : ((_ editedTask: TaskModel) -> Void)?
    
    private var navbar: Navbar = {
        let navbar = Navbar(title: "Create task")
        return navbar
    }()
    
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: UIScreen.main.bounds.height)
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: 928)
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let titleLabel : SubHeadLabel = {
        let label = SubHeadLabel(size: .large)
        label.text = "Title"
        return label
    }()
    
    private let titleTextField = TitleTextField()
    
    private let pomodoroLabel : SubHeadLabel = {
        let label = SubHeadLabel(size: .large)
        label.text = "Estimated Pomodoros"
        return label
    }()
    
    private let pomodoroCounter = CounterView()
    
    private let workDurationView : OptionsCollectionView = {
        let collectionView = OptionsCollectionView(title: "Work Duration", options: ["20:00", "25:00", "30:00", "35:00"])
        collectionView.selectedIndex = 1
        return collectionView
    }()
    
    private let shortDurationView : OptionsCollectionView = {
        let collectionView = OptionsCollectionView(title: "Short Break Duration", options: ["5:00", "10:00", "15:00", "20:00"])
        collectionView.selectedIndex = 1
        return collectionView
    }()
    
    private let longDurationView : OptionsCollectionView = {
        let collectionView = OptionsCollectionView(title: "Long Break Duration", options: ["20:00", "25:00", "30:00", "35:00"])
        collectionView.selectedIndex = 1
        return collectionView
    }()
    
    private let whiteNoiseView : OptionsCollectionView = {
        let collectionView = OptionsCollectionView(title: "White Noise", options: ["ON", "OFF"])
        collectionView.selectedIndex = 0
        return collectionView
    }()
    
    
    private let reminderView : OptionsCollectionView = {
        let collectionView = OptionsCollectionView(title: "Date & Time Reminder", options: ["ON", "OFF"])
        collectionView.selectedIndex = 1
        return collectionView
    }()
    
    private let reminderDateLabel : UILabel = {
        let label = UILabel()
        label.font = .atkinsonRegular(size: .large)
        label.textColor = .whiteFokus
        label.alpha = 0
        return label
    }()
    
    private let dateTimePicker : DateTimePicker = {
        let min = Date()
        let max = Date().addingTimeInterval(60 * 60 * 24 * 30 * 6)
        let picker = DateTimePicker.create(minimumDate: min, maximumDate: max)
        picker.frame = CGRect(x: 0, y: 100, width: picker.frame.size.width, height: picker.frame.size.height)
        
        picker.dateFormat = "hh:mm a - dd MMM YYYY"
        picker.is12HourFormat = true
        picker.includesMonth = true
        picker.doneButtonTitle = "Set reminder"
        picker.highlightColor = .turq
        picker.darkColor = .whiteFokus
        picker.contentViewBackgroundColor = .darkGrey
        picker.doneBackgroundColor = .turq
        picker.daysBackgroundColor = .darkGrey
        picker.titleBackgroundColor = .darkGrey
        
        picker.customFontSetting = DateTimePicker.CustomFontSetting(cancelButtonFont: .atkinsonRegular(size: .medium)!, todayButtonFont: .atkinsonRegular(size: .medium)!, doneButtonFont: .atkinsonRegular(size: .medium)!, selectedDateLabelFont: .atkinsonRegular(size: .large)!, timeLabelFont: .atkinsonRegular(size: .medium)!, colonLabelFont: .atkinsonRegular(size: .large)!, dateCellNumberLabelFont: .atkinsonRegular(size: .medium)!, dateCellDayMonthLabelFont: .atkinsonRegular(size: .small)!)
        return picker
    }()
    
    private let createTaskButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Create task 📝", for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: 60)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.turq.cgColor
        btn.layer.cornerRadius = 8
        btn.setTitleColor(.turq, for: .normal)
        return btn
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Create Task"
        view.backgroundColor = .blackFokus
        
        // Add onclick to reminder's options
        // to show datetime picker
        
        if let yesReminder = reminderView.buttonStack.arrangedSubviews.first as? UIButton {
            
            yesReminder.addTarget(self, action: #selector(turnOnReminder), for: .touchUpInside)
        }
        
        if let noReminder = reminderView.buttonStack.arrangedSubviews.last as? UIButton {
            
            noReminder.addTarget(self, action: #selector(turnOffReminder), for: .touchUpInside)
        }
        
        if (isEditTask) {
            
            let pomodoro = taskVm.getPomodoro(task: task!)
            
            let workDuration = [20, 25, 30, 35]
            let shortDuration = [5, 10, 15, 20]
            
            let workIndex = workDuration.firstIndex(of: Int(truncating: pomodoro?.workDuration ?? 20))
            let longIndex = workDuration.firstIndex(of: Int(truncating: pomodoro?.workDuration ?? 20))
            let shortIndex = shortDuration.firstIndex(of: Int(truncating: pomodoro?.shortBreakDuration ?? 20))
            
            navbar = Navbar(title: "Edit task")
            titleLabel.text = "Edit Task"
            titleTextField.text = task?.title
            createTaskButton.setTitle("Edit Task 📝", for: .normal)
            workDurationView.selectedIndex = workIndex
            longDurationView.selectedIndex = longIndex
            shortDurationView.selectedIndex = shortIndex
            pomodoroCounter.counter = Int(truncating: pomodoro?.cycles ?? 0)
            whiteNoiseView.selectedIndex = pomodoro?.isWhiteNoiseOn == true ? 0 : 1
            
            if (task?.reminder != nil) {
                reminderView.selectedIndex = 0
                dateTimePicker.selectedDate = task!.reminder!
                
                let yesButton  = self.reminderView.buttonStack.arrangedSubviews.first as? UIButton
                yesButton?.setTitle("CHANGE DATE", for: .normal)
                
                reminderDateLabel.alpha = 1
                reminderDateLabel.text = "Reminder set for \(dateTimePicker.selectedDateString)"
            }
        }
        
        // Set DateTimePicker delegate
        dateTimePicker.delegate = self
        
        // Create task onclick
        createTaskButton.addTarget(self, action: #selector(createTaskOnClick), for: .touchUpInside)
        
        let components = [navbar, titleLabel, titleTextField, pomodoroLabel, pomodoroCounter, workDurationView, shortDurationView, longDurationView, whiteNoiseView, reminderView, reminderDateLabel, createTaskButton]
        
        view.addSubview(scrollView)
        
        components.forEach { subview in
            scrollView.addSubview(subview)
        }
        
        // Add alert on back
        let cancelAction = UIAlertAction(title: "Batal", style: .default)
        let backAction = UIAlertAction(title: "Kembali ke home", style: .cancel) { (_) in
            self.navigationController?.popViewController(animated: true)
        }
        navbar.addAlertOnBack(title: "Apakah anda yakin ingin kembali? Hal yang belum disimpan tidak dapat dikembalikan", actions: [cancelAction, backAction])
        
        configureConstraints()
    }
    
    func configureConstraints(){
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.subviews.forEach { subview in
            subview.snp.makeConstraints { make in
                if scrollView.subviews.first == subview {
                    
                    // Align to safe area if top
                    make.top.equalToSuperview()
                }
                else {
                    
                    // Align to bottom of previous view
                    let index = scrollView.subviews.firstIndex{$0 === subview}
                    
                    make.top.equalTo(scrollView.subviews[index!-1].snp.bottom).offset(20)
                }
                
                make.width.equalToSuperview().offset(-40)
                make.centerX.equalToSuperview()
            }
        }
        
        navbar.snp.makeConstraints { make in
            make.height.equalTo(navbar.frame.height)
            make.width.equalToSuperview()
        }
        
        createTaskButton.snp.makeConstraints { make in
            make.height.equalTo(createTaskButton.frame.height)
        }
    }
    
    @objc func createTaskOnClick(){
        if titleTextField.text == "" {
            createTaskButton.shake(count: 3, for: 0.1, withTranslation: 5)
            return
        }
        
        let reminderDate = reminderView.selectedOption == "OFF" ? nil : dateTimePicker.selectedDate
        
        if (isEditTask) {
            
            guard let newTask = taskVm.editTask(id: task!.id, title: titleTextField.text!, reminder: reminderDate, cycles: pomodoroCounter.counter as NSNumber, work: workDurationView.selectedOption, shortBreak: shortDurationView.selectedOption, longBreak: longDurationView.selectedOption, whiteNoise: whiteNoiseView.selectedOption)
            
            else {
                navigationController?.popToRootViewController(animated: true)
                return
            }
            
            if reminderDate != nil {
                NotificationManager.shared.createTaskNotif(task: newTask, reminderDate: reminderDate!)
            }
            
            editCompletion?(newTask)
            
        } else {
            guard let newTask = taskVm.createTask(title: titleTextField.text!, reminder: reminderDate, cycles: pomodoroCounter.counter as NSNumber, work: workDurationView.selectedOption, shortBreak: shortDurationView.selectedOption, longBreak: longDurationView.selectedOption, whiteNoise: whiteNoiseView.selectedOption) else { return }
            
            guard let newPomodoro = taskVm.getPomodoro(task: newTask) else { return }
            
            if reminderDate != nil {
//                NotificationManager.shared.createTaskNotif(taskTitle: titleTextField.text!, reminderDate: reminderDate!)
                NotificationManager.shared.createTaskNotif(task: newTask, reminderDate: reminderDate!)

            }
            
            statsVm.addCreatedTaskToStats(task: newTask, pomodoro: newPomodoro)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y HH:mm"
        return formatter.string(from: date)
    }
    
    @objc func turnOnReminder(){
        dateTimePicker.show()
        UIView.animate(withDuration: 0.2) {
            self.reminderDateLabel.alpha = 1
            
            let yesButton  = self.reminderView.buttonStack.arrangedSubviews.first as? UIButton
            
            yesButton?.setTitle("CHANGE DATE", for: .normal)
        }
        
        reminderDateLabel.text = "Reminder set for \(dateTimePicker.selectedDateString)"
    }
    
    @objc func turnOffReminder(){
        UIView.animate(withDuration: 0.2) {
            self.reminderDateLabel.alpha = 0
            
            let yesButton  = self.reminderView.buttonStack.arrangedSubviews.first as? UIButton
            
            yesButton?.setTitle("ON", for: .normal)
        }
    }
}

extension CreateTaskVC: DateTimePickerDelegate{
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date) {
        reminderDateLabel.text = "Reminder set for \(dateTimePicker.selectedDateString)"
    }
} 
