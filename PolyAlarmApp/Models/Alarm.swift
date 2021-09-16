//
//  Alarm.swift
//  alarm
//
//  Created by Alina Potapova on 16.03.2021.
//

import SwiftUI
import Foundation

struct Alarm: Codable, Identifiable, Hashable {
    var id = UUID().uuidString
    var date: Date
    var label: String
    var ringtone: Ringtone
    var repeatDay: RepeatDay
    var isEnabled: Bool {
        didSet {
            if isEnabled {
                if repeatDay.numOfRepeatDays != 0 {
                    for day in 0...repeatDay.numOfRepeatDays - 1 {
                        NotificationMethods().createNotification(alarm: self, day: day)
                    }
                } else {
                    NotificationMethods().createNotification(alarm: self)
                }
            } else {
                if repeatDay.numOfRepeatDays != 0 {
                    for day in 0...repeatDay.numOfRepeatDays - 1 {
                        NotificationMethods().removeNotification(alarm: self, day: day)
                    }
                } else {
                    NotificationMethods().removeNotification(alarm: self)
                }
            }
        }
    }

    var isNotify: Bool
}

extension Alarm {
    var timeFormat: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self.date)
    }
}

extension Alarm {
    static var defaultAlarm: [Alarm] {
        get {[
            Alarm(id: UUID().uuidString, date: Date(), label: "TESTNAME", ringtone: [.radar], repeatDay: [.sat, .sun, .mon], isEnabled: true, isNotify: true)
        ]}
    }
}

func getIndex(index: Int) -> Int {
    return Int(pow(Double(2), Double(index)))
}


struct IndexedCollection<Base: RandomAccessCollection>: RandomAccessCollection {
    typealias Index = Base.Index
    typealias Element = (index: Index, element: Base.Element)

    let base: Base

    var startIndex: Index { base.startIndex }

    var endIndex: Index { base.endIndex }

    func index(after i: Index) -> Index {
        base.index(after: i)
    }

    func index(before i: Index) -> Index {
        base.index(before: i)
    }

    func index(_ i: Index, offsetBy distance: Int) -> Index {
        base.index(i, offsetBy: distance)
    }

    subscript(position: Index) -> Element {
        (index: position, element: base[position])
    }
}

extension RandomAccessCollection {
    func indexed() -> IndexedCollection<Self> {
        IndexedCollection(base: self)
    }
}

