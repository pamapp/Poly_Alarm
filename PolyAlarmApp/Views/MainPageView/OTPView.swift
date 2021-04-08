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
        static let enterCode = "Enter your verification code"
        static let verCode = "012345"
    }
    
    var body: some View {
        ZStack {
            CustomBackgroundView()
            
            GeometryReader{ geo in
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.5820884109, green: 0.5749626756, blue: 0.6534177661, alpha: 1)))
                    .overlay(
                        VStack(alignment: .center, spacing: geo.size.height / 12) {
                            Text(Strings.enterCode)
                                .font(.resistMedium(25))
                                .foregroundColor(.white)
                            
                            CustomTextField(curWidth: 260, curHeight: 60, fieldType: true, placeholder: Text(Strings.verCode).foregroundColor(.darkGray).font(.resistMedium(20)), text: $code)
                                .loginDataStyle()
                                .keyboardType(.numberPad)
                                .onReceive(Just(code)) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0) }
                                    if filtered != newValue {
                                        self.code = filtered
                                    }
                                }
                            
                            Button(action: {
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
                                Text("Verify")
                                    .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                            }.alert(isPresented: $alert) {
                                Alert(title: Text("Error"), message: Text(self.msg), dismissButton: .default(Text("Ok")))
                            }
                            Button(action: {
                                self.show.toggle()
                            }) {
                                Image(systemName: "chevron.left")
                                    .font(.resistMedium(25))
                            }
                        }
                    )
            }.frame(width: 320, height: 240, alignment: .center)
        }
    }
}
