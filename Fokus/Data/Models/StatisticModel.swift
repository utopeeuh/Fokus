//
//  StatisticModel.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 30/12/22.
//

import Foundation
import UIKit
import CoreData

@objc(StatisticModel)

class StatisticModel: NSManagedObject {
    @NSManaged var month: Date!
    @NSManaged var avgWorkDuration: NSNumber
    @NSManaged var cyclesCreated: NSNumber
    @NSManaged var cyclesFinished: NSNumber
    @NSManaged var tasksCreated: NSNumber
    @NSManaged var tasksFinished: NSNumber
    @NSManaged var tasksNoPomodoro: NSNumber
    @NSManaged var totalWorkDuration: NSNumber
}
