//
//  TaskRepository.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 05/12/22.
//

import Foundation
import UIKit
import CoreData

protocol TaskRepositoryDelegate{
    func createTask(title: String, pomodoros: NSNumber, work: NSNumber, shortBreak: NSNumber, longBreak: NSNumber, reminder: Date?, isWhiteNoiseOn: NSNumber)
}

class TaskRepository: TaskRepositoryDelegate{
    
    static let shared = TaskRepository()
    
    func createTask(title: String, pomodoros: NSNumber, work: NSNumber, shortBreak: NSNumber, longBreak: NSNumber, reminder: Date?, isWhiteNoiseOn: NSNumber) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context)!
        
        let newTask = TaskModel(entity: entity, insertInto: context)

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddhhmmss"
        newTask.id = "T\(formatter.string(from: Date()))"
        
        newTask.title = title
        newTask.reminder = reminder
        newTask.pomodoros = pomodoros
        newTask.work = work
        newTask.dateCreated = Date()
        newTask.shortBreak = shortBreak
        newTask.longBreak = longBreak
        newTask.isWhiteNoiseOn = isWhiteNoiseOn
        
        do{
            try context.save()
            print("Create task success")
        }
        catch{
            print("Create task failed")
        }
    }
    
    
    func fetchTasks() -> [TaskModel]{
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
    
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")

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
    
    func updateTask(id: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let resultFetch = fetchTask(id: id)
        do{
            resultFetch?.dateFinished = Date()
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
    
    func toggleWhiteNoise(id: String, isOn: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let resultFetch = fetchTask(id: id)
        do{
            resultFetch?.isWhiteNoiseOn = isOn as NSNumber
            try context.save()
        }
        catch{
            print("update task failed")
        }
    }
    
    func deleteTask(id: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        do{
            let resultFetch = fetchTask(id: id)
            try context.delete(resultFetch as! NSManagedObject)
        }
        catch{
            print("delete failed")
        }
    }
}
