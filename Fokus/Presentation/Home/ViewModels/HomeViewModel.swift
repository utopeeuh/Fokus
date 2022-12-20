//
//  HomeViewModel.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 09/12/22.
//

import Foundation
import UIKit

class HomeViewModel : NSObject {
    
    override init() {
        super.init()
    }
    
    private let firstTimeKey = "FIRST_TIME_KEY"
    
    func isFirstTimeOpening() -> Bool {
        return UserDefaults.standard.object(forKey: UserDefaultsKey.firstTime) as? Bool ?? true
    }
    
    
    
    func getTaskList() -> [TaskModel] {
        return TaskRepository.shared.fetchTasks()
    }
}
