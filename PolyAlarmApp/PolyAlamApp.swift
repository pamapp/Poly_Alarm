//
//  alarmApp.swift
//  alarm
//
//  Created by Alina Potapova on 01.02.2021.
//

import SwiftUI
import Firebase
import UserNotifications

@main
struct alarmApp: App {
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate
//    let trustNumberData = TrustNumberData()
//    let alarmData = AlarmData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class Delegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {
            success, error in
        }
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    }
}

extension Delegate: UNUserNotificationCenterDelegate, ObservableObject {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent: UNNotification,
                                withCompletionHandler: @escaping (UNNotificationPresentationOptions)->()) {
        withCompletionHandler([.banner, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive: UNNotificationResponse,
                                withCompletionHandler: @escaping ()->()) {
        withCompletionHandler()
    }
}
