//
//  TitleLabelView.swift
//  alarm
//
//  Created by Alina Potapova on 24.03.2021.
//

import SwiftUI

struct TitleLabelView: View {
    @Binding var label: String
    @Binding var showingEditLabelView: Bool
    var body: some View {
        ZStack(alignment: .center) {
                HStack {
                    Text("LABEL")
                        .simpleStyle()
                    Spacer()
                    Button (action: {
                        withAnimation {
                            self.showingEditLabelView.toggle()
                        }
                    }, label: {
                        Text(label)
                            .underline()
                            .simpleStyle()
                            
                    })
                }
                .padding(.all, 5)
                .padding(.leading, 30)
                .padding(.trailing, 20)
        }
    }
}

struct AlarmEditNameView: View {
    @Binding var label: String
    @Binding var showingEditLabelView: Bool
    @State var edittingLabel: String
    
    var body: some View {
            
            VStack(spacing: 30) {
                
                Text("LABEL SETTINGS")
                    .simpleStyle()
                    .padding(.bottom)
                
                VStack {
                    TextField("ALARM", text: $edittingLabel)
                        .simpleStyle()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .autocapitalization(.allCharacters)
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
                
            }.popUpStyle(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 3.4)

    }
    
    private func save() {
        label = edittingLabel
        self.showingEditLabelView.toggle()
    }
    
    private func cancel() {
        self.showingEditLabelView.toggle()
    }
}
