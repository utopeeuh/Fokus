//
//  AchievementsViewModel.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 07/03/23.
//

import Foundation
import UIKit

struct Achievement {
    let title: String
    let desc: String
    var isAccomplished: Bool
}

class AchievementsViewModel: NSObject {
    
    private(set) var progress = 0
    
    override init(){
        super.init()
    }
    
    func getAchievements(month: Date) -> [Achievement] {
        
        // Reset progress
        progress = 0
        
        // Fetch all stats
        let stat = StatisticRepository.shared.fetchStats(month: month)
        
        // Initialize achievements
        var task1 = Achievement(title: "Task Newbie", desc: "Selesaikan 1 task", isAccomplished: false)
        task1.isAccomplished = stat?.tasksFinished as! Int > 0 ? true : false
        
        var task5 = Achievement(title: "Task Master", desc: "Selesaikan 5 task", isAccomplished: false)
        task5.isAccomplished = stat?.tasksFinished as! Int > 4 ? true : false
        
        var task10 = Achievement(title: "Task Grandmaster", desc: "Selesaikan 10 task", isAccomplished: false)
        task10.isAccomplished = stat?.tasksFinished as! Int > 9 ? true : false
        
        var task20 = Achievement(title: "Task Terminator", desc: "Selesaikan 20 task", isAccomplished: false)
        task20.isAccomplished = stat?.tasksFinished as! Int > 19 ? true : false
        
        var task50 = Achievement(title: "Task Conqueror", desc: "Selesaikan 50 task", isAccomplished: false)
        task50.isAccomplished = stat?.tasksFinished as! Int > 49 ? true : false
        
        var cycle4 = Achievement(title: "Pomodoro Newbie", desc: "Selesaikan 4 siklus Pomodoro", isAccomplished: false)
        cycle4.isAccomplished = stat?.cyclesFinished as! Int > 3 ? true : false
        
        var cycle12 = Achievement(title: "Pomodoro Ace", desc: "Selesaikan 12 siklus Pomodoro", isAccomplished: false)
        cycle12.isAccomplished = stat?.cyclesFinished as! Int > 11 ? true : false
        
        var cycle24 = Achievement(title: "Pomodoro Champion", desc: "Selesaikan 24 siklus Pomodoro", isAccomplished: false)
        cycle24.isAccomplished = stat?.cyclesFinished as! Int > 23 ? true : false
        
        var time30 = Achievement(title: "Time Keeper", desc: "Habiskan 30 menit dalam Fase Kerja", isAccomplished: false)
        time30.isAccomplished = stat?.totalWorkDuration as! Int >= 30 ? true : false
        
        var time60 = Achievement(title: "Time Maestro", desc: "Habiskan 60 menit dalam Fase Kerja", isAccomplished: false)
        time60.isAccomplished = stat?.totalWorkDuration as! Int >= 60 ? true : false
        
        var time180 = Achievement(title: "Time Lord", desc: "Habiskan 180 menit dalam Fase Kerja", isAccomplished: false)
        time180.isAccomplished = stat?.totalWorkDuration as! Int >= 180 ? true : false
        
        let achievementList = [task1, task5, task10, task20, cycle4, cycle12, cycle24, time30, time60, time180]
        
        achievementList.forEach { ach in
            if ach.isAccomplished {
                progress += 1
            }
        }
        
        return achievementList
    }
}
