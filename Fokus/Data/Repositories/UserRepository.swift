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
            try context.save()
        }
        catch {
            print("create user failed")
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
            print("fetch failed")
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
            print("update user name failed")
        }
    }
    
    func addXp(xp: Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        do {
            let user = fetchUser()
            user?.xp = (user?.xp as! Int + xp) as NSNumber
            
            try context.save()
        }
        catch {
            print("update user xp failed")
        }
    }
}
