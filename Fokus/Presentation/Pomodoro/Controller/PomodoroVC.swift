//
//  PomodoroViewController.swift
//  Fokus
//
//  Created by fachry adhitya on 30/11/22.
//

import UIKit
import SnapKit
import MagicTimer
import AVFoundation

class PomodoroVC: UIViewController {
    
    public var task: TaskModel?
    public var pomodoro: PomodoroModel?
    
    private var levelVm = LevelViewModel()
    private var pomodoroVm = PomodoroViewModel()
    
    var currentCycle = 1
    
    var timeSpent = 0
    
    enum PomodoroPhase {
        case workPhase, breakPhase
    }
    var currPhase : PomodoroPhase = .workPhase
    
    var secondsRemaining = 0
    
    var whiteNoisePlayer : AVAudioPlayer? = {
        do {
            let url = Bundle.main.url(forResource: "WhiteNoise", withExtension: "mp3")
            let player = try AVAudioPlayer(contentsOf: url!)
            player.prepareToPlay()
            player.volume = 0.05
            player.numberOfLoops = -1
            return player
        }
        catch {
            print("Load player error")
            return nil
        }
    }()
    var isNoiseMuted : Bool = true {
        didSet {
            configureNoisePlayback()
        }
    }
    
    enum TimerEnum {
        case running, paused
    }
    var timerState: TimerEnum?
    
    let pomodoroPhase: UILabel = {
        
        let ctx = UILabel()
        
        ctx.text = "1 / 4"
        ctx.font = .atkinsonRegular(size: 24)
        ctx.textColor = .whiteFokus
        return ctx
    }()
    
    let pomodoroContainer = UIView()
    
    var pomodoroLabel :UILabel = {
        let ctx = UILabel()
        ctx.text = "Fase Kerja"
        ctx.textColor = .turq
        ctx.font = .atkinsonRegular(size: 24)
        return ctx
    }()
    
    let symbolContainer = UIView()
    
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
        ctx.setImage(UIImage(named: "muteVolumeLogo"), for: .normal)
        return ctx
    }()
    
    let timerLib = MagicTimerView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blackFokus
        
        pomodoroPhase.text = "\(currentCycle) / \(pomodoro?.cycles ?? 0)"
        pomodoroLabel.text = "Fase Kerja"
        
        timerLib.delegate = self
     
        secondsRemaining = Int(truncating: pomodoro?.workDuration ?? 0)*60
        timerState = TimerEnum.running
        
        if (pomodoro?.isWhiteNoiseOn as! Bool) == true{
            soundOnClick()
        }
        
        timerLib.isActiveInBackground = true
        timerLib.font = .atkinsonBold(size: 64)
        timerLib.textColor = .white
        timerLib.mode = .countDown(fromSeconds: TimeInterval(secondsRemaining))
        timerLib.startCounting()

        pauseSymbol.addTarget(self, action: #selector(pauseTimer), for: .touchUpInside)
        skipSymbol.addTarget(self, action: #selector(skipPhase), for: .touchUpInside)
        stopSymbol.addTarget(self, action: #selector(cancelPomodoro), for: .touchUpInside)
        muteSymbol.addTarget(self, action: #selector(soundOnClick), for: .touchUpInside)

        view.addSubview(pomodoroPhase)
        
        pomodoroContainer.addSubview(pomodoroLabel)
        pomodoroContainer.addSubview(timerLib)
        
        symbolContainer.addSubview(stopSymbol)
        symbolContainer.addSubview(skipSymbol)
        symbolContainer.addSubview(pauseSymbol)
        
        pomodoroContainer.addSubview(symbolContainer)
        
        view.addSubview(pomodoroContainer)
        view.addSubview(muteSymbol)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        
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
            make.bottom.equalToSuperview().offset(-80)
        }
    }
    
    
    @objc func nextProgress() {
        
        if(currPhase == .workPhase) {
            
            currPhase = .breakPhase
            
            // Add work time to total
            let currWorkTime = Int(truncating: pomodoro?.workDuration ?? 0)*60 - secondsRemaining
            timeSpent += currWorkTime
            
            
            // If last cycle, stop after work
            if currentCycle == Int(truncating: pomodoro?.cycles ?? 0) {
                finishTask()
                return
            }
            
            // Long break every 4 cycles
            else if currentCycle % 4 == 0 {
                pomodoroLabel.text = "Istirahat Panjang"
                secondsRemaining = Int(truncating: pomodoro?.longBreakDuration ?? 0)
            }
            
            else {
                pomodoroLabel.text = "Istirahat Pendek"
                secondsRemaining = Int(truncating: pomodoro?.shortBreakDuration ?? 0)
            }
            
            pomodoroLabel.textColor = .lightGrey
        }
        
        else {
            currPhase = .workPhase
            
            pomodoroLabel.text = "Fase Kerja"
            pomodoroLabel.textColor = .turq
            
            secondsRemaining = Int(truncating: pomodoro?.workDuration ?? 0)
            
            // Move to next cycle
            currentCycle += 1
        }

        // Set timer
        timerLib.mode = .countDown(fromSeconds: TimeInterval(secondsRemaining*60))
        timerLib.isActiveInBackground = true
        timerLib.startCounting()
        pomodoroPhase.text = "\(currentCycle) / \(Int(truncating: pomodoro?.cycles ?? 0))"
    }
    
    
    @objc func pauseTimer() {
        
        if timerState == .running {
            
            pauseSymbol.setImage(UIImage(named: "playLogo"), for: .normal)
            timerState = .paused
            timerLib.stopCounting()
            
        }
        
        else {
            
            pauseSymbol.setImage(UIImage(named: "pauseLogo"), for: .normal)
            timerState = .running
            timerLib.mode = .countDown(fromSeconds: TimeInterval(secondsRemaining))
            timerLib.isActiveInBackground = true
            timerLib.startCounting()
            
        }
        
        configureNoisePlayback()
    }
    
    @objc func skipPhase() {
        let alert = UIAlertController(title: "Apakah anda yakin ingin melewati fase ini? Sabar adalah kunci untuk mencapai tujuan Anda!", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Lewati", style: .destructive, handler: { (_) in
            self.nextProgress()
        }))
        
        alert.addAction(UIAlertAction(title: "Batal", style: .cancel))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func finishTask(){
        
        // Task xp
        let xp = levelVm.calculateTaskXp(pomodoro: pomodoro!, isPomdoroUsed: true)
        
        // Show finish modal
        let modal = FinishTaskModalVC()
        modal.delegate = self
        modal.xp = xp
        
        // Update task as done and add user xp
        levelVm.addUserXp(xp: xp)
        pomodoroVm.markAsDone(id: (task?.id)!, timeSpent: timeSpent)
        
        // Show modal
        modal.modalPresentationStyle = .overCurrentContext
        self.present(modal, animated: true)
    }
    
    @objc func cancelPomodoro(){
        let alert = UIAlertController(title: "Anda akan kehilangan kesempatan untuk menyelesaikan tugas ini dengan baik. Yakin ingin membatalkan?", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Yakin", style: .destructive, handler: { (_) in
            self.stopPomodoro()
        }))
        
        alert.addAction(UIAlertAction(title: "Batal", style: .cancel))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func stopPomodoro() {
        timerLib.stopCounting()
        whiteNoisePlayer?.stop()
        navigationController?.popToRootViewController(animated: true)
    }

    @objc func soundOnClick() {
        isNoiseMuted = !isNoiseMuted
        
        if isNoiseMuted {
            muteSymbol.setImage(UIImage(named: "muteVolumeLogo"), for: .normal)
        }
        
        else{
            muteSymbol.setImage(UIImage(named: "unmuteVolumeLogo"), for: .normal)
        }
    }
    
    func configureNoisePlayback(){
        
        // Noise doesn't play if muted OR if timer is paused
        
        if isNoiseMuted {
            whiteNoisePlayer?.pause()
        }
        
        else {
            if timerState == .running {
                whiteNoisePlayer?.play()
            }
            else {
                whiteNoisePlayer?.pause()
            }
        }
    }
    
}

extension PomodoroVC: MagicTimerViewDelegate {
    func timerElapsedTimeDidChange(timer: MagicTimerView, elapsedTime: TimeInterval) {
        if (elapsedTime == 0) {
            nextProgress()
        }
        else {
            secondsRemaining -= 1
        }
    }
}

extension PomodoroVC: FinishTaskModalDelegate {
    func onModalClosed() {
        navigationController?.popToRootViewController(animated: true)
    }
}
