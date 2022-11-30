//
//  PomodoroViewController.swift
//  Fokus
//
//  Created by fachry adhitya on 30/11/22.
//

import UIKit
import SnapKit

class PomodoroViewController: UIViewController {
    
    var muteOrUnmuteSymbol = String("unmuteVolumeLogo")
    
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
    
    let pomodoroLabel :UILabel = {
        let ctx = UILabel()
        ctx.text = "Work Phase"
        ctx.textColor = .turq
        ctx.font = .atkinsonRegular(size: 24)
        return ctx
    }()
    
    let pomodoroTimer: UILabel = {
        let ctx = UILabel()
        ctx.font = .atkinsonBold(size: 64)
        ctx.text = "10:24"
        return ctx
    }()
    
    let symbolContainer: UIView = {
        let ctx = UIView()
        
        ctx.layer.borderWidth = 1
        ctx.layer.borderColor = UIColor.yellow.cgColor
        
        return ctx
    }()
    
    let stopSymbol: UIImageView = {
        let ctx = UIImageView(image: UIImage(named: "stopLogo"))
        return ctx
    }()
    
    let startSymbol: UIImageView = {
        let ctx = UIImageView(image: UIImage(named: "skipLogo"))
        return ctx
    }()
    
    let pauseSymbol: UIImageView = {
        let ctx = UIImageView(image: UIImage(named: "pauseLogo"))
        return ctx
    }()
    
    let muteSymbol: UIImageView = {
        let ctx = UIImageView(image: UIImage(named: "unmuteVolumeLogo"))
        return ctx
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pomodoroPhase)
        
        pomodoroContainer.addSubview(pomodoroLabel)
        pomodoroContainer.addSubview(pomodoroTimer)
        
        symbolContainer.addSubview(stopSymbol)
        symbolContainer.addSubview(startSymbol)
        symbolContainer.addSubview(pauseSymbol)
        
        pomodoroContainer.addSubview(symbolContainer)
        
        view.addSubview(pomodoroContainer)
        view.addSubview(muteSymbol)
        
        setupConstraint()
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
        
        pomodoroTimer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pomodoroLabel.snp.bottom).offset(24)
        }
        
        symbolContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pomodoroTimer.snp.bottom).offset(30)
        }
        
        startSymbol.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
        
        stopSymbol.snp.makeConstraints { make in
            make.right.equalTo(startSymbol.snp.left).offset(-40)
        }
        
        pauseSymbol.snp.makeConstraints { make in
            make.left.equalTo(startSymbol.snp.right).offset(40)
        }
        
        muteSymbol.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            //            make.width.equalToSuperview()
            make.top.equalTo(pomodoroContainer.snp.bottom).offset(280)
        }
    }
    
}
