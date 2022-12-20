//
//  TaskRepository.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 05/12/22.
//

import Foundation
import UIKit
import CoreData

class TaskRepository{
    
    static let shared = TaskRepository()
    
    func createTask(title: String, pomodoros: NSNumber, work: NSNumber, shortBreak: NSNumber, longBreak: NSNumber, reminder: Date?, isWhiteNoiseOn: NSNumber) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context)!
        
        let newTask = TaskModel(entity: entity, insertInto: context)

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
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
    
    /// CONTOH FETCH
    
//    func fetchEffectList(ids: [Int]) -> [EffectModel]{
//
//        var effectList: [EffectModel] = []
    
//        // appDelegate & context bakal ada di setiap function
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
    
//        // Entity name ubah sesuai nama entitias lu
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Effects")
//
//        var predicateList: [NSPredicate] = []
//        ids.forEach { id in
//            let idPredicate = NSPredicate(format: "id == %@", String(describing:id))
//            predicateList.append(idPredicate)
//        }
    
//        //Gabungin query predicate
//        let compoundPredicate = NSCompoundPredicate(type: .or, subpredicates: predicateList)
//
//        request.predicate = compoundPredicate
//
//        //Sort hasil
//        let idSort = NSSortDescriptor(key:"id", ascending:true)
//        request.sortDescriptors = [idSort]
//
//        do{
//            //Ambil hasil query
//            let results:NSArray = try context.fetch(request) as NSArray
//
//            for result in results {
//                let effect = result as? EffectModel
//                effectList.append(effect!)
//            }
//        }
//        catch{
//            print("fetch failed")
//        }
//
//        return effectList
//    }
    
    /// CONTOH DELETE
    func deleteTask(id: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

        let resultFetch = fetchTask(id: id)
        
        do{
//            resultFetch?.dateFinished = Date()
            try context.delete(resultFetch as! NSManagedObject)
        }
        catch{
            print("delete failed")
        }

//        let timePredicate = NSPredicate(format: "routineId == %@", String(describing: routineId))
//        let idPredicate = NSPredicate(format: "position == %@", String(describing: step.position))
//        let compoundPredicate = NSCompoundPredicate(type: .or, subpredicates: [timePredicate, idPredicate])
//
//        request.predicate = compoundPredicate
//
//        do{
//            let results:NSArray = try context.fetch(request) as NSArray
//            context.delete(results.firstObject as! NSManagedObject)
//        }
//        catch{
//            print("fetch failed")
//        }
    }
    
    /// CONTOH UPDATE
    /// Sama persis kayak fetch, bedanya setelah fetching data &
    /// parse ke data type class yang sesuai,
    /// attribute objectnya diubah aja di dalem do-block nya
    /// trs tinggal panggil "try context.save()" dibawahnya
    /// Contoh context.save() ada di function create
}
