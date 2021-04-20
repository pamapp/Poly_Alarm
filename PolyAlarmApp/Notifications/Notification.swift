//
//  Notification.swift
//  alarm
//
//  Created by Alina Potapova on 27.03.2021.
//

import UserNotifications

func createNotification(alarm: Alarm) {
    let content = UNMutableNotificationContent()
    content.title = alarm.label
    content.subtitle = "Wake up!"
    content.categoryIdentifier = "ACTIONS"
    content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: alarm.ringtone.fullNameWithType))
    
    var alarmComps = Calendar.current.dateComponents([.hour, .minute], from: alarm.date)
    let currentComps = Calendar.current.dateComponents([.weekday], from: Date())
    
    if !alarm.repeatDay.repeatDaysIndexes.isEmpty {
        if alarm.repeatDay.repeatDaysIndexes.contains(currentComps.weekday ?? 0) {
            alarmComps.weekday = currentComps.weekday
        }
    }
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: alarmComps, repeats: true)
    let request = UNNotificationRequest(identifier: alarm.id, content: content, trigger: trigger)
    let reply = UNNotificationAction(identifier: "IWOKEUP", title: "I WOKE UP", options: .foreground)
    
    let category = UNNotificationCategory(identifier: "ACTIONS", actions: [reply], intentIdentifiers: [], options: [])

    UNUserNotificationCenter.current().setNotificationCategories([category])
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
}

func removeNotification(alarm: Alarm) {
    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.removePendingNotificationRequests(withIdentifiers: [alarm.id])
}
