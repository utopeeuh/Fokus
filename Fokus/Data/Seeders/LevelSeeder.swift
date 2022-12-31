//
//  LevelSeeder.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/12/22.
//

import Foundation
import UIKit
import CoreData

class LevelSeeder: NSObject  {
    
    override init() {
        super.init()
    }
    
    func seed() -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Level", in: context)!
        
        for i in 1..<11 {
            let newLevel = LevelModel(entity: entity, insertInto: context)
        
            var badgeName = ""
            
            switch i {
                case 1...3: badgeName = "badge1"
                case 4...6: badgeName = "badge2"
                case 7...9: badgeName = "badge2"
                case _ where i > 9: badgeName = "badge4"
                default: return false
            }
            
            newLevel.levelNumber = i as NSNumber
            newLevel.badgeName = badgeName
        }
        
        do{
            try context.save()
        }
        catch {
            print("Seed levels failed")
            return false
        }
        
        return true
    }
}
