//
//  PomodoroRepository.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 30/12/22.
//

import Foundation
import UIKit
import CoreData

class PomodoroRepository {
    
    static let shared = PomodoroRepository()
    
    func createPomodoro(id: String, cycles: NSNumber, workDuration: NSNumber, shortBreakDuration: NSNumber, longBreakDuration: NSNumber, isWhiteNoiseOn: NSNumber) -> PomodoroModel? {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Pomodoro", in: context)!
        
        let newPomodoro = PomodoroModel(entity: entity, insertInto: context)
        
        newPomodoro.id = id
        newPomodoro.cycles = cycles
        newPomodoro.workDuration = workDuration
        newPomodoro.shortBreakDuration = shortBreakDuration
        newPomodoro.longBreakDuration = longBreakDuration
        newPomodoro.isWhiteNoiseOn = isWhiteNoiseOn
        
        do{
            try context.save()
            print("Create pomodoro success")
            
        }
        catch{
            print("Create pomodoro failed")
            return nil
        }

        return newPomodoro
    }
    
    func fetchPomodoro(id: String) -> PomodoroModel? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
    
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Pomodoro")
        
        let idPredicate = NSPredicate(format: "id == %@", id)
        request.predicate = idPredicate
        do{
            //Ambil hasil query
            if let results = try context.fetch(request) as? [PomodoroModel] {
                return results.first
            }
        }
        catch{
            print("fetch failed")
        }

        return nil
    }
    
    func editPomodoro(id: String, cycles: NSNumber, workDuration: NSNumber, shortBreakDuration: NSNumber, longBreakDuration: NSNumber, isWhiteNoiseOn: NSNumber) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

        do{
            guard let pomodoro = fetchPomodoro(id: id) else {
                return false
            }
            
            pomodoro.cycles = cycles
            pomodoro.workDuration = workDuration
            pomodoro.shortBreakDuration = shortBreakDuration
            pomodoro.longBreakDuration = longBreakDuration
            pomodoro.isWhiteNoiseOn = isWhiteNoiseOn
            
            try context.save()
            print("Edit task success")
        }
        
        catch{
            print("Edit pomodoro failed")
            return false
        }
        
        return true
    }
    
    func toggleWhiteNoise(id: String, isOn: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let resultFetch = fetchPomodoro(id: id)
        do{
            resultFetch?.isWhiteNoiseOn = isOn as NSNumber
            try context.save()
        }
        catch{
            print("update task failed")
        }
    }
}
