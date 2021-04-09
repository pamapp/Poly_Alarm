//
//  Color+Extensions.swift
//  alarm
//
//  Created by Alina Potapova on 23.03.2021.
//
import SwiftUI

extension Color {
    public static var gradientTop: Color {
        return Color.init(#colorLiteral(red: 0.02627239004, green: 0, blue: 0.1733231843, alpha: 1))
    }
    
    public static var gradientBottom: Color {
        return Color.init(#colorLiteral(red: 0.1083121225, green: 0.08548804373, blue: 0.3145544529, alpha: 1))
    }
    
    public static var darkBlue: Color {
        return Color.init(#colorLiteral(red: 0.04634921253, green: 0.01949072443, blue: 0.2136611044, alpha: 1))
    }
    
    public static var lightBlue: Color {
        return Color.init(#colorLiteral(red: 0.1083121225, green: 0.08548804373, blue: 0.3145544529, alpha: 1))
    }
    
    public static var lightGray: Color {
        return Color.white.opacity(0.8)
    }
    
    public static var darkGray: Color {
        return Color.init(#colorLiteral(red: 0.424826026, green: 0.4187176526, blue: 0.4623801708, alpha: 1))
    }
}

