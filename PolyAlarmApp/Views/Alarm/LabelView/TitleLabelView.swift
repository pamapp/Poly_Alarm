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
