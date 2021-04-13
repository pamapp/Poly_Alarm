//
//  TrustNumberListView.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 06.04.2021.
//

import SwiftUI

struct TrustNumberListView : View {
    
    @EnvironmentObject var trustNumData: TrustNumberData

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
                        ForEach(self.trustNumData.trustNumbers.indexed(), id: \.1.id) { index, _ in
                            TrustNumberView(
                                editView: $showingEditView,
                                trustNumber: self.trustNumData.trustNumbers[index]
                            )
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
                        .environmentObject(self.trustNumData)
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

                    
                }
            }
        }
    }

}
