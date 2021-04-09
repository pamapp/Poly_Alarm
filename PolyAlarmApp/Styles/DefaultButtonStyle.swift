//
//  DefaultButtonStyle.swift
//  alarm
//
//  Created by Alina Potapova on 05.04.2021.
//

import SwiftUI

struct DefaultButtonStyle: View {
    var buttonTitle: String
    var buttonWidth: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .stroke(Color.white, lineWidth: 1)
            .frame(width: buttonWidth, height: buttonWidth / 3)
            .overlay(
                Text(buttonTitle)
                    .simpleStyle()
            )
    }
}
