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
    
    func getLevel() -> Int{
        
        let user = UserRepository.shared.fetchUser()
        let level = Int(((user?.xp as! Float)/Float(maxXp)).rounded(.down)) + 1
        
        return level > maxLevel ? maxLevel : level
    }
    
    func getExcessXp() -> Int{
        
        let user = UserRepository.shared.fetchUser()
        let level = getLevel()-1
        let excess = Int(truncating: user!.xp) - level*maxXp
        return excess
        
    }
    
    func getBadgeIcon() -> UIImage{
        let level = getLevel()
        var imageName = ""
        
        if level <= 3 {
            imageName = "badge1"
        }
        
        else if level <= 6 {
            imageName = "badge2"
        }
        
        else if level <= 9 {
            imageName = "badge3"
        }
        
        else {
            imageName = "badge4"
        }
        
        return UIImage(named: imageName)!
    }
    
    func calculateTaskXp(task: TaskModel, isPomdoroUsed: Bool) -> Int {
        let multiplier = isPomdoroUsed ? 2 : 1
        let xp = Int(truncating: task.pomodoros) * Int(truncating: task.work) * multiplier
        return xp
    }
    
    func addUserXp(xp: Int) {
        
        let user = UserRepository.shared.fetchUser()
        
        if getLevel() == maxLevel && (getExcessXp() + xp) > maxXp {
            let xpDiffTillMax = (maxLevel+1)*maxLevel - (user!.xp as! Int)
            UserRepository.shared.addXp(xp: xpDiffTillMax)
            return
        }
        
        UserRepository.shared.addXp(xp: xp)
    }
}
