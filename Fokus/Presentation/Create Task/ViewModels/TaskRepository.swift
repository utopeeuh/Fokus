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

        newTask.title = title
        newTask.reminder = reminder
        newTask.pomodoros = pomodoros
        newTask.work = work
        newTask.isDone = false
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
}
