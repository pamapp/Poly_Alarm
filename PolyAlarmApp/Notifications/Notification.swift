//
//  Notification.swift
//  alarm
//
//  Created by Alina Potapova on 27.03.2021.
//

import UserNotifications

class NotificationDelegate: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    @Published var alert = false
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .banner, .sound])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "REPLY" {
            print("reply do something")
            self.alert.toggle()
        }
        completionHandler()
    }
}

func createNotification(alarm: Alarm, weekDay: Int) {
    let content = UNMutableNotificationContent()
    
    content.title = alarm.label
    content.subtitle = "Wake up!"
    content.categoryIdentifier = "ACTIONS"
    content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: alarm.ringtone.fullNameWithType))
    
    var comps = Calendar.current.dateComponents([.hour, .minute], from: alarm.date)
    
    if weekDay != 0 {
        comps.weekday = weekDay
    }
    
    print(comps)
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)
    let request = UNNotificationRequest(identifier: "PolyAlarm", content: content, trigger: trigger)
    
    let close = UNNotificationAction(identifier: "CLOSE", title: "Close", options: .destructive)
    let reply = UNNotificationAction(identifier: "REPLY", title: "Reply", options: .foreground)
    
    let category = UNNotificationCategory(identifier: "ACTIONS", actions: [close, reply], intentIdentifiers: [], options: [])
    UNUserNotificationCenter.current().setNotificationCategories([category])
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
}

