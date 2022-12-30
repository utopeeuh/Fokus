//
//  StatsViewModel.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 21/12/22.
//

import Foundation
import UIKit
import Charts

class StatsViewModel: NSObject {
    
    private(set) var cyclesCreated = 0
    private(set) var cyclesFinished = 0
    private(set) var totalWork = 0
    private(set) var avgWork = 0
    
    private(set) var tasksCreated = 0
    private(set) var tasksFinished = 0
    private(set) var tasksFinishedWithoutPomodoro = 0
    
    private(set) var pomodoroLineData : LineChartData!
    private(set) var taskLineData : LineChartData!
    
    
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
        
//        let createdTasks = TaskRepository.shared.fetchTasks(month: month, type: .created)
//        let finishedTasks = TaskRepository.shared.fetchTasks(month: month, type: .finished)
//        
//        // Setup variable to extract data for graph
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd"
//        
//        var prevDay = dateFormatter.string(from: createdTasks.first?.dateCreated ?? Date())
//        
//        var currDayTasks : Double = 0
//        var currDayCycles : Double = 0
//        
//        // Extract from created tasks
//        
//        var createdTaskEntries : [ChartDataEntry] = []
//        var createdCycleEntries : [ChartDataEntry] = []
//    
//        createdTasks.forEach { task in
//            
//            // Graph data
//            let currDay = dateFormatter.string(from: task.dateCreated!)
//            
//            // If same day as previous add to counter
//            if currDay == prevDay {
//                currDayTasks += 1
//                currDayCycles += Double(Int(truncating: task.pomodoros))
//            }
//            
//            // If not the same or last day, add current entry to array and reset
//            else {
//                // x - date, y - completed tasks/cycles on that day
//                createdTaskEntries.append(ChartDataEntry(x: Double(prevDay)!, y: currDayTasks))
//                createdCycleEntries.append(ChartDataEntry(x: Double(prevDay)!, y: currDayCycles))
//                
//                prevDay = currDay
//                currDayTasks = 1
//                currDayCycles = Double(Int(truncating: task.pomodoros))
//            }
//            
//            if task == createdTasks.last {
//                createdTaskEntries.append(ChartDataEntry(x: Double(prevDay)!, y: currDayTasks))
//                createdCycleEntries.append(ChartDataEntry(x: Double(prevDay)!, y: currDayCycles))
//            }
//            
//            // Stat numbers
//            cyclesCreated += Int(truncating: task.pomodoros)
//        }
//        
//        tasksCreated = createdTasks.count
//        
//        // Extract from finished tasks
//        
//        prevDay = dateFormatter.string(from: finishedTasks.first?.dateFinished ?? Date())
//        
//        currDayTasks = 0
//        currDayCycles = 0
//        
//        var completedTaskEntries : [ChartDataEntry] = []
//        var completedCycleEntries : [ChartDataEntry] = []
//        
//        finishedTasks.forEach { task in
//            
//            // Graph data
//            let currDay = dateFormatter.string(from: task.dateFinished!)
//            
//            // If same day as previous add to counter
//            if currDay == prevDay {
//                currDayTasks += 1
//                currDayCycles += Double(Int(truncating: task.pomodoros))
//            }
//            
//            // If not the same or last day, add current entry to array and reset
//            else {
//                
//                // x - date, y - completed tasks/cycles on that day
//                completedTaskEntries.append(ChartDataEntry(x: Double(prevDay)!, y: currDayTasks))
//                completedCycleEntries.append(ChartDataEntry(x: Double(prevDay)!, y: currDayCycles))
//                
//                prevDay = currDay
//                currDayTasks = 1
//                currDayCycles = Double(Int(truncating: task.pomodoros))
//            }
//            
//            if task == finishedTasks.last {
//                completedTaskEntries.append(ChartDataEntry(x: Double(prevDay)!, y: currDayTasks))
//                completedCycleEntries.append(ChartDataEntry(x: Double(prevDay)!, y: currDayCycles))
//            }
//            
//            // Stat numbers
//            
//            cyclesFinished += Int(truncating: task.pomodoros)
//            totalWork += Int(truncating: task.timeSpent)
//            
//            if task.timeSpent == 0 {
//                tasksFinishedWithoutPomodoro += 1
//            }
//        }
//        
//        tasksFinished = finishedTasks.count
//        avgWork = tasksFinished == 0 ? 0 : totalWork/tasksFinished
//        
//        let completedCycleDataset = LineChartDataSet(entries: completedCycleEntries, label: "Siklus diselesaikan")
//        completedCycleDataset.setCircleColor(.turq)
//        completedCycleDataset.colors = [.turq]
//        
//        let createdCycleDataset = LineChartDataSet(entries: createdCycleEntries, label: "Siklus dibuat")
//        createdCycleDataset.setCircleColor(.lightGrey)
//        createdCycleDataset.colors = [.lightGrey]
//        
//        pomodoroLineData = LineChartData(dataSets: [createdCycleDataset, completedCycleDataset])
//        
//        let completedTaskDataset = LineChartDataSet(entries: completedTaskEntries, label: "Task diselesaikan")
//        completedTaskDataset.setCircleColor(.turq)
//        completedTaskDataset.colors = [.turq]
//        
//        let createdTaskDataset = LineChartDataSet(entries: createdTaskEntries, label: "Task dibuat")
//        createdTaskDataset.setCircleColor(.lightGrey)
//        createdTaskDataset.colors = [.lightGrey]
//        
//        taskLineData = LineChartData(dataSets: [createdTaskDataset, completedTaskDataset])
    }
}
