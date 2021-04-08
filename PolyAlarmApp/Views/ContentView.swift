//
//  ContentView.swift
//  alarm
//
//  Created by Alina Potapova on 01.02.2021.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITabBar.appearance().barTintColor = UIColor.white
    }
    
    @State private var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View {
        VStack {
            if status {
                TabView {
                    ProfileView()
                        .preferredColorScheme(.dark)
                        .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                        }

                    AlarmListView().environmentObject(AlarmData())
                        .preferredColorScheme(.dark)
                        .tabItem {
                            Image(systemName: "alarm")
                            Text("Alarm")
                        }

                    SettingsView()
                        .preferredColorScheme(.dark)
                        .tabItem {
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                }.accentColor(.darkBlue)
            } else {
                /*NavigationView {
                    SignUpView()
                }*/
                SignUpView()
            }
        } .onAppear {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) {
                (_) in
                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                self.status = status
            }
        }
    }
}
