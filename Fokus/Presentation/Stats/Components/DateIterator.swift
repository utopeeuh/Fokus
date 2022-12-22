//
//  DateIterator.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 06/12/22.
//

import Foundation
import UIKit
import SnapKit

protocol DateIteratorDelegate {
    /**
        Method is called every time the displayed date changes
     */
    func dateIterator(willDisplay date: Date)
}

class DateIterator: UIView {
    
    public var delegate: DateIteratorDelegate?
    
    private(set) var currDate: Date!
    
    private let arrowLeft : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "chevronLeft"), for: .normal)
        return button
    }()
    
    private let arrowRight : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "chevronRight"), for: .normal)
        return button
    }()
    
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.textColor = .turq
        label.font = .atkinsonRegular(size: .large)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
        backgroundColor = .darkGrey
        
        // Display initial date
        changeDate(date: Date())
        
        arrowLeft.addTarget(self, action: #selector(navigateDateOnClick), for: .touchUpInside)
        
        arrowRight.addTarget(self, action: #selector(navigateDateOnClick), for: .touchUpInside)
        
        addSubview(arrowLeft)
        addSubview(dateLabel)
        addSubview(arrowRight)
        
        configureConstraints()
    }

    func configureConstraints() {
        arrowLeft.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        arrowRight.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
    
    private func changeDate(date: Date){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        dateLabel.text = dateFormatter.string(from: date)
        
        currDate = Calendar.current.startOfMonth(date)
        
        if Calendar.current.startOfMonth(Date()) == currDate {
            arrowRight.isEnabled = false
            arrowRight.alpha = 0.6
        }
        else {
            arrowRight.isEnabled = true
            arrowRight.alpha = 1
        }
    }
    
    @objc private func navigateDateOnClick(_ sender: UIButton){
        if sender == arrowRight {
            currDate = Calendar.current.date(byAdding: .month, value: 1, to: currDate)
        }
        else {
            currDate = Calendar.current.date(byAdding: .month, value: -1, to: currDate)
        }
        
        changeDate(date: currDate)
        
        delegate?.dateIterator(willDisplay: currDate)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

