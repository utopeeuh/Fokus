//
//  PomodoroModel.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 30/12/22.
//

import Foundation
import UIKit
import CoreData

@objc(PomodoroModel)

class PomodoroModel: NSManagedObject {
    @NSManaged var id: String!
    @NSManaged var cycles: NSNumber!
    @NSManaged var isWhiteNoiseOn: NSNumber!
    @NSManaged var longBreakDuration: NSNumber!
    @NSManaged var shortBreakDuration: NSNumber!
    @NSManaged var workDuration: NSNumber!
}
