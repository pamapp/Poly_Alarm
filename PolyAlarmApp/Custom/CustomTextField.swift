//
//  CustomTextField.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 05.04.2021.
//

import SwiftUI

struct CustomTextField: View {
    var curWidth: CGFloat
    var curHeight: CGFloat
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
            
        }
            .frame(width: curWidth, height: curHeight, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.darkBlue, lineWidth: 1)
            )
    }

}
