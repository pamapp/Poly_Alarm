//
//  TrustNumberAddView.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 07.04.2021.
//

import SwiftUI
import Combine

struct TrustNumberAddView: View {
    @EnvironmentObject var trustNumData: TrustNumberData
    @Binding var showingAddLabelView: Bool
    
    @State var name: String = ""
    @State var number: String = ""
    @State var isEnabled: Bool = false
    @State var popUpAddTitle: String =
        """
        TRUST NUMBERS
        SETTINGS
        """
    
    var body: some View {
        VStack(spacing: UIScreen.main.bounds.width / 9) {
                
            Text(popUpAddTitle)
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
                TextField("PHONE NUMBER", text: $number)
                    .editDataStyle()
                    .keyboardType(.decimalPad)
                    .onReceive(Just(number)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.number = filtered
                        }
                    }
                
                Divider()
                    .padding(.leading)
                    .padding(.trailing)
            }
            
            HStack(alignment: .center, spacing: UIScreen.main.bounds.width / 10) {
                
                Button (action: {
                    self.cancel()
                }, label: {
                    DefaultButtonStyle(buttonTitle: "CANCEL", buttonWidth: UIScreen.main.bounds.width / 3)
                })
                
                Button (action: {
                    self.createTrustNumber()
                }, label: {
                    DefaultButtonStyle(buttonTitle: "SAVE", buttonWidth: UIScreen.main.bounds.width / 3)
                })
                
            }
            
        }.popUpStyle(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 2)

    }
    
    private func cancel() {
        self.showingAddLabelView.toggle()
    }
    
    private func createTrustNumber() {
        if !name.isEmpty && !number.isEmpty {
            let newTrustNumber = TrustNumber(
                id: UUID(),
                name: name,
                phoneNumber: number,
                isEnabled: true
            )
            self.trustNumData.trustNumbers.append(newTrustNumber)
        }
        self.showingAddLabelView.toggle()
    }
}
