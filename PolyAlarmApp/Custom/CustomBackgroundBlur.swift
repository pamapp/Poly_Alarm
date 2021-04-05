//
//  CustomBackgroundBlur.swift
//  alarm
//
//  Created by Alina Potapova on 29.03.2021.
//

import SwiftUI

struct CustomBackgroundBlur: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
