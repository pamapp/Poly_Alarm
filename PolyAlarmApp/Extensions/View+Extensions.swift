//
//  View+Extensions.swift
//  alarm
//
//  Created by Alina Potapova on 30.03.2021.
//

import SwiftUI

extension View {
    public func titleStyle() -> some View {
        self.modifier(Title())
    }
    
    public func simpleStyle() -> some View {
        self.modifier(SimpleText())
    }
    
    public func loginBackgroundStyle(size: CGFloat) -> some View {
        self.modifier(LoginBackgroundText(textSize: size))
    }
    
    public func loginDataStyle() -> some View {
        self.modifier(LoginDataText())
    }
    
    public func editDataStyle() -> some View {
        self.modifier(EditDataText())
    }
    
    public func popUpStyle(width: CGFloat, height: CGFloat) -> some View {
        self.modifier(PopUpStyle(width: width, height: height))
    }
    
    public func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

