//
//  AlarmData.swift
//  alarm
//
//  Created by Alina Potapova on 19.03.2021.
//

import Combine
import SwiftUI

final class AlarmData: ObservableObject {
    let didChange = PassthroughSubject<AlarmData, Never>()
    @UserDefaultAlarm(key: "Alarms", defaultValue: Alarm.defaultAlarm)
    
    var alarms: [Alarm] {
        didSet {
            didChange.send(self)
        }
    }
}
