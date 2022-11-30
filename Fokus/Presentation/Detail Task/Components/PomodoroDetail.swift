//
//  PomodoroDetail.swift
//  Fokus
//
//  Created by Firzha Ardhia Ramadhan on 29/11/22.
//

import UIKit

class PomodoroDetail: UIView {
    
    let cyclePomodoroLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Pomodoros"
        label.textColor = .turq
        label.font = .atkinsonRegular(size: 18)
        
        return label
    }()

    let cyclePomodoroTick: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGrey
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    let cyclePomodoroVal: UILabel = {
        let label = UILabel()
        
        label.text = "4 Cycles"
        label.textColor = .white
        label.font = .atkinsonRegular(size: 18)
        return label
    }()
    
    let pomodoroSectionView = UIView()
    
    required init(title: String, value: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: 20))
        
        cyclePomodoroLabel.text = title
        cyclePomodoroVal.text = value
        
        addSubview(cyclePomodoroLabel)
        addSubview(cyclePomodoroTick)
        addSubview(cyclePomodoroVal)
        
//        pomodoroSectionView.backgroundColor = .systemRed

        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupConstraint() {
        self.snp.makeConstraints { make in
            make.width.equalTo(self.frame.width)
            make.height.equalTo(self.frame.height)
        }
        
        cyclePomodoroLabel.snp.makeConstraints { make in
            make.left.centerY.equalToSuperview()
//            make.centerY.equalToSuperview()
//            make.width.equalTo(100)
//            make.height.equalTo(100)
            
        }
        
                
        cyclePomodoroTick.snp.makeConstraints { make in
            make.left.equalTo(cyclePomodoroLabel.snp.right).offset(20)
            make.right.equalTo(cyclePomodoroVal.snp.left).offset(-20)

//            make.top.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(1)
        }
        
        cyclePomodoroVal.snp.makeConstraints { make in
//            make.right.equalTo(pomodoroSectionView.snp.right)
//            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
//            make.centerY.equalToSuperview()
//            make.width.equalTo(100)
//            make.height.equalTo(100)
        }


    }
}
