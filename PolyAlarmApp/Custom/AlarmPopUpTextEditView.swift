//
//  AlarmPopUpView.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 06.04.2021.
//

import SwiftUI

struct AlarmPopUpTextEditView: View {
    @Binding var data: String
    @Binding var showingPopUpEditView: Bool
    @State var edittingData: String
    @State var settingsTitle: String
    @State var textFieldTitle: String
    @State var moreThanOneLine: Bool
    
    var body: some View {
        VStack(spacing: moreThanOneLine ? UIScreen.main.bounds.width / 9 : UIScreen.main.bounds.width / 9.5) {
            Text(settingsTitle)
                .simpleStyle()
                .multilineTextAlignment(.center)
                .padding(.bottom, (moreThanOneLine ? 0 : 10))
            
            VStack {
                TextField(textFieldTitle, text: $edittingData)
                    .editDataStyle()
                
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
                    self.save()
                }, label: {
                    DefaultButtonStyle(buttonTitle: "SAVE", buttonWidth: UIScreen.main.bounds.width / 3)
                })
            }
        }.popUpStyle(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 3)
    }
    
    private func save() {
        if !edittingData.isEmpty {
            data = edittingData
        }
        self.showingPopUpEditView.toggle()
    }
    
    private func cancel() {
        self.showingPopUpEditView.toggle()
    }
}
