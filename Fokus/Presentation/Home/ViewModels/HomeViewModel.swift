//
//  HomeViewModel.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 09/12/22.
//

import Foundation
import UIKit

class HomeViewModel : NSObject {
    
    func getTaskList() -> [TaskModel] {
        return TaskRepository.shared.fetchTasks()
    }
    
    override init() {
        super.init()
    }
}
