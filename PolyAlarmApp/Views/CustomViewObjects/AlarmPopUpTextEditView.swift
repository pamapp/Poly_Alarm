//
//  AlarmPopUpView.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 06.04.2021.
//

import SwiftUI

enum ActiveAlert {
    case num, range
}

struct AlarmPopUpTextEditView: View {
    @Binding var data: String
    @Binding var showingPopUpEditView: Bool
    
    @State private var alert = false
    @State private var activeAlert: ActiveAlert = .num
    
    @State var numericOnly: Bool
    
    @State var edittingData: String
    @State var settingsTitle: String
    @State var textFieldTitle: String
    @State var moreThanOneLine: Bool
    
    private enum ErrorStrings {
        static let error = "ERROR"
        static let errorMsgNum = "Data can only contain numbers"
        static let errorMsgRange = "Data must be less than 300"
    }
    
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
                    if edittingData.isEmpty {
                        self.showingPopUpEditView.toggle()
                    } else {
                        if numericOnly {
                            if !edittingData.isNumeric {
                                self.activeAlert = .num
                                self.alert.toggle()
                            } else if Int(edittingData) ?? 0 > 300 {
                                self.activeAlert = .range
                                self.alert.toggle()
                            } else {
                                self.save()
                            }
                        } else {
                            self.save()
                        }
                    }
                }, label: {
                    DefaultButtonStyle(buttonTitle: "SAVE", buttonWidth: UIScreen.main.bounds.width / 3)
                }).alert(isPresented: $alert) {
                    switch activeAlert {
                    case .num:
                        return Alert(title: Text(ErrorStrings.error), message: Text(ErrorStrings.errorMsgNum), dismissButton: .default(Text("Ok")))
                    case .range:
                        return Alert(title: Text(ErrorStrings.error), message: Text(ErrorStrings.errorMsgRange), dismissButton: .default(Text("Ok")))
                    }
                }
            }
        }.popUpStyle(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 3)
    }
    
    private func save() {
        let newData = edittingData
        
        if !newData.isEmpty {
            data = newData
        }
        
        self.showingPopUpEditView.toggle()
    }
    
    private func cancel() {
        self.showingPopUpEditView.toggle()
    }
}
