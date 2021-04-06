//
//  MainPageView.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 05.04.2021.
//

import SwiftUI
import Combine

struct MainPageView: View {
    
    @State private var helloText: String =
        """
        IT`S TIME TO WAKE UP AND
        MAKE YOUR DREAMS COME TRUE
        """
    
    private enum Strings {
        static let signUp = "SIGN UP"
        static let logIn = "LOG IN"
        static let or = "OR"
    }
    
    var body: some View {
        ZStack {
            CustomBackgroundView()
                
            GeometryReader{ geo in
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.5820884109, green: 0.5749626756, blue: 0.6534177661, alpha: 1)))
                    .overlay(
                        VStack(alignment: .center, spacing: geo.size.height / 10) {
                            Text(helloText)
                                .font(.resistMedium(14))
                                .foregroundColor(.darkBlue)
                                .multilineTextAlignment(.center)
                                
                            Button(action: {
                                print("SignUpToggle")
                            }) {
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 180, height: 35)
                                    .foregroundColor(.darkBlue)
                                    .overlay(
                                        Text(Strings.signUp)
                                            .font(.resistMedium())
                                            .foregroundColor(.white)
                                    )
                            }
                            
                            Text(Strings.or)
                                .font(.resistMedium())
                                .foregroundColor(.darkBlue)
                            
                            Button(action: {
                                print("LogInToggle")
                            }) {
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 180, height: 35)
                                    .foregroundColor(.darkBlue)
                                    .overlay(
                                        Text(Strings.logIn)
                                            .font(.resistMedium())
                                            .foregroundColor(.white)
                                    )
                            }
                        }
                    )
            }.frame(width: 320, height: 320, alignment: .center)
        }
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
