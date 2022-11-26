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
    
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: UIScreen.main.bounds.height)
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: 888)
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
        navigationController?.navigationBar.isHidden = true
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blackFokus
        
        // Add onclick to reminder's options
        // to show datetime picker
        
        if let yesReminder = reminderView.buttonStack.arrangedSubviews.first as? UIButton {
            
            yesReminder.addTarget(self, action: #selector(turnOnReminder), for: .touchUpInside)
        }
        
        if let noReminder = reminderView.buttonStack.arrangedSubviews.last as? UIButton {
            
            noReminder.addTarget(self, action: #selector(turnOffReminder), for: .touchUpInside)
        }
        
        // Set DateTimePicker delegate
        dateTimePicker.delegate = self
    
        let components = [titleLabel, titleTextField, pomodoroLabel, pomodoroCounter, workDurationView, shortDurationView, longDurationView, whiteNoiseView, reminderView, reminderDateLabel, createTaskButton]
        
        view.addSubview(scrollView)
        
        components.forEach { subview in
            scrollView.addSubview(subview)
        }
        
        configureConstraints()
    }
    
    func configureConstraints(){
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
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
        
        createTaskButton.snp.makeConstraints { make in
            make.height.equalTo(createTaskButton.frame.height)
        }
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
