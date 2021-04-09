//
//  Application+Extensions.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 09.04.2021.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
