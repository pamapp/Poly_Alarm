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
        removeNotification(alarm: alarm)
        if let index = alarms.firstIndex(where: { $0.id == alarm.id }) {
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
        if alarms.count == 1{
            return "\(alarms.count) LESSON"
        } else if alarms.isEmpty {
            return "NO LESSONS"
        } else {
            return "\(alarms.count) LESSONS"
        }
    }
}
