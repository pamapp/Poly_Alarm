//
//  SignUpView.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 16.04.2021.
//

import SwiftUI
import Combine

struct RegistrationView: View {
    @State private var loadingSignUp = false
    @State private var show = false
    @State private var alert: Bool = false
    @State private var nickNameField: String = ""
    @State private var groupNumberField: String = ""
        
    private enum Strings {
        static let registration = "REGISTRATION"
        static let nickName = "NICKNAME"
        static let groupNumber = "GROUP NUMBER"
        static let letsGo = "LET'S GO!"
        static let errorMessage = "Error"
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                CustomBackgroundView()
                    .ignoresSafeArea(.keyboard)
                    .onTapGesture{
                        UIApplication.shared.endEditing()
                    }
                
                GeometryReader{ geo in
                    RoundedRectangle(cornerRadius: 20)
                        .ignoresSafeArea(.keyboard)
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                        .foregroundColor(Color.init(#colorLiteral(red: 0.5820884109, green: 0.5749626756, blue: 0.6534177661, alpha: 1)))
                        .overlay(
                            VStack(alignment: .center, spacing: geo.size.height / 12) {
                                Text(Strings.registration)
                                    .font(.resistMedium(25))
                                    .foregroundColor(.white)
                                
                                CustomTextField(
                                    curWidth: 265,
                                    curHeight: 60,
                                    fieldType: true,
                                    placeholder: Text(Strings.nickName)
                                        .foregroundColor(.darkGray)
                                        .font(.resistMedium(20)),
                                    text: $nickNameField
                                )
                                .loginDataStyle()
                                .keyboardType(.numberPad)
                                
                                CustomTextField(
                                    curWidth: 265,
                                    curHeight: 60,
                                    fieldType: true,
                                    placeholder: Text(Strings.groupNumber)
                                        .foregroundColor(.darkGray)
                                        .font(.resistMedium(20)),
                                    text: $groupNumberField
                                )
                                .loginDataStyle()
                                .keyboardType(.numberPad)
                                .onReceive(Just(groupNumberField)) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0) }
                                    if filtered != newValue {
                                        self.groupNumberField = filtered
                                    }
                                }
                                

                                Button(action: {
                                    self.loadingSignUp.toggle()
//                                    UIApplication.shared.endEditing()
//                                    PhoneAuthProvider.provider().verifyPhoneNumber("+" + self.codeField + self.phoneNumderField, uiDelegate: nil) {
//                                        (ID, err) in
//                                        if err != nil {
//                                            self.msg = (err?.localizedDescription)!
//                                            self.alert.toggle()
//                                            return
//                                        }
//                                        self.ID = ID!
//                                        self.show.toggle()
//                                        self.loadingVerify.toggle()
//                                    }
                                }) {
                                    RoundedRectangle(cornerRadius: 15)
                                        .frame(width: 125, height: 45)
                                        .shadow(radius: 0.2)
                                        .padding(10)
                                        .foregroundColor(.darkBlue)
                                        .overlay(
                                            Text(Strings.letsGo)
                                                .simpleStyle()
                                        )
                                }
                            }
                        )
                }.frame(width: 320, height: 350, alignment: .center)
                
//                if self.loadingSignUp {
//                    ZStack {
//                        CustomBackgroundView()
//                            .ignoresSafeArea(.keyboard)
//                        VStack {
//                            Text("Loading...")
//                                .font(.resistMedium(16))
//                            ProgressView().progressViewStyle(CircularProgressViewStyle())
//                        }
//                    }
//                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
