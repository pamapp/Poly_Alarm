//
//  NotifyLabelView.swift
//  alarm
//
//  Created by Alina Potapova on 24.03.2021.
//

import SwiftUI

struct NotifyLabelView: View {
    
    @Binding var isNotify: Bool
    
    @State private var showingEditView = false
    
    @State var date = Date()
    
    var body: some View {
        
        HStack(alignment: .center) {
            Text("NOTIFY YOUR FRIEND")
                .simpleStyle()
            Spacer()
            Toggle(isOn: $isNotify) {}
                .toggleStyle(SwitchToggleStyle(tint: .gray))
                .labelsHidden()
        }
        .padding(.all, 5)
        .padding(.leading, 30)
        .padding(.trailing, 20)
    }
}

