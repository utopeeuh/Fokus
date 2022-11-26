//
//  TitleTextField.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 26/11/22.
//

import Foundation
import UIKit

class TitleTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 26))
        
        backgroundColor = .clear
        textColor = .whiteFokus
        font = .atkinsonRegular(size: 24)
        tintColor = .turq
        placeholder = "Enter your title.."
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
