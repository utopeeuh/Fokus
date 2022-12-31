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
    
    func addCreatedTaskToStats(task: TaskModel, pomodoro: PomodoroModel){
        StatisticRepository.shared.updateStat(task: task, pomodoro: pomodoro, type: .created)
    }
    
    func addFinishedTaskToStats(task: TaskModel, pomodoro: PomodoroModel){
        StatisticRepository.shared.updateStat(task: task, pomodoro: pomodoro, type: .finished)
    }
    
    func setMonth(month: Date){
        
        guard let stat = StatisticRepository.shared.fetchStats(month: month) else { return }
        
        cyclesCreated = Int(truncating: stat.cyclesCreated)
        cyclesFinished = Int(truncating: stat.cyclesFinished)
        totalWork = Int(truncating: stat.totalWorkDuration)
        avgWork = Int(truncating: stat.avgWorkDuration)
        
        tasksCreated = Int(truncating: stat.tasksCreated)
        tasksFinished = Int(truncating: stat.tasksFinished)
        tasksFinishedWithoutPomodoro = Int(truncating: stat.tasksNoPomodoro)
        
        let createdTasks = TaskRepository.shared.fetchTasks(month: month, type: .created)
        let finishedTasks = TaskRepository.shared.fetchTasks(month: month, type: .finished)

        // Setup variable to extract data for graph

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"

        var prevDay = dateFormatter.string(from: createdTasks.first?.dateCreated ?? Date())

        var currDayTasks : Double = 0
        var currDayCycles : Double = 0

        // Extract from created tasks

        var createdTaskEntries : [ChartDataEntry] = []
        var createdCycleEntries : [ChartDataEntry] = []
        
        createdTasks.forEach { task in
            
            guard let currPomodoro = PomodoroRepository.shared.fetchPomodoro(id: task.pomodoroId) else { return }

            // Graph data
            let currDay = dateFormatter.string(from: task.dateCreated!)

            // If same day as previous add to counter
            if currDay == prevDay {
                currDayTasks += 1
                currDayCycles += Double(Int(truncating: currPomodoro.cycles))
            }

            // If not the same or last day, add current entry to array and reset
            else {
                // x - date, y - completed tasks/cycles on that day
                createdTaskEntries.append(ChartDataEntry(x: Double(prevDay)!, y: currDayTasks))
                createdCycleEntries.append(ChartDataEntry(x: Double(prevDay)!, y: currDayCycles))

                prevDay = currDay
                currDayTasks = 1
                currDayCycles = Double(Int(truncating: currPomodoro.cycles))
            }

            if task == createdTasks.last {
                createdTaskEntries.append(ChartDataEntry(x: Double(prevDay)!, y: currDayTasks))
                createdCycleEntries.append(ChartDataEntry(x: Double(prevDay)!, y: currDayCycles))
            }
        }

        // Extract from finished tasks

        prevDay = dateFormatter.string(from: finishedTasks.first?.dateFinished ?? Date())

        currDayTasks = 0
        currDayCycles = 0

        var completedTaskEntries : [ChartDataEntry] = []
        var completedCycleEntries : [ChartDataEntry] = []

        finishedTasks.forEach { task in

            guard let currPomodoro = PomodoroRepository.shared.fetchPomodoro(id: task.pomodoroId) else { return }
            
            // Graph data
            let currDay = dateFormatter.string(from: task.dateFinished!)

            // If same day as previous add to counter
            if currDay == prevDay {
                currDayTasks += 1
                currDayCycles += Double(Int(truncating: currPomodoro.cycles))
            }

            // If not the same or last day, add current entry to array and reset
            else {

                // x - date, y - completed tasks/cycles on that day
                completedTaskEntries.append(ChartDataEntry(x: Double(prevDay)!, y: currDayTasks))
                completedCycleEntries.append(ChartDataEntry(x: Double(prevDay)!, y: currDayCycles))

                prevDay = currDay
                currDayTasks = 1
                currDayCycles = Double(Int(truncating: currPomodoro.cycles))
            }

            if task == finishedTasks.last {
                completedTaskEntries.append(ChartDataEntry(x: Double(prevDay)!, y: currDayTasks))
                completedCycleEntries.append(ChartDataEntry(x: Double(prevDay)!, y: currDayCycles))
            }
        }

        let completedCycleDataset = LineChartDataSet(entries: completedCycleEntries, label: "Siklus diselesaikan")
        completedCycleDataset.setCircleColor(.turq)
        completedCycleDataset.colors = [.turq]

        let createdCycleDataset = LineChartDataSet(entries: createdCycleEntries, label: "Siklus dibuat")
        createdCycleDataset.setCircleColor(.lightGrey)
        createdCycleDataset.colors = [.lightGrey]

        pomodoroLineData = LineChartData(dataSets: [createdCycleDataset, completedCycleDataset])

        let completedTaskDataset = LineChartDataSet(entries: completedTaskEntries, label: "Task diselesaikan")
        completedTaskDataset.setCircleColor(.turq)
        completedTaskDataset.colors = [.turq]

        let createdTaskDataset = LineChartDataSet(entries: createdTaskEntries, label: "Task dibuat")
        createdTaskDataset.setCircleColor(.lightGrey)
        createdTaskDataset.colors = [.lightGrey]

        taskLineData = LineChartData(dataSets: [createdTaskDataset, completedTaskDataset])
    }
}
