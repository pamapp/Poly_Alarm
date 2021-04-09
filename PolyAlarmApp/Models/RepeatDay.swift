//
//  RepeatDay.swift
//  alarm
//
//  Created by Alina Potapova on 02.04.2021.
//

import SwiftUI

struct RepeatDay: OptionSet, Codable {
    let rawValue: Int

    static let mon = RepeatDay(rawValue: 1 << 0)
    static let tue = RepeatDay(rawValue: 1 << 1)
    static let wed = RepeatDay(rawValue: 1 << 2)
    static let thu = RepeatDay(rawValue: 1 << 3)
    static let fri = RepeatDay(rawValue: 1 << 4)
    static let sat = RepeatDay(rawValue: 1 << 5)
    static let sun = RepeatDay(rawValue: 1 << 6)
    
    static let all: RepeatDay = [.mon, .tue, .wed, .thu, .fri, .sat, .sun]

    var fullName: String {
        if contains(.mon) {  return "MON" }
        if contains(.tue) {  return "TUE" }
        if contains(.wed) {  return "WED" }
        if contains(.thu) {  return "THU" }
        if contains(.fri) {  return "FRI" }
        if contains(.sat) {  return "SAT" }
        if contains(.sun) {  return "SUN" }
        return ""
    }
    
    var getWeekDayIndex: Int {
        if contains(.sun) {  return 1 }
        if contains(.mon) {  return 2 }
        if contains(.tue) {  return 3 }
        if contains(.wed) {  return 4 }
        if contains(.thu) {  return 5 }
        if contains(.fri) {  return 6 }
        if contains(.sat) {  return 7 }
        return 0
    }
}
