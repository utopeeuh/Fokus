//
//  UserRepository.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 12/12/22.
//

import Foundation
import UIKit
import CoreData

class UserRepository {
    
    static let shared = UserRepository()
    
    func createUser(name: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "User", in: context)!
        
        do{
            let newUser = UserModel(entity: entity, insertInto: context)
            newUser.name = name
            newUser.xp = 0
            newUser.levelNumber = 1
            try context.save()
        }
        catch {
            print("Create user failed")
        }
    }
    
    func fetchUser() -> UserModel?{
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
    
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do{
            //Ambil hasil query
            if let results = try context.fetch(request) as? [UserModel] {
                return results.first
            }
        }
        catch{
            print("Fetch user failed")
        }

        return nil
    }
    
    func updateName(name: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        do {
            let user = fetchUser()
            user!.name = name
            try context.save()
        }
        catch {
            print("Update user name failed")
        }
    }
    
    func setUserLevelandXp(level: Int, xp: Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        do {
            guard let user = fetchUser() else { return }
            user.levelNumber = level as NSNumber
            user.xp = xp as NSNumber
            
            try context.save()
        }
        catch {
            print("Update user level & xp failed")
        }
    }
}
