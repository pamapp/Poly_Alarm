//
//  SettingsView.swift
//  alarm
//
//  Created by Alina Potapova on 23.03.2021.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userData: UserData

    @State private var showingTimeBefore = false
    @State private var showingTrustNumbers = false
    @State private var showingNickname = false
    @State private var showingGroupNumber = false
    @State private var showingMessageText = false
    @State private var showingSignOutText = false
    
    private enum ImagesTitles {
        static let timeBefore = "clock"
        static let trustNumbers = "phone"
        static let nickname = "person.circle"
        static let groupNumber = "person.2"
        static let message = "text.bubble"
        static let signOut = "chevron.right.square"
    }
    
    private enum SettingsTitles {
        static let timeBefore =
            """
            WAKE UP TIME
            BEFORE CLASS
            """
        static let trustNumbers =
            """
            TRUST
            NUMBERS
            """
        static let nickname =
            """
            CHANGE
            NICKNAME
            """
        static let groupNumber =
            """
            GROUP
            NUMBER
            """
        static let messageText =
            """
            MESSAGE
            TEXT
            """
        static let signOutText =
        """
        SIGN OUT
         
        """
    }

    private enum LabelsTexts {
        static let timeBefore = "IN MINUTE"
        static let nickname = "NICKNAME"
        static let groupNumber = "NUMBER"
        static let messageText = "MESSAGE"
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.gradientTop, .gradientBottom]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 50) {
                Text("SETTINGS")
                    .titleStyle()
                Spacer()
            }
            
            VStack(alignment: .center) {
                
                HStack(alignment: .center) {
                    SettingsButtonView(
                        showingPopUpView: $showingTimeBefore,
                        imageName: ImagesTitles.timeBefore,
                        text: SettingsTitles.timeBefore
                    )
                    
                    SettingsButtonView(
                        showingPopUpView: $showingTrustNumbers,
                        imageName: ImagesTitles.trustNumbers,
                        text: SettingsTitles.trustNumbers
                    ).sheet(
                        isPresented: self.$showingTrustNumbers,
                        content: {
                            TrustNumberListView()
                                .environmentObject(self.userData)
                                .preferredColorScheme(.dark)
                    })
                }
                
                HStack(alignment: .center) {
                    SettingsButtonView(
                        showingPopUpView: $showingNickname,
                        imageName: ImagesTitles.nickname,
                        text: SettingsTitles.nickname
                    )
                    
                    SettingsButtonView(
                        showingPopUpView: $showingGroupNumber,
                        imageName: ImagesTitles.groupNumber,
                        text: SettingsTitles.groupNumber
                    )
                }
                
                HStack(alignment: .center) {
                    SettingsButtonView(
                        showingPopUpView: $showingMessageText,
                        imageName: ImagesTitles.message,
                        text: SettingsTitles.messageText
                    )
                    
                    SettingsButtonView(
                        showingPopUpView: $showingSignOutText,
                        imageName: ImagesTitles.signOut,
                        text: SettingsTitles.signOutText
                    )
                }
                
            }
            
            if self.showingTimeBefore {
                ZStack {
                    CustomBackgroundBlur(effect: UIBlurEffect(style: .regular))
                        .opacity(0.9)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation{
                                self.showingTimeBefore.toggle()
                            }
                        }

                    AlarmPopUpTextEditView(
                        data: $userData.data.timeBefore,
                        showingEditLabelView: $showingTimeBefore,
                        edittingData: userData.data.timeBefore,
                        settingsTitle: SettingsTitles.timeBefore,
                        textFieldTitle: LabelsTexts.timeBefore,
                        moreThanOneLine: true
                    )
                }
            }
            
            if self.showingNickname {
                ZStack {
                    CustomBackgroundBlur(effect: UIBlurEffect(style: .regular))
                        .opacity(0.9)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation{
                                self.showingNickname.toggle()
                            }
                        }

                    AlarmPopUpTextEditView(
                        data: $userData.data.nickname,
                        showingEditLabelView: $showingNickname,
                        edittingData: userData.data.nickname,
                        settingsTitle: SettingsTitles.nickname,
                        textFieldTitle: LabelsTexts.nickname,
                        moreThanOneLine: true
                    )
                }
            }
            
            if self.showingGroupNumber {
                ZStack {
                    CustomBackgroundBlur(effect: UIBlurEffect(style: .regular))
                        .opacity(0.9)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation{
                                self.showingGroupNumber.toggle()
                            }
                        }

                    AlarmPopUpTextEditView(
                        data: $userData.data.groupNumber,
                        showingEditLabelView: $showingGroupNumber,
                        edittingData: userData.data.groupNumber,
                        settingsTitle: SettingsTitles.groupNumber,
                        textFieldTitle: LabelsTexts.groupNumber,
                        moreThanOneLine: true
                    )
                }
            }
            
            if self.showingMessageText {
                ZStack {
                    CustomBackgroundBlur(effect: UIBlurEffect(style: .regular))
                        .opacity(0.9)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation{
                                self.showingMessageText.toggle()
                            }
                        }

                    AlarmPopUpTextEditView(
                        data: $userData.data.messageText,
                        showingEditLabelView: $showingMessageText,
                        edittingData: userData.data.messageText,
                        settingsTitle: SettingsTitles.messageText,
                        textFieldTitle: LabelsTexts.messageText,
                        moreThanOneLine: true
                    )
                }
            }

        }
    }
}
