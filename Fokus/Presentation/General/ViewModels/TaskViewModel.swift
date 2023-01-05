//
//  TaskViewModel.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 05/12/22.
//

import Foundation

class TaskViewModel : NSObject {
    let notificationCenter = NotificationManager();
    override init() {
        super.init()
    }
    
    func getPomodoro(task: TaskModel) -> PomodoroModel? {
        return PomodoroRepository.shared.fetchPomodoro(id: task.pomodoroId)
    }
    
    func createTask(title: String, reminder: Date?, cycles: NSNumber, work: String, shortBreak: String, longBreak: String, whiteNoise: String) -> TaskModel? {
        
        // Convert durations to int
        let workDuration = cleanDurationString(str: work)
        let longBreakDuration = cleanDurationString(str: longBreak)
        let shortBreakDuration = cleanDurationString(str: shortBreak)
        
        // Convert whiteNoise to nsnumber
        let isWhiteNoiseOn: NSNumber = (whiteNoise == "OFF" ? 0 : 1)
        
        // Create task
        guard let newTask = TaskRepository.shared.createTask(title: title, reminder: reminder) else { return nil }
        
        // Create pomodoro
        _ = PomodoroRepository.shared.createPomodoro(id: newTask.pomodoroId, cycles: cycles, workDuration: workDuration, shortBreakDuration: shortBreakDuration, longBreakDuration: longBreakDuration, isWhiteNoiseOn: isWhiteNoiseOn)
        
        if reminder != nil {
            NotificationManager.shared.createTaskNotif(task: newTask, reminderDate: reminder!)
        }
        
        return newTask
    }
    
    func editTask(id: String, title: String, reminder: Date?, cycles: NSNumber, work: String, shortBreak: String, longBreak: String, whiteNoise: String) -> TaskModel? {
        
        // Convert durations to int
        let workDuration = cleanDurationString(str: work)
        let longBreakDuration = cleanDurationString(str: longBreak)
        let shortBreakDuration = cleanDurationString(str: shortBreak)
        
        // Convert whiteNoise to nsnumber
        let isWhiteNoiseOn : NSNumber = (whiteNoise == "OFF" ? 0 : 1)
        
        // Edit task
        let task = TaskRepository.shared.editTask(id: id, title: title, reminder: reminder)
        
        // Edit pomodoro
        _ = PomodoroRepository.shared.editPomodoro(id: task!.pomodoroId, cycles: cycles, workDuration: workDuration, shortBreakDuration: shortBreakDuration, longBreakDuration: longBreakDuration, isWhiteNoiseOn: isWhiteNoiseOn)
        
        if reminder != nil {
            NotificationManager.shared.createTaskNotif(task: task!, reminderDate: reminder!)
        }
        return task
    }
    
    private func cleanDurationString(str: String) -> NSNumber {
        if let index = (str.range(of: ":")?.lowerBound)
        {
            let beforeColon = String(str.prefix(upTo: index))
            return Float(beforeColon)! as NSNumber
        }
        
        return 0
    }
    
    func markAsDone(id: String, timeSpent: Int) {
                
        // Update to DB
        TaskRepository.shared.markAsDone(id: id, timeSpent: timeSpent)
        // Delete notification
        NotificationManager.shared.deleteNotification(taskId: id)
    }
    
    func deleteTask(id: String) {
                
        // Update to DB
        TaskRepository.shared.deleteTask(id: id)
        // Delete notification
        NotificationManager.shared.deleteNotification(taskId: id)
//        self.notificationCenter.removePendingNotificationRequests(withIdentifiers: [self.task!.id])
    }
    
    func duplicateTask(task: TaskModel) -> TaskModel?{
        
        // Delete current task
        TaskRepository.shared.deleteTask(id: task.id)
        
        // Create duplicate
        let duplicate = TaskRepository.shared.createTask(title: task.title, reminder: task.reminder, pomodoroId: task.pomodoroId)
        
        // Return duplicate
        return duplicate
    }
    
    func toggleWhiteNoise(id: String, isOn: Bool){
        PomodoroRepository.shared.toggleWhiteNoise(id: id, isOn: isOn)
    }
}
