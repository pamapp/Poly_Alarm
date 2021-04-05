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
    
    var body: some View {
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


