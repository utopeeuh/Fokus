//
//  OptionButton.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 22/11/22.
//

import UIKit

class OptionButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .blackFokus
        layer.borderColor = UIColor.turq.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        setTitleColor(.turq, for: .normal)
        titleLabel!.font = .atkinsonRegular(size: .medium)!
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func select(){
        backgroundColor = .turq
        setTitleColor(.whiteFokus, for: .normal)
    }
    
    func deselect(){
        backgroundColor = .blackFokus
        layer.borderColor = UIColor.turq.cgColor
        setTitleColor(.turq, for: .normal)
    }

}
