//
//  CreateTaskViewModel.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 05/12/22.
//

import Foundation

class CreateTaskViewModel : NSObject {
    
    override init() {
        super.init()
    }
    
    func createTask(title: String, reminder: Date?, pomodoros: Int, work: String, shortBreak: String, longBreak: String, whiteNoise: String) {
        
        // Convert durations to int
        let workDuration = cleanDurationString(str: work)
        let longBreakDuration = cleanDurationString(str: longBreak)
        let shortBreakDuration = cleanDurationString(str: shortBreak)
        
        // Convert whiteNoise to nsnumber
        let isWhiteNoiseOn = (whiteNoise == "OFF" ? false : true) as NSNumber
        
        // Insert to DB
        TaskRepository.shared.createTask(title: title, pomodoros: pomodoros as NSNumber, work: workDuration, shortBreak: shortBreakDuration, longBreak: longBreakDuration, reminder: reminder, isWhiteNoiseOn: isWhiteNoiseOn)
    }
    
    private func cleanDurationString(str: String) -> NSNumber {
        if let index = (str.range(of: ":")?.lowerBound)
        {
            let beforeColon = String(str.prefix(upTo: index))
            return NSNumber(value: Int(beforeColon)!)
        }
        
        return 0
    }
}
