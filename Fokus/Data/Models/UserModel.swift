//
//  UserModel.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 09/12/22.
//

import Foundation
import UIKit
import CoreData

@objc(UserModel)

class UserModel: NSManagedObject {
    @NSManaged var name: String!
    @NSManaged var xp: NSNumber!
}
