//
//  Navbar.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 05/12/22.
//

import Foundation
import UIKit
import SnapKit

@objc protocol NavbarDelegate {
    @objc func rightBarItemOnClick()
}

class Navbar: UIView {
    
    public var delegate: NavbarDelegate? {
        didSet {
            rightBarButton.addTarget(self, action: #selector(barButtonOnClick), for: .touchUpInside)
        }
    }
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.font = .atkinsonRegular(size: .large)
        label.textColor = .whiteFokus
        return label
    }()
    
    private let backBtn : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrowLeft"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    private let rightBarButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.turq, for: .normal)
        button.titleLabel?.font = .atkinsonRegular(size: .large)
        button.isHidden = true
        return button
    }()
    
    /**
        Enables right navbar item. Implement delegate to use on-click function.
    */
    public var isRightBarItemEnabled : Bool = false {
        didSet {
            if isRightBarItemEnabled == true {
                rightBarButton.isHidden = false
                return
            }
            
            rightBarButton.isHidden = true
        }
    }
    
    /**
        Enables right navbar item. Implement delegate to use on-click function.
    */
    public var barItemTitle : String = "" {
        didSet {
            rightBarButton.setTitle(barItemTitle, for: .normal)
        }
    }
    
    required init(title: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        
        titleLabel.text = title
        
        backBtn.addTarget(self, action: #selector(backOnClick), for: .touchUpInside)
        
        addSubview(titleLabel)
        addSubview(backBtn)
        addSubview(rightBarButton)
        
        configureConstraints()
    }
    
    func configureConstraints(){
        backBtn.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.left).offset(12)
            make.height.equalToSuperview()
            make.width.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        rightBarButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.height.equalToSuperview()
        }
        
    }
    
    @objc func backOnClick(){
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        keyWindow?.topViewController()?.navigationController?.popViewController(animated: true)
    }
    
    @objc func barButtonOnClick(){
        delegate?.rightBarItemOnClick()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
