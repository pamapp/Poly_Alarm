//
//  TrustNumberView.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 06.04.2021.
//

import SwiftUI

struct TrustNumberView: View {
    @EnvironmentObject var trustNumData: TrustNumberData
    
    @ObservedObject var trustNumber: TrustNumber
    
    @Binding var showingEditTrustNumView: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 300, height: 110, alignment: .center)
                .foregroundColor(trustNumber.isEnabled ? .lightGray : .darkGray)
                .overlay (
                    HStack(alignment: .center, spacing: 45) {
                        Text("\(self.trustNumber.name)")
                            .font(.resistMedium(22))
                            .foregroundColor(.darkBlue)
                            .lineLimit(5)
                
                        Toggle(isOn: $trustNumber.isEnabled) {}
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
                            self.showingEditTrustNumView.toggle()
                        } label: {
                            Image(systemName: "gear")
                                .font(.system(size: 40))
                                .foregroundColor(.darkBlue)
                                .overlay (
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.darkBlue, lineWidth: 2)
                                )
                        }.sheet(isPresented: self.$showingEditTrustNumView, content: {
                            TrustNumberEditView(
                                trustNumber: self.trustNumber,
                                name: trustNumber.name,
                                phoneNumber: trustNumber.phoneNumber,
                                deleteAction: trustNumData.delete,
                                showingEditTrustNumView: $showingEditTrustNumView
                            )
                            .preferredColorScheme(.dark)
                        })
                    }
                )
        }
    }
}
