//
//  Alarm.swift
//  alarm
//
//  Created by Alina Potapova on 16.03.2021.
//

import SwiftUI
import Combine

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
        get { [
            Alarm(id: UUID(), date: Date(), label: "TESTNAME", ringtone: [.radar], repeatDay: [.sat, .sun, .mon], isEnabled: true, isNotify: true),
            Alarm(id: UUID(), date: Date().addingTimeInterval(+1000), label: "TESTNAME1", ringtone: [.apex], repeatDay: [.mon, .tue, .wed, .thu, .fri], isEnabled: false, isNotify: false),
            Alarm(id: UUID(), date: Date(), label: "TESTNAME2", ringtone: [.radar], repeatDay: [.mon, .tue, .wed, .thu, .fri, .sat, .sun], isEnabled: false, isNotify: true),
            Alarm(id: UUID(), date: Date().addingTimeInterval(-1000), label: "TESTNAME3", ringtone: [.chimes], repeatDay: [.mon], isEnabled: true, isNotify: true),
        ]
        }
    }
}

func getIndex(index: Int) -> Int {
//    if index == 0    {  return 1  }
//    if index == 1    {  return 2  }
//    if index == 2    {  return 4  }
//    if index == 3    {  return 8  }
//    if index == 4    {  return 16 }
//    if index == 5    {  return 32 }
//    if index == 6    {  return 64 }
    
    return Int(pow(Double(2), Double(index)))
}
