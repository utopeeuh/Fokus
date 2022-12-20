//
//  ProfileView.swift
//  Fokus
//
//  Created by fachry adhitya on 19/11/22.
//

import UIKit
import SnapKit

protocol ProfileViewDelegate {
    func editNameOnClick()
}

class ProfileView: UIView {
    
    public var delegate: ProfileViewDelegate?
    
    let badgePlaceholder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#1b1b1b")
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        return view
    }()
    
    let userName: UILabel = {
        
        let name = UILabel()
        name.text = "Hi, User 😊"
        name.textColor = .white
        name.font = .atkinsonBold(size: 24)
        
        return name

    }()
    
    let editButton: UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage(named: "editIcon"), for: .normal)
        return button
        
    }()
    
    let levelLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Level 3"
        label.textColor = .darkTurq
        label.font = .atkinsonBold(size: 18)
        
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
        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: "123", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]));
        text.append(NSAttributedString(string: "/1000 xp", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkTurq]))
        
        label.attributedText = text
        label.font = .atkinsonRegular(size: 16)
        
        return label
    }()

    
    let profileSectionView = UIView()
    
    public let height = 128
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        editButton.addTarget(self, action: #selector(editNameOnClick), for: .touchUpInside)
        
        addSubview(badgePlaceholder)
        profileSectionView.addSubview(userName)
        profileSectionView.addSubview(editButton)
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
            make.centerY.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(191)
        }
        
        userName.snp.makeConstraints { make in
            make.left.equalToSuperview()
        }
        
        editButton.snp.makeConstraints { make in
            make.left.equalTo(userName.snp.right).offset(20)
            make.centerY.equalTo(userName)
        }
        
        levelLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(userName.snp.bottom).offset(8)
        }
        
        progressBar.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(levelLabel.snp.bottom).offset(8)
            make.height.equalTo(4)
            make.right.equalToSuperview().offset(-16)
        }
        
        xpLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(progressBar.snp.bottom).offset(8)
        }

    }

    @objc func editNameOnClick(){
        delegate?.editNameOnClick()
    }
    
    func refreshUserData(){
        let user = UserRepository.shared.fetchUser()
        if user == nil {
            return
        }
        userName.text = "Hi, \(user!.name!) 😊"
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
