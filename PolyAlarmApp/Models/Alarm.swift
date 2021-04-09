//
//  Alarm.swift
//  alarm
//
//  Created by Alina Potapova on 16.03.2021.
//

import SwiftUI

struct Alarm: Codable, Identifiable {
    let id: UUID
    var date: Date
    var label: String
    var ringtone: Ringtone
    var repeatDay: RepeatDay
    var isEnabled: Bool
    var isNotify: Bool
}

extension Alarm {

    static var defaultAlarm: [Alarm] {
        get {[
            Alarm(id: UUID(), date: Date(), label: "TESTNAME", ringtone: [.radar], repeatDay: [.sat, .sun, .mon], isEnabled: true, isNotify: true),
            Alarm(id: UUID(), date: Date().addingTimeInterval(+1000), label: "TESTNAME1", ringtone: [.apex], repeatDay: [.mon, .tue, .wed, .thu, .fri], isEnabled: false, isNotify: false),
            Alarm(id: UUID(), date: Date(), label: "TESTNAME2", ringtone: [.radar], repeatDay: [.mon, .tue, .wed, .thu, .fri, .sat, .sun], isEnabled: false, isNotify: true),
            Alarm(id: UUID(), date: Date().addingTimeInterval(-1000), label: "TESTNAME3", ringtone: [.chimes], repeatDay: [.mon], isEnabled: true, isNotify: true),
        ]}
    }
}

func getIndex(index: Int) -> Int {
    return Int(pow(Double(2), Double(index)))
}
