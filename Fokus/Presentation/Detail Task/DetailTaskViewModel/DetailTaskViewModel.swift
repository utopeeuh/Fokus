//
//  DetailTaskViewModel.swift
//  Fokus
//
//  Created by Firzha Ardhia Ramadhan on 11/12/22.
//

import Foundation

class DetailTaskViewModel : NSObject {
    override init() {
        super.init()
    }
    
    func markAsDone(id: String, timeSpent: Int) {
                
        // Update to DB
        TaskRepository.shared.markAsDone(id: id, timeSpent: timeSpent)
    }
    
    func deleteTask(id: String) {
                
        // Update to DB
        TaskRepository.shared.deleteTask(id: id)
    }
    
    func duplicateTask(task: TaskModel) -> TaskModel?{
        
        // Delete current task
        TaskRepository.shared.deleteTask(id: task.id)
        
        // Create duplicate
        TaskRepository.shared.createTask(title: task.title, pomodoros: task.pomodoros, work: task.work, shortBreak: task.shortBreak, longBreak: task.longBreak, reminder: task.reminder, isWhiteNoiseOn: task.isWhiteNoiseOn)
        
        // Fetch duplicate
        let duplicate = TaskRepository.shared.fetchTasks().last
        
        // Return duplicate
        return duplicate
    }
    
    func toggleWhiteNoise(id: String, isOn: Bool){
        TaskRepository.shared.toggleWhiteNoise(id: id, isOn: isOn)
    }
}
