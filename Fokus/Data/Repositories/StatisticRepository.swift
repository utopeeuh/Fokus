//
//  StatisticRepository.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 30/12/22.
//

import Foundation
import UIKit
import CoreData
 
class StatisticRepository {
    
    static let shared = StatisticRepository()
    
    enum StatType {
        case created, finished
    }
    
    func createStat() -> StatisticModel?{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Statistic", in: context)!
        
        let newStat = StatisticModel(entity: entity, insertInto: context)
        
        do{
            newStat.month = Calendar.current.startOfMonth(Date())
            newStat.totalWorkDuration = 0
            newStat.avgWorkDuration = 0
            newStat.cyclesCreated = 0
            newStat.cyclesFinished = 0
            newStat.tasksCreated = 0
            newStat.tasksFinished = 0
            newStat.tasksNoPomodoro = 0
            
            try context.save()
        }
        catch {
            print("create stat failed")
            return nil
        }
        
        return newStat
    }
    
    func updateStat(task: TaskModel, pomodoro: PomodoroModel, type: StatType){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        guard let taskDate = type == .created ? task.dateCreated : task.dateFinished else { return }
        
        guard let stat = fetchStats(month: Calendar.current.startOfMonth(taskDate)) else { return }
        
        if type == .created {
            
            stat.tasksCreated = Int(truncating: stat.tasksCreated) + 1 as NSNumber
            stat.cyclesCreated = Int(truncating: stat.cyclesCreated) + Int(truncating: pomodoro.cycles) as NSNumber
        }
        
        else {
            
            stat.tasksFinished = Int(truncating: stat.tasksFinished) + 1 as NSNumber
            
            if task.timeSpent == 0 {
                stat.tasksNoPomodoro = Int(truncating: stat.tasksNoPomodoro) + 1 as NSNumber
            }
            
            else {
                
                stat.cyclesFinished = Int(truncating: stat.cyclesFinished) + Int(truncating: pomodoro.cycles) as NSNumber
                
                stat.totalWorkDuration = (Float(truncating: stat.tasksCreated) + Float(truncating: task.timeSpent))/60000 as NSNumber
                
                stat.avgWorkDuration = Float(truncating: stat.totalWorkDuration )/Float(truncating: stat.cyclesFinished) as NSNumber
            }
        }
        
        do {
            try context.save()
        }
        catch {
            print("update stat failed")
        }
        
    }
    
    func fetchStats(month: Date) -> StatisticModel?{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
    
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Statistic")
        
        let predicate = NSPredicate(format: "month == %@", month as CVarArg)
        request.predicate = predicate
        
        do{
            //Ambil hasil query
            if let results = try context.fetch(request) as? [StatisticModel] {
                
                return results.first ?? createStat()!
            }
        }
        catch{
            print("fetch failed")
        }

        return nil
    }
    
}
