//
//  DateLabel.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 13/12/22.
//

import Foundation
import UIKit

class DateLabel: UILabel {
    
    public var date: Date = Date() {
        didSet {
            setupLabel()
        }
    }
    
    required init(){
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel(){
        let mutableString = NSMutableAttributedString(string: "Statistik ", attributes: [NSAttributedString.Key.font: UIFont.atkinsonBold(size: .huge)!, NSAttributedString.Key.foregroundColor: UIColor.white])
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let monthString = dateFormatter.string(from: date)
        
        let dateAttString = NSMutableAttributedString(string: monthString, attributes: [NSAttributedString.Key.font: UIFont.atkinsonBold(size: .huge)!, NSAttributedString.Key.foregroundColor: UIColor.turq])
        
        mutableString.append(dateAttString)
            
        attributedText = mutableString
        
        sizeToFit()
    }
}
