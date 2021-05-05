//
//  TrustNumberListView.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 06.04.2021.
//

import SwiftUI

struct TrustNumberListView : View {
    
    @EnvironmentObject var trustNumData: TrustNumberData

    @State var showingAddNumberView = false
    
    @State var showingEditNumberView: Bool = false

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
                        ForEach(trustNumData.trustNumbers, id: \.id) { trustNumber in
                            TrustNumberView(
                                trustNumber: trustNumber,
                                showingEditTrustNumView: $showingEditNumberView
                            ).environmentObject(self.trustNumData)
                        }
                    }
                }.padding(.top, 30)
                
                Button (action: {
                    self.showingAddNumberView.toggle()
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
            
            if self.showingAddNumberView {
                ZStack{
                    CustomBackgroundBlur(effect: UIBlurEffect(style: .regular))
                    .opacity(0.9)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation{
                            self.showingAddNumberView.toggle()
                        }
                    }
                    TrustNumberAddView(showingAddLabelView: $showingAddNumberView)
                        .preferredColorScheme(.dark)
                        .environmentObject(self.trustNumData)

                }
            }
        }
    }

}
