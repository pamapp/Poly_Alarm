//
//  LoginView.swift
//  alarm
//
//  Created by Alina Potapova on 11.02.2021.
//

import SwiftUI
import Combine

struct LoginView: View {
    @State private var needToLogin: Bool = true
    @State private var phoneNumderField: String = ""
    @State private var userNameField: String = ""
    @State private var passwordField: String = ""
    @State private var showingAlert: Bool = false
    @State private var titles: [String] = [ Strings.phoneNumber, Strings.nickName, Strings.password ]
    
    @State var hide: Bool = false
    
    private enum Strings {
        static let phoneNumber = "PHONE NUMBER"
        static let nickName = "NICKNAME"
        static let password = "PASSWORD"
        static let signUp = "SIGN UP"
        static let letsGo = "LET'S GO!"
    }
    
    var body: some View {
        ZStack {
            LoginBackgroundView()
                
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 320, height: 320, alignment: .center)
                .foregroundColor(Color.init(#colorLiteral(red: 0.5820884109, green: 0.5749626756, blue: 0.6534177661, alpha: 1)))
                .overlay(
                    VStack(alignment: .center, spacing: 15) {
                        Text(Strings.signUp)
                            .font(.resistMedium(25))
                            .foregroundColor(.white)
                        
                        CustomTextField(fieldType: true, placeholder: Text(Strings.phoneNumber).foregroundColor(.darkBlue).font(.resistMedium(16)), text: $phoneNumderField)
                            .loginDataStyle()
                            .keyboardType(.decimalPad)
                            .onReceive(Just(phoneNumderField)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.phoneNumderField = filtered
                                }
                            }
                        
                        CustomTextField(fieldType: true, placeholder: Text(Strings.nickName).foregroundColor(.darkBlue).font(.resistMedium(16)), text: $userNameField)
                            .loginDataStyle()
                        
                        CustomTextField(fieldType: false, placeholder: Text(Strings.password).foregroundColor(.darkBlue).font(.resistMedium(16)), text: $passwordField)
                            .loginDataStyle()
                        
                        Button(action: {
                            self.needToLogin = false
                            if phoneNumderField.count != 11 {
                                self.showingAlert = true
                            }
                        }) {
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 110, height: 35)
                                .foregroundColor(.darkBlue)
                                .overlay(
                                    Text(Strings.letsGo)
                                        .font(.resistMedium(16))
                                        .foregroundColor(.white)
                                )
                        }.alert(isPresented: $showingAlert, content: {
                            Alert(title: Text("Wrong data!"), message: Text("Сheck the correctness of filling!"), dismissButton: .default(Text("Ok")))
                        })
                    }
                )
        }
    }
}

struct CustomTextField: View {
    var fieldType: Bool
    var placeholder: Text
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    @State var hide: Bool = false
    @Binding var text: String

    var body: some View {
        
        HStack (alignment: .center) {
            
            ZStack(alignment: .center)
            {
                if text.isEmpty { placeholder }

                if !fieldType
                {
                    if self.hide
                    {
                        TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                    }
                    else
                    {
                        SecureField("", text: $text, onCommit: commit)
                    }
                }
                
                ZStack (alignment: .center)
                {
                    if fieldType {
                        TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                    }
                }
            }

//            if !fieldType
//            {
//                Button (action: {
//                    self.hide.toggle()
//                }) {
//                    Image(systemName: self.hide ? "eye.fill": "eye.slash.fill")
//                        .foregroundColor((self.hide) ? Color.darkBlue : Color.darkGray)
//                        .padding(.trailing, 5)
//                }
//            }
            
        }
            .frame(width: 260, height: 50, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.darkBlue, lineWidth: 1)
            )
    }

}



