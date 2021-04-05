//
//  CustomTextField.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 05.04.2021.
//

import SwiftUI

struct CustomTextField: View {
    var fieldType: Bool
    var placeholder: Text
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    @State var hide: Bool = false
    @Binding var text: String

    var body: some View {
        
        HStack (alignment: .center) {
            
            ZStack(alignment: .center)
            {
                if text.isEmpty { placeholder }

                if !fieldType
                {
                    if self.hide
                    {
                        TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                    }
                    else
                    {
                        SecureField("", text: $text, onCommit: commit)
                    }
                }
                
                ZStack (alignment: .center)
                {
                    if fieldType {
                        TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                    }
                }
            }

//            if !fieldType
//            {
//                Button (action: {
//                    self.hide.toggle()
//                }) {
//                    Image(systemName: self.hide ? "eye.fill": "eye.slash.fill")
//                        .foregroundColor((self.hide) ? Color.darkBlue : Color.darkGray)
//                        .padding(.trailing, 5)
//                }
//            }
            
        }
            .frame(width: 260, height: 50, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.darkBlue, lineWidth: 1)
            )
    }

}
