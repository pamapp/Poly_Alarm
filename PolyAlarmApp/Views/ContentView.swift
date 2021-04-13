//
//  ContentView.swift
//  alarm
//
//  Created by Alina Potapova on 01.02.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    @State private var bottomSheetShown = false
    @State private var showingProfile = true
    @State private var changeMale = true
    
    let hieght: CGFloat = 250
    
    var body: some View {
        ZStack {
            if status {
                TabBarView(pages: .constant([
                    TabBarPage(
                        page: ProfileView(moveMemoji: bottomSheetShown, changeMale: changeMale)
                            .preferredColorScheme(.dark),
                        icon: "person",
                        tag: "Profile"
                    ),
                    TabBarPage(
                        page: AlarmListView()
                            .preferredColorScheme(.dark)
                            .environmentObject(AlarmData()),
                        icon: "alarm",
                        tag: "Alarm"
                    ),
                    TabBarPage(
                        page: SettingsView(
                                showingBottomSheet: $showingProfile,
                                isOpen: $bottomSheetShown
                            )
                            .preferredColorScheme(.dark)
                            .environmentObject(UserData())
                            .environmentObject(TrustNumberData()),
                        icon: "gear",
                        tag: "Settings"
                    )
                ]), showingBottomSheet: $showingProfile)
                
                if self.showingProfile {
                    BottomSheetView(isOpen: self.$bottomSheetShown, maxHeight: hieght) {
                        Rectangle()
                            .fill(Color.white)
                            .overlay(
                                VStack(alignment: .center, spacing: 16) {
                                    Text("HELLO!")
                                        .font(.resistMedium())
                                        .foregroundColor(.darkBlue)
                                    
                                    Text(
                                        """
                                        TODAY IS: DAY OF THE WEEK
                                        YOU HAVE NUMBER OF LESSONS
                                        FIRST ONE AT CLOCK
                                        """
                                    )
                                        .font(.resistMedium())
                                        .foregroundColor(.darkBlue)
                                        .multilineTextAlignment(.center)
                                        .padding(.top, 5)
                                    
                                    Text("WISH YOU A GOOD DAY!")
                                        .font(.resistMedium())
                                        .foregroundColor(.darkBlue)
                                    
                                    Divider()
                                        .background(Color.darkBlue)
                                        .padding(.leading, 30)
                                        .padding(.trailing, 30)
                                }
                            )
                    }.edgesIgnoringSafeArea(.all)
                }
                
            } else {
                VerificationView()
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
