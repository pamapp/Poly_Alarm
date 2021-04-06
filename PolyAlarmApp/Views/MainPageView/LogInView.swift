//
//  LogInView.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 05.04.2021.
//

import SwiftUI
import Combine

struct LogInView: View {

    @State private var loginField: String = ""
    @State private var passwordField: String = ""
    
    private enum Strings {
        static let logIn = "LOG IN"
        static let login = "LOGIN"
        static let password = "PASSWORD"
        static let forgotPassword = "FORGOT PASSWORD?"
        static let letsGo = "LET'S GO!"
    }
    
    var body: some View {
        ZStack {
            CustomBackgroundView()
            
            GeometryReader{ geo in
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.5820884109, green: 0.5749626756, blue: 0.6534177661, alpha: 1)))
                    .overlay(
                        VStack(alignment: .center, spacing: geo.size.height / 16) {
                            Text(Strings.logIn)
                                .font(.resistMedium(25))
                                .foregroundColor(.white)
                                .padding(.top)
                            
                            CustomTextField(fieldType: true, placeholder: Text(Strings.login).foregroundColor(.darkBlue).font(.resistMedium(16)), text: $loginField)
                                .loginDataStyle()
                            
                            CustomTextField(fieldType: false, placeholder: Text(Strings.password).foregroundColor(.darkBlue).font(.resistMedium(16)), text: $passwordField)
                                .loginDataStyle()
                            
                            Button(action: {
                                print("forgot password action")
                            }) {
                                
                                Text(Strings.forgotPassword)
                                    .font(.resistMedium(14))
                                    .foregroundColor(.darkBlue)
                                    .underline()

                            }
                            
                            Button(action: {
                                print("let's go button")
                            }) {
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 110, height: 35)
                                    .foregroundColor(.darkBlue)
                                    .overlay(
                                        Text(Strings.letsGo)
                                            .font(.resistMedium(16))
                                            .foregroundColor(.white)
                                    )
                            }.padding(.bottom)
                        }
                    )
            }.frame(width: 320, height: 320, alignment: .center)
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
