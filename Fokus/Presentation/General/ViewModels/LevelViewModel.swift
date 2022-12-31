//
//  LevelViewModel.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 20/12/22.
//

import Foundation
import UIKit

class LevelViewModel : NSObject {
    
    let maxXp = 1000
    let maxLevel = 10
    
    override init() {
        super.init()
    }
    
    func getBadgeIcon() -> UIImage?{
        
        guard let user = UserRepository.shared.fetchUser() else { return nil}
        
        guard let level = LevelRepository.shared.fetchLevel(levelNumber: Int(truncating: user.levelNumber)) else { return nil }
        
        print(level.badgeName)
    
        return UIImage(named: level.badgeName)
    }
    
    func calculateTaskXp(pomodoro: PomodoroModel, isPomdoroUsed: Bool) -> Int{
        let multiplier : Int = isPomdoroUsed ? 2 : 1
        let xp = Int(truncating: pomodoro.cycles) * Int(truncating: pomodoro.workDuration) * multiplier
        
        return xp
    }
    
    func addXpToUser(pomodoro: PomodoroModel, isPomdoroUsed: Bool) {
        
        // Calculate xp
        let xp = calculateTaskXp(pomodoro: pomodoro, isPomdoroUsed: isPomdoroUsed)
        
        // Calculate levels gained & excess xp
        guard let user = UserRepository.shared.fetchUser() else { return }
        
        let totalUserXp = Int(truncating: user.xp) + xp
        
        let levelsGained = totalUserXp/maxXp
        var excessXp = totalUserXp - levelsGained*maxXp
        
        // Check if user's level is above max level
        var totalUserLevel = levelsGained + Int(truncating: user.levelNumber)
        
        // If above max level
        if totalUserLevel > maxLevel {
            
            // Set totalUserLevel as max level
            totalUserLevel = maxLevel
            
            // Set excess xp as max xp
            excessXp = maxXp
        }
        
        // Update user xp and level
        UserRepository.shared.setUserLevelandXp(level: totalUserLevel, xp: excessXp)
    }
}
