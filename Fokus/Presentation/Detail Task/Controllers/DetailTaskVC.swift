//
//  DetailTaskVC.swift
//  Fokus
//
//  Created by Firzha Ardhia Ramadhan on 30/11/22.
//

import UIKit
import SnapKit

class DetailTaskVC: UIViewController {
    
    public var task: TaskModel!
    public var pomodoro: PomodoroModel!
    
    private var taskVm = TaskViewModel()
    private var levelVm = LevelViewModel()
    private var statsVm = StatsViewModel()
    
    private var pomodoroCycle = PomodoroDetail(title: "Pomodoro", value: "")
    private var workDuration = PomodoroDetail(title: "Kerja", value: "")
    private var shortBreakDuration = PomodoroDetail(title: "Istirahat Pendek", value: "")
    private var longBreakDuration = PomodoroDetail(title: "Istirahat Panjang", value: "")

    private let navbar: Navbar = {
        let navbar = Navbar(title: "Detil task")
        return navbar
    }()

    private let whiteNoiseView : OptionsCollectionView = {
        let collectionView = OptionsCollectionView(title: "White Noise", options: ["ON", "OFF"])
        collectionView.selectedIndex = 0
        return collectionView
    }()
    
    private let btnStartTask: UIButton = {
        let btn = UIButton()
        btn.setTitle("Mulai", for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.turq.cgColor
        btn.layer.cornerRadius = 60
        btn.setTitleColor(.turq, for: .normal)
        return btn
    }()
    
    private let btnMarkDoneTask: UIButton = {
        let btn = UIButton()
        btn.setTitle("Selesai 📝", for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.turq.cgColor
        btn.layer.cornerRadius = 8
        btn.setTitleColor(.turq, for: .normal)
        return btn
    }()
    
    private let btnDeleteTask: UIButton = {
        let btn = UIButton()
        btn.setTitle("Hapus task", for: .normal)
        btn.setTitleColor(.systemRed, for: .normal)
        btn.backgroundColor = UIColor.clear
        return btn
    }()

    
    private let taskTitle: UILabel = {
        let title = UILabel()
        title.font = .atkinsonRegular(size: 24)
        return title
    }()
    
    private let taskScheduleLabel: UILabel = {
        let title = UILabel()
        title.font = .atkinsonRegular(size: 16)
        return title
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blackFokus
        
        pomodoro = taskVm.getPomodoro(task: task)
        
        loadTask()
        
        navbar.isRightBarItemEnabled = true
        navbar.barItemTitle = "Ubah"
        navbar.delegate = self
        
        whiteNoiseView.delegate = self

        btnStartTask.addTarget(self, action: #selector(onClickStart), for: .touchDown)
        btnMarkDoneTask.addTarget(self, action: #selector(onClickDoneTask), for: .touchUpInside)
        btnDeleteTask.addTarget(self, action: #selector(onClickDeleteTask), for: .touchUpInside)
        
        view.addSubview(taskTitle)
        view.addSubview(btnStartTask)
        view.addSubview(taskScheduleLabel)
        view.addSubview(pomodoroCycle)
        view.addSubview(workDuration)
        view.addSubview(shortBreakDuration)
        view.addSubview(longBreakDuration)
        view.addSubview(whiteNoiseView)
        view.addSubview(navbar)
        
        view.addSubview(btnMarkDoneTask)
        view.addSubview(btnDeleteTask)

        configureConstraints()
        
        checkIfTaskDone()
    }
    
    func configureConstraints(){
        
        navbar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
                
        taskTitle.snp.makeConstraints { make in
            make.top.equalTo(navbar.snp.bottom).offset(20)
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
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(22)
        }
    }
    
    func loadTask(){
        taskTitle.text = task?.title
        
        if task?.reminder != nil {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a, dd MMM YYYY"
            taskScheduleLabel.text = formatter.string(from: (task?.reminder)!)
        }
        
        else {
            taskScheduleLabel.text = "Tidak ada reminder untuk task ini"
            taskScheduleLabel.textColor = .lightGrey
        }
        
        pomodoroCycle.setDetailValue(value: "\(pomodoro.cycles!) Cycles")
        workDuration.setDetailValue(value: "\( pomodoro.workDuration!):00")
        shortBreakDuration.setDetailValue(value: "\( pomodoro.shortBreakDuration!):00")
        longBreakDuration.setDetailValue(value: "\( pomodoro.longBreakDuration!):00")
        
        whiteNoiseView.selectedIndex = (pomodoro.isWhiteNoiseOn == true) ? 0 : 1
    }
    
    @objc func onClickDoneTask() {
        let alert = UIAlertController(title: "Apakah anda yakin untuk menandai task sebagai selesai?", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Tandai sebagai selesai", style: .default, handler: { [self] (_) in
            
            taskVm.markAsDone(id: task!.id, timeSpent: 0)
            levelVm.addUserXp(xp: levelVm.calculateTaskXp(pomodoro: pomodoro, isPomdoroUsed: false))
            statsVm.addFinishedTaskToStats(task: task!, pomodoro: pomodoro)
            
            navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Batal", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func onClickDeleteTask() {
        let alert = UIAlertController(title: "Apakah anda yakin untuk menghapus task?", message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Hapus", style: .destructive, handler: { (_) in
            self.taskVm.deleteTask(id: self.task!.id)
            self.navigationController?.popViewController(animated: true)
        }))

        alert.addAction(UIAlertAction(title: "Batal", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    @objc func onClickStart() {
        let controller = PomodoroVC()
        controller.task = task
        controller.pomodoro = pomodoro
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func checkIfTaskDone(){
        if task?.dateFinished == nil {
            return
        }
        
        btnStartTask.layer.borderColor = UIColor.lightGrey.cgColor
        btnStartTask.setTitleColor(.lightGrey, for: .normal)
        btnStartTask.isEnabled = false
        
        btnMarkDoneTask.setTitle("Ulangi task 📝", for: .normal)
        btnMarkDoneTask.removeTarget(self, action: #selector(onClickDoneTask), for: .touchUpInside)
        btnMarkDoneTask.addTarget(self, action: #selector(redoTask), for: .touchUpInside)
    }
    
    @objc func redoTask(){
        
        // Duplicate task, no need to refresh display as it is the same
        task = taskVm.duplicateTask(task: task!)
        
        btnStartTask.layer.borderColor = UIColor.turq.cgColor
        btnStartTask.setTitleColor(.turq, for: .normal)
        btnStartTask.isEnabled = true
        
        btnMarkDoneTask.setTitle("Selesai 📝", for: .normal)
        btnMarkDoneTask.removeTarget(self, action: #selector(redoTask), for: .touchUpInside)
        btnMarkDoneTask.addTarget(self, action: #selector(onClickDoneTask), for: .touchUpInside)
    }
}

extension DetailTaskVC: OptionsCollectionViewDelegate {
    func didTapButton(tappedButton button: OptionButton) {
        let isOn : Bool = button.titleLabel?.text?.lowercased() == "on" ? true : false
        taskVm.toggleWhiteNoise(id: pomodoro!.id, isOn: isOn)
    }
}

extension DetailTaskVC: NavbarDelegate {
    func rightBarItemOnClick() {
        let controller = CreateTaskVC()
        
        controller.isEditTask = true
        controller.task = task
        
        controller.editCompletion = {[self] newTask in
            task = newTask
            loadTask()
        }
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
