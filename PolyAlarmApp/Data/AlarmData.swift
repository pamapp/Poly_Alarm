//
//  AlarmData.swift
//  alarm
//
//  Created by Alina Potapova on 19.03.2021.
//

import SwiftUI
import Combine

final class AlarmData: ObservableObject {
    let didChange = PassthroughSubject<AlarmData, Never>()
    @UserDefault(key: "Alarms", defaultValue: Alarm.defaultAlarm)
    
    var alarms: [Alarm] {
        didSet {
            didChange.send(self)
        }
    }
    
    // MARK: - Managing Alarms
    
    func add(_ alarm: Alarm) {
        if let index = alarms.firstIndex(where: { $0.date > alarm.date }) {
            alarms.insert(alarm, at: index)
        } else {
            alarms.append(alarm)
        }
    }
    
    func delete(_ alarm: Alarm) {
        if let index = alarms.firstIndex(where: { $0.id == alarm.id }) {
            if alarm.repeatDay.numOfRepeatDays != 0 {
                for day in 0...alarm.repeatDay.numOfRepeatDays - 1 {
                    NotificationMethods().removeNotification(alarm: alarm, day: day)
                }
            } else {
                NotificationMethods().removeNotification(alarm: alarm)
            }
            alarms.remove(at: index)
        }
    }
    
    func firstAlarmTime() -> String {
        if !alarms.isEmpty {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let time = formatter.string(from: alarms[alarms.startIndex].date)
            return "FIRST ONE AT \(time)"
        } else {
            return "CONGRATS!"
        }
    }
    
    func numOfAlarms() -> String {
        let currentDay = Calendar.current.dateComponents([.weekday], from: Date())
        var counter = 0
        
        for alarm in alarms {
            if alarm.repeatDay.repeatDaysIndexes.contains(currentDay.weekday ?? 0) {
                counter += 1
            }
        }
        
        if counter == 0 {
            return "NO LESSONS"
        } else if counter == 1 {
            return "\(counter) LESSON"
        } else {
            return "\(counter) LESSONS"
        }
    }
    
    func removeAllAlarms() {
        alarms.removeAll()
    }
}
