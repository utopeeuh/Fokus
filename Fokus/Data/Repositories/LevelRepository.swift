//
//  LevelRepository.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/12/22.
//

import Foundation
import UIKit
import CoreData

class LevelRepository {
    
    static let shared = LevelRepository()
    
    func fetchLevel(levelNumber: Int) -> LevelModel?{
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Level")
        
        let levelPredicate = NSPredicate(format: "levelNumber == \(levelNumber)")
        request.predicate = levelPredicate
        
        do{
            //Ambil hasil query
            if let results = try context.fetch(request) as? [LevelModel] {
                return results.first
            }
        }
        catch{
            print("Fetch level failed")
        }
        
        return nil
    }
}
