//
//  StatsViewModel.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 21/12/22.
//

import Foundation
import UIKit

class StatsViewModel: NSObject {
    
    private(set) var cyclesCreated = 0
    private(set) var cyclesFinished = 0
    private(set) var totalWork = 0
    private(set) var avgWork = 0
    
    private(set) var tasksCreated = 0
    private(set) var tasksFinished = 0
    private(set) var tasksFinishedWithoutPomodoro = 0
    
    override init() {
        super.init()
    }
    
    func setMonth(month: Date){
        
        cyclesCreated = 0
        cyclesFinished = 0
        totalWork = 0
        avgWork = 0
        
        tasksCreated = 0
        tasksFinished = 0
        tasksFinishedWithoutPomodoro = 0
        
        let createdTasks = TaskRepository.shared.fetchTasks(month: month, type: .created)
        
        let finishedTasks = TaskRepository.shared.fetchTasks(month: month, type: .finished)
        
        // Extract from created tasks
        tasksCreated = createdTasks.count
        createdTasks.forEach { task in
            cyclesCreated += Int(truncating: task.pomodoros)
        }
        
        // Extract from finished tasks
        finishedTasks.forEach { task in
            cyclesFinished += Int(truncating: task.pomodoros)
            totalWork += Int(truncating: task.timeSpent)
            
            if task.timeSpent == 0 {
                tasksFinishedWithoutPomodoro += 1
            }
        }
        
        tasksFinished = finishedTasks.count
        avgWork = tasksFinished == 0 ? 0 : totalWork/tasksFinished
    }
}
