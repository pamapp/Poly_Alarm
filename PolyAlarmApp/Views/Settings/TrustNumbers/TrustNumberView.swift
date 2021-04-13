//
//  TrustNumberView.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 06.04.2021.
//

import SwiftUI

struct TrustNumberView: View {
    
    @EnvironmentObject var trustNumData: TrustNumberData
    
    @Binding var editView: Bool
    
    let trustNumber: TrustNumber
    
    var trustNumberIndex: Int {
        trustNumData.trustNumbers.firstIndex(where: { $0.id == trustNumber.id})!
    }
    
    var body: some View {
        ZStack {
            let toggleTrust = Binding<Bool> (
                get: { self.trustNumber.isEnabled },
                set: { newValue in
                    self.trustNumData.trustNumbers[trustNumberIndex].isEnabled = newValue
                }
            )
            
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 300, height: 110, alignment: .center)
                .foregroundColor(trustNumber.isEnabled ? .lightGray : .darkGray)
                .overlay (
                    HStack(alignment: .center, spacing: 45) {
                        Text("\(self.trustNumber.name)")
                            .font(.resistMedium(22))
                            .foregroundColor(.darkBlue)
                
                        Toggle(isOn: toggleTrust) {}
                            .toggleStyle(SwitchToggleStyle(tint: .darkBlue))
                            .labelsHidden()
                            .padding(.leading, -11)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(lineWidth: 1.5)
                                    .frame(width: 51, height: 31, alignment: .center)
                                    .foregroundColor(.darkBlue)
                                    .padding(.leading, -10)
                            )
                                                    
                        Button {
                            self.editView.toggle()
                            print("set")
                        } label: {
                            Image(systemName: "gear")
                                .font(.system(size: 40))
                                .foregroundColor(.darkBlue)
                                .overlay (
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.darkBlue, lineWidth: 2)
                                )
                        }.sheet(isPresented: self.$editView, content: {
                            TrustNumberEditView(
                                trustNumber: trustNumber,
                                name: trustNumData.trustNumbers[trustNumberIndex].name,
                                phoneNumber: trustNumData.trustNumbers[trustNumberIndex].phoneNumber
                            )
                            .environmentObject(self.trustNumData)
                            .preferredColorScheme(.dark)
                        })
                    }
                )
        }
    }
}
