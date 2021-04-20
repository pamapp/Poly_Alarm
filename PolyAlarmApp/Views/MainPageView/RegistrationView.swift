//
//  SignUpView.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 16.04.2021.
//

import SwiftUI
import Combine
import Firebase

struct RegistrationView: View {
    @State private var loadingRegistration = false
    @State private var show = false
    @State private var alert: Bool = false
    @State var nickNameField: String = ""
    @State var groupNumberField: String = ""
    @Binding var phoneNumberDoc: String
    
    private let db = Firestore.firestore()
    
    var verifyFunc: () -> Void
    
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
                                

                                Button(action: {
                                    self.loadingRegistration.toggle()
                                    saveUser(groupnumber: groupNumberField, nickname: nickNameField)
                                    verifyFunc()
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
                
                if self.loadingRegistration {
                    ZStack {
                        CustomBackgroundView()
                            .ignoresSafeArea(.keyboard)
                        VStack {
                            Text("Loading...")
                                .font(.resistMedium(16))
                            ProgressView().progressViewStyle(CircularProgressViewStyle())
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    private func saveUser(groupnumber: String, nickname: String) {
        let docRef = db.collection("users").document(phoneNumberDoc)
        docRef.setData([
            "groupNumber": groupnumber,
            "nickname": nickname
        ])
    }
}
