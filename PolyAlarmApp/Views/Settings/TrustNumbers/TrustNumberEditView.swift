//
//  TrustNumberEditView.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 13.04.2021.
//


import SwiftUI
import Combine

struct TrustNumberEditView: View {
    
    @ObservedObject var trustNumber: TrustNumber
    
    @State var name: String
    @State var phoneNumber: String
    
    var deleteAction: (TrustNumber) -> Void
    
    @Binding var showingEditTrustNumView: Bool
    
    @State var popUpEditTitle: String =
    """
    TRUST NUMBERS
    SETTINGS
    """
    
    var body: some View {
        VStack(spacing: UIScreen.main.bounds.width / 12) {
                
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
            
        }.popUpStyle(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 2.3)

    }
    private func delete() {
        deleteAction(trustNumber)
        self.showingEditTrustNumView.toggle()
    }
    
    private func done() {
        if !name.isEmpty && !phoneNumber.isEmpty {
            trustNumber.name = name
            trustNumber.phoneNumber = phoneNumber
        }

        self.showingEditTrustNumView.toggle()
    }
}
