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
    
    func getUser() -> UserModel? {
        return UserRepository.shared.fetchUser()
    }
    
    func getBadgeIcon() -> UIImage?{
        
        guard let user = UserRepository.shared.fetchUser() else { return nil}
        
        guard let level = LevelRepository.shared.fetchLevel(levelNumber: Int(truncating: user.levelNumber)) else { return nil }
    
        return UIImage(named: level.badgeName)
    }
    
    func isFirstTimeOpening() -> Bool {
        return UserDefaults.standard.object(forKey: UserDefaultsKey.firstTime) as? Bool ?? true
    }

    func getTaskList() -> [TaskModel] {
        return TaskRepository.shared.fetchTasks()
    }
}
