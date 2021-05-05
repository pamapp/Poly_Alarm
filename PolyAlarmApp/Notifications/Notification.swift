//
//  Notification.swift
//  alarm
//
//  Created by Alina Potapova on 27.03.2021.
//

import UserNotifications

class NotificationMethods {
    func createNotification(alarm: Alarm, day: Int = -1) {
        let content = UNMutableNotificationContent()
        content.title = alarm.label
        content.subtitle = "Wake up!"
        content.categoryIdentifier = "ACTIONS"
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: alarm.ringtone.fullNameWithType))
        
        var alarmComps = Calendar.current.dateComponents([.hour, .minute], from: alarm.date)
        var identifierByDay: String
        
        if day != -1 {
            alarmComps.weekday = alarm.repeatDay.repeatDaysIndexes[day]
            identifierByDay = alarm.id + String(day)
        } else {
            identifierByDay = alarm.id
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: alarmComps, repeats: true)
        let request = UNNotificationRequest(identifier: identifierByDay, content: content, trigger: trigger)
        let reply = UNNotificationAction(identifier: "IWOKEUP", title: "I WOKE UP", options: .foreground)
        
        let category = UNNotificationCategory(identifier: "ACTIONS", actions: [reply], intentIdentifiers: [], options: [])

        UNUserNotificationCenter.current().setNotificationCategories([category])
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    func removeNotification(alarm: Alarm, day: Int = -1) {
        var identifierByDay: String
        
        if day != -1 {
            identifierByDay = alarm.id + String(day)
        } else {
            identifierByDay = alarm.id
        }
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifierByDay])
    }
}
