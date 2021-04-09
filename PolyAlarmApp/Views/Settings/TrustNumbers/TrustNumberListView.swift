//
//  TrustNumberListView.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 06.04.2021.
//

import SwiftUI

struct TrustNumberListView : View {
    
    @EnvironmentObject var userData: UserData

    @State private var showingAddView = false
    
    @State private var showingEditView = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.gradientTop, .gradientBottom]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 30) {
                Text("TRUST NUMBERS")
                    .simpleStyle()
                    .padding()
                    .padding(.top)

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .center, spacing: 40) {
                        ForEach(self.userData.data.trustNumbers) { number in
                            TrustNumberView(editView: $showingEditView, trustNumber: number)
                                .environmentObject(self.userData)
                        }
                    }
                }.padding(.top, 30)
                
                Button (action: {
                    self.showingAddView.toggle()
                }, label: {
                    RoundedRectangle(cornerRadius: 15.0)
                        .stroke(Color.white, lineWidth: 1)
                        .frame(width: 300, height: 110, alignment: .center)
                        .overlay(
                            VStack {
                                Image(systemName: "phone.badge.plus")
                                    .foregroundColor(.white)
                                    .font(.system(size: 25))
                                Text("ADD TRUST NUMBER")
                                    .simpleStyle()
                            }
                    )
                }).padding(.bottom).padding(.top)
            }
            
            if self.showingAddView {
                ZStack{
                    CustomBackgroundBlur(effect: UIBlurEffect(style: .regular))
                    .opacity(0.9)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation{
                            self.showingAddView.toggle()
                        }
                    }
                    TrustNumberAddView(showingAddLabelView: $showingAddView)
                        .environmentObject(self.userData)
                        .preferredColorScheme(.dark)

                }
            }
            
            if self.showingEditView {
                ZStack{
                    CustomBackgroundBlur(effect: UIBlurEffect(style: .regular))
                    .opacity(0.9)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation{
                            self.showingAddView.toggle()
                        }
                    }
                    VStack(spacing: UIScreen.main.bounds.width / 9) {
                        Text(
                            """
                            TRUST NUMBERS
                            SETTINGS
                            """
                        )
                            .simpleStyle()
                            .multilineTextAlignment(.center)
                        
                        HStack(alignment: .center, spacing: UIScreen.main.bounds.width / 10) {
                        
                            Button (action: {
                                self.delete()
                            }, label: {
                                DefaultButtonStyle(buttonTitle: "DELETE", buttonWidth: UIScreen.main.bounds.width / 3)
                            })
                            
                            Button (action: {
                                self.done()
                            }, label: {
                                DefaultButtonStyle(buttonTitle: "DONE", buttonWidth: UIScreen.main.bounds.width / 3)
                            })
                            
                        }
                    }.popUpStyle(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 2)
                }
            }
        }
    }
    private func delete() {
        self.showingEditView.toggle()
    }
    
    private func done() {
//        if !name.isEmpty && !number.isEmpty {
//            let newTrustNumber = TrustNumber(
//                id: UUID(),
//                name: name,
//                phoneNumber: number,
//                isEnabled: true
//            )
//            self.userData.data.trustNumbers.append(newTrustNumber)
//        }
        self.showingEditView.toggle()
    }

}
