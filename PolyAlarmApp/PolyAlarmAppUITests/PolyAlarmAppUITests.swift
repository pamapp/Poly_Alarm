//
//  PolyAlarmAppUITests.swift
//  PolyAlarmAppUITests
//
//  Created by Alina Potapova on 20.04.2021.
//

import Foundation
import XCTest
var app: XCUIApplication!
var test: XCTestCase!

class PolyAlarmAppUITests: XCTestCase {

    override func setUpWithError() throws {
//        try super.setUpWithError()
        continueAfterFailure = false
//        app = XCUIApplication()
//        app.launch()
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()

    }

    func clearTextField(textField: XCUIElement) {
        for _ in 1...(textField.value as! String).count {
            app.keys["delete"].tap()
        }
    }
}

// MARK: - Notifications Tests Section

class LocationHandler {
    var observer: AnyObject?
    let notificationCenter: NotificationCenter
    
    init(_ notificationCenter: NotificationCenter = .default) {
        self.notificationCenter = notificationCenter
        observer = notificationCenter.addObserver(forName: .init("LocationChanged"),
                           object: nil,
                           queue: .main)
        { [weak self] (_) in
            self?.handleChange()
        }
    }
    
    var didHandleNotification = false
    func handleChange() {
        didHandleNotification = true
    }
}

class LocationHandlerTests: XCTestCase {
    func testNoficationHandled() {
        let notificationCenter = NotificationCenter()
        let handler = LocationHandler(notificationCenter)
        XCTAssertFalse(handler.didHandleNotification)
        
        notificationCenter.post(name: .init("LocationChanged"), object: nil)
        XCTAssertTrue(handler.didHandleNotification)
    }
}

class LocationProvider {
    let notificationCenter: NotificationCenter
    
    init(_ notificationCenter: NotificationCenter = .default) {
        self.notificationCenter = notificationCenter
    }
    
    func notifyLocationChange() {
        notificationCenter.post(name: .init("LocationChanged"), object: self)
    }
}

class LocationProviderTests: XCTestCase {
    func testNotificationPosted() {
        let notificationCenter = NotificationCenter()
        let provider = LocationProvider(notificationCenter)
        let expectation = XCTNSNotificationExpectation(name: .init("LocationChanged"),
                                                       object: provider,
                                                       notificationCenter: notificationCenter)
        
        provider.notifyLocationChange()
        wait(for: [expectation], timeout: 0)
    }
}
