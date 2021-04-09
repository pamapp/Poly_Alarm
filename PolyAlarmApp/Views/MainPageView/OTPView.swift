//
//  OTPView.swift
//  PolyAlarmApp
//
//  Created by deanny on 08.04.2021.
//

import SwiftUI
import Combine
import Firebase

struct OTPView: View {
    @Binding var show : Bool
    @Binding var ID : String
    @State private var code = ""
    @State private var msg = ""
    @State private var alert = false
    @State private var titles: [String] = [ Strings.enterCode, Strings.verCode ]
    
    private enum Strings {
        static let enterCode =
            """
            ENTER YOUR
            VERIFICATION CODE
            """
        static let verCode = "012345"
        static let verify = "VERIFY"
    }
    
    var body: some View {
            ZStack {
                CustomBackgroundView()
                    .ignoresSafeArea(.keyboard)
                    .onTapGesture{
                        UIApplication.shared.endEditing()
                    }
                
                GeometryReader{ geo in
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                        .foregroundColor(Color.init(#colorLiteral(red: 0.5820884109, green: 0.5749626756, blue: 0.6534177661, alpha: 1)))
                        .overlay(
                            VStack(alignment: .center, spacing: geo.size.height / 12) {
                                Text(Strings.enterCode)
                                    .font(.resistMedium())
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding(.top)
                                
                                CustomTextField(
                                    curWidth: 260,
                                    curHeight: 60,
                                    fieldType: true,
                                    placeholder: Text(Strings.verCode)
                                        .foregroundColor(.darkGray)
                                        .font(.resistMedium(20)),
                                    text: $code
                                )
                                    .loginDataStyle()
                                    .keyboardType(.numberPad)
                                    .onReceive(Just(code)) { newValue in
                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue {
                                            self.code = filtered
                                        }
                                    }
                                
                                Button(action: {
                                    UIApplication.shared.endEditing()
                                    let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.ID, verificationCode: self.code)
                                    Auth.auth().signIn(with: credential) {
                                        (res, err) in
                                        if err != nil {
                                            self.msg = (err?.localizedDescription)!
                                            self.alert.toggle()
                                            return
                                        }
                                        UserDefaults.standard.set(true, forKey: "status")
                                        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                                    }
                                }) {
                                    RoundedRectangle(cornerRadius: 15)
                                        .frame(width: 125, height: 45)
                                        .foregroundColor(.darkBlue)
                                        .overlay(
                                            Text(Strings.verify)
                                                .simpleStyle()
                                        )
                                    
                                }.alert(isPresented: $alert) {
                                    Alert(title: Text("Error"), message: Text(self.msg), dismissButton: .default(Text("Ok")))
                                }
                                
                                Button(action: {
                                    self.show.toggle()
                                }) {
                                    Text("BACK TO NUMBER ENTRY")
                                        .font(.resistMedium(16))
                                        .foregroundColor(.darkBlue)
                                        .underline()
                                }.padding(.bottom)
                            }
                        )
                }.frame(width: 320, height: 320, alignment: .center)
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

