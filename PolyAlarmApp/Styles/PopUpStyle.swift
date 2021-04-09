//
//  PopUpStyle.swift
//  alarm
//
//  Created by Alina Potapova on 05.04.2021.
//

import SwiftUI

struct PopUpStyle: ViewModifier {
    var width: CGFloat
    var height: CGFloat
    func body(content: Content) -> some View {
        content
            .frame(width: width, height: height)
            .background(
                LinearGradient(gradient: Gradient(colors: [.gradientTop, .gradientBottom]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white, lineWidth: 1)
            )
    }
}

