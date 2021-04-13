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
}
