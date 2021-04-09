//
//  SettingsButtonView.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 06.04.2021.
//

import SwiftUI

struct SettingsButtonView: View {
    
    @Binding var showingPopUpView: Bool
    @State var imageName: String
    @State var text: String
    
    var body: some View {
        VStack {
            Button(action: {
                self.showingPopUpView.toggle()
            }, label: {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 110, height: 110, alignment: .center)
                    .foregroundColor(Color.white.opacity(0.8))
                    .overlay(
                        Image(systemName: imageName)
                            .foregroundColor(.darkBlue)
                            .font(.system(size: 45))
                    )
            })
            .padding(.leading)
            .padding(.trailing)
            
            Text(text)
                .font(.resistMedium(12))
                .foregroundColor(.darkGray)
                .multilineTextAlignment(.center)
        }.padding()
    }
}
