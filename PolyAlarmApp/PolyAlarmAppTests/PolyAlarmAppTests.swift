//
//  PolyAlarmAppTests.swift
//  PolyAlarmAppTests
//
//  Created by Alina Potapova on 20.04.2021.
//

import XCTest
@testable import PolyAlarmApp

var alarmDataSut: AlarmData!
var alarmEditSut: AlarmEditView!
var trustNumberDataSut: TrustNumberData!

let trustNumber = TrustNumber(id: UUID().uuidString,
                              name: "ALINA",
                              phoneNumber: "89222893458",
                              isEnabled: true)

let alarm = Alarm(id: UUID().uuidString,
                  date: Date(),
                  label: "Alarm",
                  ringtone: [.radar],
                  repeatDay: [.wed],
                  isEnabled: true,
                  isNotify: false)

let alarmWithLaterTime = Alarm(id: UUID().uuidString,
                  date: Date().addingTimeInterval(+1000),
                  label: "Alarm",
                  ringtone: [.radar],
                  repeatDay: [],
                  isEnabled: true,
                  isNotify: false)

class PolyAlarmAppTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}

// MARK: - Alarm Data Tests Section

class AlarmTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        alarmDataSut = AlarmData()
    }
    
    override func tearDownWithError() throws {
        alarmDataSut = nil
        alarmEditSut = nil
        try super.tearDownWithError()
    }
    
    func testRemoveAllAlarmsMethod() {
        //given
        let alarms: [Alarm] = []
        
        // when
        alarmDataSut.removeAllAlarms()

        // then
        XCTAssertEqual(alarmDataSut.alarms, alarms)
    }
    
    func testAddAlarmMethod() {
        //clean alarms data before test
        alarmDataSut.removeAllAlarms()

        // given
        let alarms: [Alarm] = [alarm]

        // when
        alarmDataSut.add(alarm)

        // then
        XCTAssertEqual(alarmDataSut.alarms, alarms)
    }
    
    func testRemoveAlarmMethod() {
        //clean alarms data before test
        alarmDataSut.removeAllAlarms()

        // given
        let alarms: [Alarm] = []

        // when
        alarmDataSut.add(alarm)
        alarmDataSut.delete(alarm)

        // then
        XCTAssertEqual(alarmDataSut.alarms, alarms)
    }
    
    func testFirstAlarmTimeMethod() {
        //clean alarms data before test
        alarmDataSut.removeAllAlarms()

        // when
        alarmDataSut.add(alarmWithLaterTime)
        alarmDataSut.add(alarm)

        let methodTimeMessage = alarmDataSut.firstAlarmTime()
        let alarmTimeMessage = "FIRST ONE AT \(alarm.timeFormat)"

        // then
        XCTAssertEqual(methodTimeMessage, alarmTimeMessage)
    }
    
    func testFirstAlarmTimeMethodWhenNoAlarms() {
        //clean alarms data before test
        alarmDataSut.removeAllAlarms()

        // when
        let methodTimeMessage = alarmDataSut.firstAlarmTime()
        let noAlarmsMessage = "CONGRATS!"

        // then
        XCTAssertEqual(methodTimeMessage, noAlarmsMessage)
    }
    
    func testFirstTimeAlarm() {
        //clean alarms data before test
        alarmDataSut.removeAllAlarms()
        
        // when alarm data is empty
        let noAlarmsMessage = "CONGRATS!"
        let methodNoAlarmsMessage = alarmDataSut.firstAlarmTime()
        XCTAssertEqual(methodNoAlarmsMessage, noAlarmsMessage)
        
        // when alarm data include alarm/alarms
        alarmDataSut.add(alarm)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        let includeAlarmMessage = "FIRST ONE AT \(formatter.string(from: alarm.date))"
        let methodincludeAlarmsMessage = alarmDataSut.firstAlarmTime()
        
        XCTAssertEqual(methodincludeAlarmsMessage, includeAlarmMessage)
    }
    
    func testNumOfAlarmsMethod() {
        //clean alarms data before test
        alarmDataSut.removeAllAlarms()
        
        // when alarm data is empty
        let noAlarmsMessage = "NO LESSONS"
        let methodNoAlarmsMessage = alarmDataSut.numOfAlarms()
        XCTAssertEqual(methodNoAlarmsMessage, noAlarmsMessage)
        
        // when alarm data include one alarm
        alarmDataSut.add(alarm)
        
        let oneAlarmNumMessage = "1 LESSON"
        let methodOneAlarmsMessage = alarmDataSut.numOfAlarms()
        
        XCTAssertEqual(methodOneAlarmsMessage, oneAlarmNumMessage)
        
        // when alarm data include more than one alarm
        alarmDataSut.add(alarm)
        
        let alarmsNumMessage = "\(alarmDataSut.alarms.count) LESSONS"
        let methodMoreThanOneAlarmsMessage = alarmDataSut.numOfAlarms()
        
        XCTAssertEqual(methodMoreThanOneAlarmsMessage, alarmsNumMessage)
    }
}


// MARK: - TrustNumbers Tests Section

class TrustNumberTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        trustNumberDataSut = TrustNumberData()
    }
    
    override func tearDownWithError() throws {
        trustNumberDataSut = nil
        try super.tearDownWithError()
    }
    
    func testRemoveAllAlarmsMethod() {
        //given
        let trustNumbers: [TrustNumber] = []
        
        // when
        trustNumberDataSut.removeAllTrustNumbers()

        // then
        XCTAssertEqual(trustNumberDataSut.trustNumbers, trustNumbers)
    }
    
    func testAddTrustNumberMethod() {
        //clean trustNumbers data before test
        trustNumberDataSut.removeAllTrustNumbers()

        // given
        let trustNumbers: [TrustNumber] = [trustNumber]

        // when
        trustNumberDataSut.add(trustNumber)

        // then
        XCTAssertEqual(trustNumberDataSut.trustNumbers, trustNumbers)
    }
    
    func testRemoveTrustNumberMethod() {
        //clean alarms data before test
        trustNumberDataSut.removeAllTrustNumbers()

        // given
        let trustNumbers: [TrustNumber] = []

        // when
        trustNumberDataSut.add(trustNumber)
        trustNumberDataSut.delete(trustNumber)

        // then
        XCTAssertEqual(trustNumberDataSut.trustNumbers, trustNumbers)
    }
    
}
