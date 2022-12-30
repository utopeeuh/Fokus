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
    var id: String!
    var isWhiteNoiseOn: Bool = false
    var longBreakDuration: Float!
    var shortBreakDuration: Float!
    var workDuration: Float!
}
