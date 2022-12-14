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
    @NSManaged var id: String!
    @NSManaged var pomodoroId: String!
    @NSManaged var dateCreated: Date!
    @NSManaged var dateFinished: Date?
    @NSManaged var title: String!
    @NSManaged var reminder: Date?
    @NSManaged var timeSpent: NSNumber!
    @NSManaged var isHidden : NSNumber!
}
