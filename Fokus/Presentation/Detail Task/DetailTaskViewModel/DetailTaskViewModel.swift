//
//  DetailTaskViewModel.swift
//  Fokus
//
//  Created by Firzha Ardhia Ramadhan on 11/12/22.
//

import Foundation

class DetailTaskViewModel : NSObject {
    override init() {
        super.init()
    }
    
    func markAsUndone(id: String) {
                
        // Update to DB
        TaskRepository.shared.markAsUndone(id: id)
    }
    
    func markAsDone(id: String) {
                
        // Update to DB
        TaskRepository.shared.markAsDone(id: id)
    }
    
    func deleteTask(id: String) {
                
        // Update to DB
        TaskRepository.shared.deleteTask(id: id)
    }
    
    func toggleWhiteNoise(id: String, isOn: Bool){
        TaskRepository.shared.toggleWhiteNoise(id: id, isOn: isOn)
    }

    
    private func cleanDurationString(str: String) -> NSNumber {
        if let index = (str.range(of: ":")?.lowerBound)
        {
            let beforeColon = String(str.prefix(upTo: index))
            return NSNumber(value: Int(beforeColon)!)
        }
        
        return 0
    }
}
