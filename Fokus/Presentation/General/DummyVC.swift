//
//  DummyVC.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 16/11/22.
//

import UIKit
import SnapKit
import TTGTags

class DummyVC: UIViewController {

    private var durationTags: OptionsCollectionView!
    private var whiteNoiseSection: OptionsCollectionView!
    private var counterView = CounterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blackFokus
        durationTags = OptionsCollectionView(title: "Estimated Pomodoros", options: ["15:00","20:00","25:00","30:00"])
        
        whiteNoiseSection = OptionsCollectionView(title: "White Noise")
        
        whiteNoiseSection.addOption(text: "ON")
        whiteNoiseSection.addOption(text: "OFF")
        
        view.addSubview(durationTags)
        view.addSubview(whiteNoiseSection)
        view.addSubview(counterView)
        
        configureConstraints()
    }
    
    func configureConstraints(){
        durationTags.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-40)
            make.center.equalToSuperview()
            make.height.equalTo(durationTags.height)
        }
        
        whiteNoiseSection.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-40)
            make.top.equalTo(durationTags.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(durationTags.height)
        }
        
        counterView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(durationTags.snp.top).offset(-20)
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(counterView.height)
        }

    }
    
}
