//
//  CustomBackgroundView.swift
//  alarm
//
//  Created by Alina Potapova on 31.03.2021.
//

import SwiftUI

struct CustomBackgroundView: View {
    
    private enum Strings {
        static let polyAlarm = "POLYALARM"
        static let poly = "POLY"
        static let alarm = "ALARM "
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.gradientTop, .gradientBottom]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Spacer()
                    RoundedText(textSize: 48, text: Strings.polyAlarm, color: .gradientTop)
                        .frame(height: 22.0)
                }
                
                HStack {
                    Spacer()
                    Text(Strings.poly)
                        .loginBackgroundStyle(size: 96)
                }.padding(.vertical, -43.0)
                
                Spacer()
                
                HStack {
                    Text(Strings.alarm)
                        .loginBackgroundStyle(size: 96)
                    Spacer()
                }.padding(.vertical, -43.0)
                
                HStack {
                    RoundedText(textSize: 48, text: Strings.polyAlarm, color: .gradientBottom)
                        .frame(height: 22.0)
                    Spacer()
                }
                
            }.padding(.top, 50).padding(.bottom)
        }
    }
}
