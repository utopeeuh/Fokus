//
//  NameModalViewModel.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 28/12/22.
//

import Foundation
import UIKit

class NameModalViewModel: NSObject {
    
    override init() {
        super.init()
    }
    
    func createNewUser(name: String){
        UserRepository.shared.createUser(name: name)
        UserDefaults.standard.set(false, forKey: UserDefaultsKey.firstTime)
    }
    
    func updateUsername(name: String){
        UserRepository.shared.updateName(name: name)
    }
}
