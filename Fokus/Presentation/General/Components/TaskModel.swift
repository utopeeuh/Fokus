//
//  Task.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 05/12/22.
//

import Foundation
import UIKit
import CoreData

@objc(TaskModel)

class TaskModel: NSManagedObject {
    @NSManaged var title: String!
    @NSManaged var isDone: NSNumber!
    @NSManaged var reminder: Date?
    @NSManaged var pomodoros: NSNumber!
    @NSManaged var work: NSNumber!
    @NSManaged var shortBreak: NSNumber!
    @NSManaged var longBreak: NSNumber!
    @NSManaged var isWhiteNoiseOn: NSNumber!
}
