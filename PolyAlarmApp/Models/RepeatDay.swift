//
//  RepeatDay.swift
//  alarm
//
//  Created by Alina Potapova on 02.04.2021.
//

import SwiftUI

struct RepeatDay: OptionSet, Codable, Hashable {
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
    
    var repeatDaysIndexes: [Int] {
        var days: [Int] = []
        if contains(.sun) {  days += [1] }
        if contains(.mon) {  days += [2] }
        if contains(.tue) {  days += [3] }
        if contains(.wed) {  days += [4] }
        if contains(.thu) {  days += [5] }
        if contains(.fri) {  days += [6] }
        if contains(.sat) {  days += [7] }
        return days
    }
    
    var numOfRepeatDays: Int {
        var numOfDays: Int = 0
        if contains(.sun) {  numOfDays += 1 }
        if contains(.mon) {  numOfDays += 1 }
        if contains(.tue) {  numOfDays += 1 }
        if contains(.wed) {  numOfDays += 1 }
        if contains(.thu) {  numOfDays += 1 }
        if contains(.fri) {  numOfDays += 1 }
        if contains(.sat) {  numOfDays += 1 }
        return numOfDays
    }
}
