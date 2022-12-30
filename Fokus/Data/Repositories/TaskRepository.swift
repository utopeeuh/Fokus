//
//  TaskRepository.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 05/12/22.
//

import Foundation
import UIKit
import CoreData

enum TaskState {
    case created, finished
}

class TaskRepository {
    
    static let shared = TaskRepository()
    
    func createTask(title: String, reminder: Date?) -> TaskModel? {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context)!
        
        let newTask = TaskModel(entity: entity, insertInto: context)

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddhhmmss"
        
        newTask.id = "T\(formatter.string(from: Date()))"
        newTask.title = title
        newTask.reminder = reminder
        newTask.pomodoroId = "P\(formatter.string(from: Date()))"
        newTask.dateCreated = Date()
        newTask.timeSpent = 0
        newTask.isHidden = false
        
        do{
            try context.save()
            print("Create task success")
        }
        catch{
            print("Create task failed")
            return nil
        }
        
        return newTask
    }
    
    func createTask(title: String, reminder: Date?, pomodoroId: String) -> TaskModel? {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context)!
        
        let newTask = TaskModel(entity: entity, insertInto: context)

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddhhmmss"
        
        newTask.id = "T\(formatter.string(from: Date()))"
        newTask.title = title
        newTask.reminder = reminder
        newTask.pomodoroId = pomodoroId
        newTask.dateCreated = Date()
        newTask.timeSpent = 0
        newTask.isHidden = false
        
        do{
            try context.save()
            print("Create task success")
        }
        catch{
            print("Create task failed")
            return nil
        }
        
        return newTask
    }
    
    func editTask(id:String, title: String, reminder: Date?) -> TaskModel? {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

        do{
            let task = fetchTask(id: id)
            task!.title = title
            task!.reminder = reminder
            task!.timeSpent = 0
            task!.isHidden = false
            try context.save()
            print("Edit task success")
            return task
        }
        catch{
            print("Edit task failed")
            return nil
        }
    }
    
    func fetchTasks() -> [TaskModel]{
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
    
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")

        // Query for non-hidden tasks
        let hiddenPredicate = NSPredicate(format: "isHidden == false")
        request.predicate = hiddenPredicate
        
        //Sort hasil
        let idSort = NSSortDescriptor(key:"dateCreated", ascending:false)
        request.sortDescriptors = [idSort]

        do{
            //Ambil hasil query
            if let results = try context.fetch(request) as? [TaskModel] {
                return results
            }
        }
        catch{
            print("fetch failed")
        }

        return []
    }
    
    func fetchTasks(month: Date, type: TaskState) -> [TaskModel]{
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
    
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        // Query for state and date range
        let stateString = type == .created ? "dateCreated" : "dateFinished"
        
        let startMonthPredicate = NSPredicate(format: "\(stateString) >= %@", month as CVarArg)
        
        let endDate = Calendar.current.endOfMonth(month) + (31*3600)
        let endMonthPredicate = NSPredicate(format: "\(stateString) < %@", endDate as CVarArg)
        
        let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [startMonthPredicate, endMonthPredicate])
        
        request.predicate = compoundPredicate
        
        //Sort hasil
        let idSort = NSSortDescriptor(key:"dateCreated", ascending:false)
        request.sortDescriptors = [idSort]

        do{
            //Ambil hasil query
            if let results = try context.fetch(request) as? [TaskModel] {
                return results
            }
        }
        catch{
            print("fetch failed")
        }

        return []
    }
    
    func markAsDone(id: String, timeSpent: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let resultFetch = fetchTask(id: id)
        do{
            resultFetch?.dateFinished = Date()
            resultFetch?.timeSpent = timeSpent as NSNumber
            try context.save()
        }
        catch{
            print("update task failed")
        }
    }
    
    func fetchTask(id: String) -> TaskModel?{
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
    
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        let idPredicate = NSPredicate(format: "id == %@", id)
        request.predicate = idPredicate
        do{
            //Ambil hasil query
            if let results = try context.fetch(request) as? [TaskModel] {
                return results.first
            }
        }
        catch{
            print("fetch failed")
        }

        return nil
    }
    
    func deleteTask(id: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        do{
            let resultFetch = fetchTask(id: id)
            resultFetch?.isHidden = true
            try context.save()
        }
        catch{
            print("delete failed")
        }
    }
}
