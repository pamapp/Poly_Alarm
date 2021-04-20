//
//  SignUpView.swift
//  alarm
//
//  Created by Alina Potapova on 11.02.2021.
//

import SwiftUI
import Combine
import Firebase

struct VerificationView: View {
    @State private var loadingVerify = false
    @State var phoneNumderField: String = ""
    @State private var codeField: String = "7"
    @State private var alert: Bool = false
    @State private var msg = ""
    @State private var ID = ""
    @State private var show = false
        
    private enum Strings {
        static let verification = "VERIFY"
        static let phoneNumber = "(123)4567890"
        static let code = "+7"
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
                                Text(Strings.verification)
                                    .font(.resistMedium(25))
                                    .foregroundColor(.white)
                                
                                HStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.darkBlue, lineWidth: 1)
                                        .frame(width: 60, height: 60)
                                        .overlay(
                                            Text(Strings.code)
                                                .font(.resistMedium(20))
                                                .foregroundColor(.darkBlue)
                                        )
                                    
                                    CustomTextField(
                                        curWidth: 200,
                                        curHeight: 60,
                                        fieldType: true,
                                        placeholder: Text(Strings.phoneNumber)
                                            .foregroundColor(.darkGray)
                                            .font(.resistMedium(20)),
                                        text: $phoneNumderField
                                    )
                                        .loginDataStyle()
                                        .keyboardType(.numberPad)
                                        .onReceive(Just(phoneNumderField)) { newValue in
                                            let filtered = newValue.filter { "0123456789".contains($0) }
                                            if filtered != newValue {
                                                self.phoneNumderField = filtered
                                            }
                                        }
                                }
                                
                                NavigationLink(destination: OTPView(show: $show, ID: $ID, phoneNumberDB: $phoneNumderField), isActive: $show) {
                                    Button(action: {
                                        self.loadingVerify.toggle()
                                        UIApplication.shared.endEditing()
                                        PhoneAuthProvider.provider().verifyPhoneNumber("+" + self.codeField + self.phoneNumderField, uiDelegate: nil) {
                                            (ID, err) in
                                            if err != nil {
                                                self.msg = (err?.localizedDescription)!
                                                self.alert.toggle()
                                                return
                                            }
                                            self.ID = ID!
                                            self.show.toggle()
                                            self.loadingVerify.toggle()
                                        }
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
                            }.alert(isPresented: $alert, content: {
                                Alert(title: Text(Strings.errorMessage), message: Text(self.msg), dismissButton: .default(Text("Ok")))
                            })
                        )
                }.frame(width: 320, height: 240, alignment: .center)
                
                if self.loadingVerify {
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
}



