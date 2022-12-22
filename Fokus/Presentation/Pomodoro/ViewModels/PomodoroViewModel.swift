//
//  PomodoroViewModel.swift
//  Fokus
//
//  Created by fachry adhitya on 11/12/22.
//

import Foundation

class PomodoroViewModel : NSObject {
    override init() {
        super.init()
    }
    
    func markAsDone(id: String, timeSpent: Int) {
                
        // Update to DB
        TaskRepository.shared.markAsDone(id: id, timeSpent: timeSpent)
    }
}
