//
//  ProfileView.swift
//  Fokus
//
//  Created by fachry adhitya on 19/11/22.
//

import UIKit
import SnapKit

class ProfileView: UIView {
    
    let badgePlaceholder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#1b1b1b")
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        return view
    }()
    
    let userName: UILabel = {
        
        let name = UILabel()
        name.text = "Hi, Fachry ☺️"
        name.textColor = .white
        name.font = UIFont.systemFont(ofSize: 17)
        
        return name
        
    }()
    
    let levelLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Level 3"
        label.textColor = .darkTurq
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        return label
    }()
    
    let progressBar: UIProgressView = {
        let ctx = UIProgressView()
        
        ctx.layer.cornerRadius = 4
        ctx.progress = 0.5
        ctx.progressTintColor = UIColor.turq
        ctx.clipsToBounds = true
        ctx.progressViewStyle = .bar
        ctx.backgroundColor = .white
        return ctx
    }()
    
    let xpLabel: UILabel = {
        let label = UILabel()
        
//        label.text = "123 / 1000 xp"
//        label.textColor = .darkTurq
        
        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: "123 ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]));
        text.append(NSAttributedString(string: " / 1000 xp", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkTurq]))
        
        label.attributedText = text
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        
        return label
    }()

    
    let profileSectionView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .red
                
        return view
    }()
    
    public let width = 100
    public let height = 300
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.white.cgColor
        
        addSubview(badgePlaceholder)
        profileSectionView.addSubview(userName)
        profileSectionView.addSubview(levelLabel)
        profileSectionView.addSubview(progressBar)
        profileSectionView.addSubview(xpLabel)

        addSubview(profileSectionView)

        setupConstraint()
    }
    
    
    private func setupConstraint() {
        badgePlaceholder.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        
        profileSectionView.snp.makeConstraints { make in
            make.left.equalTo(badgePlaceholder.snp.right).offset(20)
            make.right.equalToSuperview()
            make.top.equalTo(30)
        }
        
        userName.snp.makeConstraints { make in
            make.left.equalToSuperview()
        }
        
        levelLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(userName.snp.bottom).offset(8)
        }
        
        progressBar.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(levelLabel.snp.bottom).offset(8)
            make.height.equalTo(8)
            make.right.equalToSuperview().offset(-16)
        }
        
        xpLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(progressBar.snp.bottom).offset(8)
        }

    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
