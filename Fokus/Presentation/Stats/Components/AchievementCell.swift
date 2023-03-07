//
//  AchievementCell.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 07/03/23.
//

import Foundation
import UIKit
import SnapKit

class AchievementCell : UITableViewCell {
    
    private var achContainer : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGrey
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.darkGrey.cgColor
        return view
    }()
    
    private var achTitle : UILabel = {
        let label = UILabel()
        label.text = "Achievement Title"
        label.font = .atkinsonBold(size: 16)
        label.textColor = .lightGrey
        label.textAlignment = .center
        return label
    }()
    
    private var achDesc : UILabel = {
        let label = UILabel()
        label.text = "Achievement Desc"
        label.font = .atkinsonRegular(size: 16)
        label.textColor = .lightGrey
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: "AchievementCell")
        
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(achContainer)
        addSubview(achTitle)
        addSubview(achDesc)
        
        achContainer.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalTo(68)
        }
        
        achTitle.snp.makeConstraints { make in
            make.top.equalTo(achContainer.snp.top).offset(12)
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
        
        achDesc.snp.makeConstraints { make in
            make.top.equalTo(achTitle.snp.bottom).offset(4)
            make.width.height.equalTo(achTitle)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAchievement(achievement: Achievement){
        achTitle.text = achievement.title
        achDesc.text = achievement.desc
        
        if achievement.isAccomplished {
            achTitle.textColor = .turq
            achDesc.textColor = .whiteFokus
            achContainer.layer.borderColor = UIColor.turq.cgColor
        }
    }
    
    override func prepareForReuse() {
        
        achContainer.layer.borderColor = UIColor.darkGrey.cgColor
        achTitle.textColor = .lightGrey
        achDesc.textColor = .lightGrey

    }
}
