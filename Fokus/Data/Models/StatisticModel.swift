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
    var avgWorkDuration: Float = 0
    var cyclesCreated: Float = 0
    var cyclesFinished: Float = 0
    var month: Date!
    var tasksCreated: Float = 0
    var tasksFinished: Float = 0
    var tasksNoPomodoro: Float = 0
    var totalWorkDuration: Float = 0
}
