//
//  alarmApp.swift
//  alarm
//
//  Created by Alina Potapova on 01.02.2021.
//

import SwiftUI

@main
struct alarmApp: App {
//    let alarm = Alarm.Observable.self
//    @StateObject var alarms: [Alarm.Observable] = Array<Int>(0..<10).map { _ in Alarm.random().asObservable } { didSet { didSetAlarms() }}
    
//    var alarms: [Alarm.Observable] = Array<Int>(0..<10).map { _ in Alarm.random().asObservable } { didSet { didSetAlarms() }}
    
//    @StateObject var alarm = Alarm.Observable(Alarm.random())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private func didSetAlarms() {
        
    }
}
