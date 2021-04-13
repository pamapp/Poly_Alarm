//
//  Ringtone.swift
//  alarm
//
//  Created by Alina Potapova on 02.04.2021.
//

import SwiftUI

struct Ringtone: OptionSet, Codable, Hashable {
    let rawValue: Int

    static let radar   = Ringtone(rawValue: 1 << 0)
    static let apex    = Ringtone(rawValue: 1 << 1)
    static let beacon  = Ringtone(rawValue: 1 << 2)
    static let chimes  = Ringtone(rawValue: 1 << 3)
    static let electro = Ringtone(rawValue: 1 << 4)
    static let future  = Ringtone(rawValue: 1 << 5)
    
    static let all: Ringtone = [.radar, .apex, .beacon, .chimes, .electro, .future]
    
    var fullName: String {
        if contains(.radar)   {  return "radar" }
        if contains(.apex)    {  return "apex" }
        if contains(.beacon)  {  return "beacon" }
        if contains(.chimes)  {  return "chimes" }
        if contains(.electro) {  return "electro" }
        if contains(.future)  {  return "future" }
        return ""
    }
    
    var fullNameWithType: String {
        if contains(.radar)   {  return "radar.mp3" }
        if contains(.apex)    {  return "apex.mp3" }
        if contains(.beacon)  {  return "beacon.mp3" }
        if contains(.chimes)  {  return "chimes.mp3" }
        if contains(.electro) {  return "electro.mp3" }
        if contains(.future)  {  return "future.mp3" }
        return ""
    }
}
