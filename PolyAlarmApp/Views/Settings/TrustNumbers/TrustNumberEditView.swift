//
//  TrustNumberEditView.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 13.04.2021.
//


import SwiftUI
import Combine

struct TrustNumberEditView: View {
    @Environment(\.presentationMode) var isPresented
    @EnvironmentObject var trustNumData: TrustNumberData
    
    let trustNumber: TrustNumber
    
    @State var name: String
    @State var phoneNumber: String
    
    @State var popUpEditTitle: String =
    """
    TRUST NUMBERS
    SETTINGS
    """
    
    var trustNumberIndex: Int {
        trustNumData.trustNumbers.firstIndex(where: { $0.id == trustNumber.id})!
    }
    
    var body: some View {
        VStack(spacing: UIScreen.main.bounds.width / 9) {
                
            Text(popUpEditTitle)
                .simpleStyle()
                .multilineTextAlignment(.center)
            
            VStack {
                TextField("NAME", text: $name)
                    .editDataStyle()
                
                Divider()
                    .padding(.leading)
                    .padding(.trailing)
            }
            
            VStack {
                TextField("PHONE NUMBER", text: $phoneNumber)
                    .editDataStyle()
                    .keyboardType(.decimalPad)
                    .onReceive(Just(phoneNumber)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.phoneNumber = filtered
                        }
                    }
                
                Divider()
                    .padding(.leading)
                    .padding(.trailing)
            }
            
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
    
    private func delete() {
        trustNumData.trustNumbers.remove(at: trustNumberIndex)
        self.isPresented.wrappedValue.dismiss()
    }
    
    private func done() {
        if !name.isEmpty && !phoneNumber.isEmpty {
            trustNumData.trustNumbers[trustNumberIndex].name = name
            trustNumData.trustNumbers[trustNumberIndex].phoneNumber = phoneNumber
        }
        self.isPresented.wrappedValue.dismiss()
    }
}
