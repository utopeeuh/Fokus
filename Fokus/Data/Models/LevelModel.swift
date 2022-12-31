//
//  LevelModel.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 30/12/22.
//

import Foundation
import UIKit
import CoreData

@objc(LevelModel)

class LevelModel: NSManagedObject {
    @NSManaged var levelNumber: NSNumber!
    @NSManaged var badgeName: String!
}
