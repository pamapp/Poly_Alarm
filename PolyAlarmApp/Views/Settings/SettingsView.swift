//
//  SettingsView.swift
//  alarm
//
//  Created by Alina Potapova on 23.03.2021.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var delegate = NotificationDelegate()
    
    @State private var settingImages: [String] =
    [
        "clock"        , "phone",
        "person.circle", "person.2",
        "speaker.2"    , "text.bubble"
    ]

    @State private var settingText: [String] =
    [
        """
        WAKE UP TIME
        BEFORE CLASS
        """
        ,
        """
        TRUST
        NUMBERS
        """
        ,
        """
        CHANGE
        NICKNAME
        """
        ,
        """
        GROUP
        NUMBER
        """
        ,
        """
        DEFAULT
        RINGTONE
        """
        ,
        """
        MESSAGE
        TEXT
        """
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.gradientTop, .gradientBottom]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 50) {
                Text("SETTINGS")
                    .titleStyle()
                Spacer()
            }
            
            VStack(alignment: .center) {
                ForEach(0..<3) { x in
                    HStack(alignment: .center) {
                        ForEach(0..<2) { y in
                            VStack {
                                Button(action: {
                                    print("set")
                                }, label: {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 110, height: 110, alignment: .center)
                                        .foregroundColor(Color.white.opacity(0.8))
                                        .overlay(
                                            Image(systemName: settingImages[getIndex(row: x, column: y)])
                                                .foregroundColor(.darkBlue)
                                                .font(.system(size: 45))
                                        )
                                })
                                .padding(.leading)
                                .padding(.trailing)
                                .onAppear(perform: {
                                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (_, _) in }
                                    UNUserNotificationCenter.current().delegate = delegate
                                })
                                .alert(isPresented: $delegate.alert, content: {
                                    Alert(title: Text("Message"), message: Text("Reply Button is pressed"), dismissButton: .destructive(Text("OK")))
                                })
                                
                                Text(settingText[getIndex(row: x, column: y)])
                                    .font(.resistMedium(12))
                                    .foregroundColor(Color.init(#colorLiteral(red: 0.424826026, green: 0.4187176526, blue: 0.4623801708, alpha: 1)))
                                    .multilineTextAlignment(.center)
                            }.padding()
                        }
                    }
                }
            }.padding(.top, 40)
        }
    }
    
    private func getIndex(row: Int, column: Int) -> Int {
        let x = row
        var y = column
        
        if x == 1 {
            y = y + 1
        }
        if x == 2 {
            y = y + 2
        }
        return x + y
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
