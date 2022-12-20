//
//  Colors.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 19/11/22.
//

import Foundation
import UIKit

extension UIColor {
    static let whiteFokus = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
    
    static let lightGrey =  UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)
    
    static let turq = UIColor(red: 0, green: 172/255, blue: 141/255, alpha: 1)
    
    static let darkTurq = UIColor(red: 0, green: 139/255, blue: 114/255, alpha: 1)
    
    static let blackFokus = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1)
    
    static let darkGrey = UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 1)
    
    convenience init(hexString: String) {
            let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int = UInt64()
            Scanner(string: hex).scanHexInt64(&int)
            let a, r, g, b: UInt64
            switch hex.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (255, 0, 0, 0)
            }
            self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
        }

}
