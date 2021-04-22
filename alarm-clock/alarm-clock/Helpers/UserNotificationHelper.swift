//
//  UserNotificationHelper.swift
//  alarm-clock
//
//  Created by Vinicius Emanuel on 22/04/21.
//

import Foundation
import NotificationCenter

class UserNotificationHelper {
    static let shared = UserNotificationHelper()
    
    private let notificationID = "notification_ID"
    let center = UNUserNotificationCenter.current()
    
    func askForPermission(_ completion: @escaping (_ granted: Bool)->Void ) {
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let _ = error {
                completion(false)
            } else {
                completion(granted)
            }
        }
    }
    
    func sendNotificationWith(interval: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Olá!"
        content.body = "Eu sou uma notificação local"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(interval), repeats: false)
        let request = UNNotificationRequest(identifier: self.notificationID, content: content, trigger: trigger)
        
        self.center.add(request)
    }
    
    func disableNotification() {
        
    }
}
