//
//  SoundLabelView.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 07.04.2021.
//

import SwiftUI

struct SoundLabelView: View {
    @Binding var ringtone: Ringtone
    @Binding var showingEditSoundView: Bool
    var body: some View {
        ZStack(alignment: .center) {
            HStack {
                Text("SOUND")
                    .simpleStyle()
                Spacer()
                
                Button (action: {
                    withAnimation {
                        self.showingEditSoundView.toggle()
                    }
                }, label: {
                    Text(ringtone.fullName.uppercased())
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
