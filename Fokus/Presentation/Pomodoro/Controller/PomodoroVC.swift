//
//  PomodoroViewController.swift
//  Fokus
//
//  Created by fachry adhitya on 30/11/22.
//

import UIKit
import SnapKit
import MagicTimer

class PomodoroVC: UIViewController {
    
    public var task:TaskModel?
    private var vm = PomodoroViewModel()
    
    var muteOrUnmuteSymbol = String("unmuteVolumeLogo")
    var currentProgress = 1
    var currentPhase = 1
    var secondsRemaining = 0
    var timer:Timer?
    
    let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    
    enum TimerEnum {
        case running, paused
    }
    
    var timerState: TimerEnum?
    
    
    let pomodoroPhase: UILabel = {
        
        let ctx = UILabel()
        
        ctx.text = "1 / 4"
        ctx.font = .atkinsonRegular(size: 24)
        ctx.textColor = UIColor(hexString: "#FEFEFE")
        return ctx
    }()
    
    let pomodoroContainer: UIView = {
        let ctx = UIView()
        //        ctx.layer.borderColor = UIColor.red.cgColor
        //        ctx.layer.borderWidth = 1
        return ctx;
    }()
    
    var pomodoroLabel :UILabel = {
        let ctx = UILabel()
        ctx.text = "Work Phase"
        ctx.textColor = .turq
        ctx.font = .atkinsonRegular(size: 24)
        return ctx
    }()
    
    var pomodoroTimer: UILabel = {
        let ctx = UILabel()
        ctx.font = .atkinsonBold(size: 64)
        ctx.text = "10:24"
        return ctx
    }()
    
    let symbolContainer: UIView = {
        let ctx = UIView()
        
//        ctx.layer.borderWidth = 1
//        ctx.layer.borderColor = UIColor.yellow.cgColor
        
        return ctx
    }()
    
    let stopSymbol: UIButton = {
        let ctx = UIButton()
        ctx.setImage(UIImage(named: "stopLogo"), for: .normal)
        return ctx
    }()
    
    let skipSymbol: UIButton = {
        let ctx = UIButton()
        ctx.setImage(UIImage(named: "skipLogo"), for: .normal)
        return ctx
    }()
    
    let pauseSymbol: UIButton = {
        let ctx = UIButton()
        ctx.setImage(UIImage(named: "pauseLogo"), for: .normal)
        return ctx
    }()
    
    let muteSymbol: UIButton = {
        let ctx = UIButton()
        ctx.setImage(UIImage(named: "unmuteVolumeLogo"), for: .normal)
        return ctx
    }()
    
    let timerLib = MagicTimerView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blackFokus
        
        pomodoroPhase.text = "\(currentPhase) / \(task!.pomodoros!)"
        pomodoroTimer.text = "\(task!.work!):00"
        pomodoroLabel.text = "Work Phase"
        
        timerLib.delegate = self
        
     
        secondsRemaining = (task?.work as! Int)
        timerState = TimerEnum.running
        
        timerLib.isActiveInBackground = true
        timerLib.font = .atkinsonBold(size: 64)
        timerLib.textColor = .white
        timerLib.mode = .countDown(fromSeconds: TimeInterval(secondsRemaining))
        timerLib.startCounting()

        
//        muteSymbol.addTarget(self, action: #selector(nextProgress), for: .touchUpInside)
        pauseSymbol.addTarget(self, action: #selector(pauseTimer), for: .touchUpInside)
        skipSymbol.addTarget(self, action: #selector(skipPhase), for: .touchUpInside)
        stopSymbol.addTarget(self, action: #selector(stopPomodoro), for: .touchUpInside)
        
        view.addSubview(pomodoroPhase)
        
        
        pomodoroContainer.addSubview(pomodoroLabel)
        pomodoroContainer.addSubview(pomodoroTimer)
        pomodoroContainer.addSubview(timerLib)
        
        symbolContainer.addSubview(stopSymbol)
        symbolContainer.addSubview(skipSymbol)
        symbolContainer.addSubview(pauseSymbol)
        
        pomodoroContainer.addSubview(symbolContainer)
        
        view.addSubview(pomodoroContainer)
        view.addSubview(muteSymbol)
        
        setupConstraint()
//        startTimer()

    }
    
    private func setupConstraint() {
        pomodoroPhase.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }

        pomodoroContainer.snp.makeConstraints { make in
            make.top.equalTo(pomodoroPhase.snp.bottom).offset(140)
            make.width.equalToSuperview()
            make.height.equalTo(197)
        }

        pomodoroLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()

        }
        
        timerLib.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pomodoroLabel.snp.bottom).offset(24)
        }

//        pomodoroTimer.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(pomodoroLabel.snp.bottom).offset(24)
//        }

        symbolContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(timerLib.snp.bottom).offset(30)
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(40)
        }

        skipSymbol.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }

        stopSymbol.snp.makeConstraints { make in
            make.right.equalTo(skipSymbol.snp.left).offset(-40)
        }

        pauseSymbol.snp.makeConstraints { make in
            make.left.equalTo(skipSymbol.snp.right).offset(40)
        }

        muteSymbol.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            //            make.width.equalToSuperview()
            make.top.equalTo(pomodoroContainer.snp.bottom).offset(280)
        }
    }
    
    
    @objc func nextProgress() {
        
        if (currentPhase == task?.pomodoros as! Int) {
            timerLib.stopCounting()
            self.vm.markAsDone(id: task!.id ?? "")
            let controller = HomeVC()
            navigationController?.pushViewController(controller, animated: true)
            return
        }
        
        currentProgress += 1
        
        
        if (currentProgress % 4 == 0) {
            pomodoroLabel.text = "Long Break"
            secondsRemaining = task?.longBreak as! Int

        }
        else if(currentProgress % 2 == 0) {
            pomodoroLabel.text = "Short Break"
            secondsRemaining = task?.shortBreak as! Int
        } else {
            if (currentProgress != 1) {
                currentPhase += 1
            }
            pomodoroLabel.text = "Work Phase"
            secondsRemaining = task?.work as! Int
        }

        timerLib.mode = .countDown(fromSeconds: TimeInterval(secondsRemaining))
        timerLib.isActiveInBackground = true
        timerLib.startCounting()
        pomodoroPhase.text = "\(currentPhase) / \(task!.pomodoros!)"
        
    }
    
    
    @objc func pauseTimer() {
        
        if (timerState == TimerEnum.running) {
            timerState = TimerEnum.paused
            timerLib.stopCounting()
        } else {
            timerState = TimerEnum.running
            timerLib.mode = .countDown(fromSeconds: TimeInterval(secondsRemaining))
            timerLib.isActiveInBackground = true
            timerLib.startCounting()
        }
        
    }
    
    @objc func skipPhase() {
        nextProgress()
    }
    
    @objc func stopPomodoro() {
        timerLib.stopCounting()
        let controller = HomeVC()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension PomodoroVC: MagicTimerViewDelegate {
    func timerElapsedTimeDidChange(timer: MagicTimerView, elapsedTime: TimeInterval) {
        
//        print(elapsedTime)
        if (elapsedTime > 0) {
            self.secondsRemaining -= 1
        }
        
        if (elapsedTime == 0) {
            nextProgress()
        }
    }
}
