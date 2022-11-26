//
//  SubHeadLabel.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 26/11/22.
//

import Foundation
import UIKit

class SubHeadLabel: UILabel {
    
    init(size: CGFloat) {
        super.init(frame: .zero)
        font = .atkinsonRegular(size: size)
        textColor = .turq
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
