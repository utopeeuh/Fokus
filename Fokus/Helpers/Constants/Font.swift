//
//  Font.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 19/11/22.
//

import Foundation
import UIKit

extension UIFont {
    
    static let small: CGFloat = 12
    
    static let medium: CGFloat = 16
    
    static let large: CGFloat = 18
    
    static let huge: CGFloat = 24
    
    static func atkinsonRegular(size: CGFloat) -> UIFont?{
        return UIFont(name: "AtkinsonHyperlegible-Regular", size: size)
    }
    
    static func atkinsonBold(size: CGFloat) -> UIFont?{
        return UIFont(name: "AtkinsonHyperlegible-Bold", size: size)
    }

}
