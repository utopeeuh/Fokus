//
//  NotificationManager.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 24/12/22.
//

import Foundation
import UIKit

class NotificationManager {
    
    static let shared = NotificationManager()
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestNotification(){
        notificationCenter.requestAuthorization(options: [.alert, .sound]) {
                   (permissionGranted, error) in
                   if (!permissionGranted) {
                       print("Permission Denied")
                   }
               }
    }
    
    func createTaskNotif(task: TaskModel, reminderDate: Date?){
        if reminderDate == nil { return }
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [task.id])
        notificationCenter.getNotificationSettings { (settings) in
            DispatchQueue.main.async {

                // Show alert if notification isn't authorized
                
                if(settings.authorizationStatus != .authorized) {
                    self.redirectToSettingsAlert()
                    return
                }
                
                // Task attributes
                
                let title = task.title!
                let message = "Mulailah sesi Pomodoro-mu. Saatnya untuk Fokus:)"
                let date = reminderDate
                
                // Create notification
            
                let content = UNMutableNotificationContent()
                content.title = title
                content.body = message
                
                let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date!)
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
                let request = UNNotificationRequest(identifier: task.id!, content: content, trigger: trigger)
                
//                self.notificationCenter.
                self.notificationCenter.add(request) { (error) in
                    if (error != nil) {
                        print("Error " + error.debugDescription)
                        return
                    }
                }
            }
        }
    }
    
    func redirectToSettingsAlert(){
        let ac = UIAlertController(title: "Please turn on notifications", message: "If you want to use reminders, you'll need to turn notifications on for Fokus in your settings! Please re-create your task after that!", preferredStyle: .alert)
        
        let goToSettings = UIAlertAction(title: "Go to Settings", style: .default) {
        (_) in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString)
            else {
                return
            }
            
            if (UIApplication.shared.canOpenURL(settingsURL))
            {
                UIApplication.shared.open(settingsURL) { (_) in }
            }
        }
        ac.addAction(goToSettings)
        ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in }))
        
        // Present alert to top view controller
        
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        keyWindow?.topViewController()?.navigationController?.present(ac, animated: true)
    }
    
    func deleteNotification(taskId: String) {
        return self.notificationCenter.removePendingNotificationRequests(withIdentifiers: [taskId])
    }
}
