//
//  TitleStyles.swift
//  alarm
//
//  Created by Alina Potapova on 30.03.2021.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.resistMedium())
            .foregroundColor(.white)
            .padding(.top, 10)
    }
}

struct SimpleText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.resistMedium())
            .foregroundColor(.white)
    }
}

struct LoginBackgroundText: ViewModifier {
    var textSize: CGFloat
    func body(content: Content) -> some View {
     content
        .font(.resistMedium(textSize))
        .foregroundColor(Color.white)
        .opacity(0.4)
    }
}

struct LoginDataText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.resistMedium(20))
            .foregroundColor(.darkBlue)
            .accentColor(.darkBlue)
            .multilineTextAlignment(.center)
            .autocapitalization(.allCharacters)
    }
}

struct EditDataText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.resistMedium())
            .foregroundColor(.white)
            .accentColor(.white)
            .multilineTextAlignment(.center)
            .autocapitalization(.allCharacters)
    }
}

struct RoundedText: View {
    var textSize: CGFloat
    var text: String
    var color: Color
    var body: some View {
        ZStack {
             Text(text)
                .loginBackgroundStyle(size: textSize)
                .padding(.bottom, 2)
            
            Text(text)
                .loginBackgroundStyle(size: textSize)
                .padding(.top, 2)
            
            Text(text)
                .loginBackgroundStyle(size: textSize)
                .padding(.trailing, 2)
            
            Text(text)
                .loginBackgroundStyle(size: textSize)
                .padding(.leading, 2)
            
            Text(text)
                .font(.resistMedium(textSize))
                .foregroundColor(color)
        }
    }
}
