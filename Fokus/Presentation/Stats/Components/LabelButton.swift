//
//  LabelButton.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 13/12/22.
//

import Foundation
import UIKit

protocol StatsButtonDelegate {
    func onButtonTapped(tapped button: StatsButton)
}

class StatsButton: UIButton {
    
    public var delegate: StatsButtonDelegate?
    
    public var isActive : Bool = true {
        didSet {
            if isActive == true {
                enable()
            }
            else {
                disable()
            }
        }
    }
    
    required init(text: String) {
        super.init(frame: .zero)
        setTitle(text, for: .normal)
        setTitleColor(.turq, for: .normal)
        titleLabel?.font = .atkinsonRegular(size: .large)
        sizeToFit()
        
        addTarget(self, action: #selector(onTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func enable(){
        setTitleColor(.turq, for: .normal)
    }
    
    private func disable(){
        setTitleColor(.lightGrey, for: .normal)
    }
    
    @objc func onTap(){
        isActive = true
        delegate?.onButtonTapped(tapped: self)
    }
}
