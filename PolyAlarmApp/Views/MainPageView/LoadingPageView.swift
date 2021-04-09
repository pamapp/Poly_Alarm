//
//  LoadingPageView.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 07.04.2021.
//

import SwiftUI

struct LoadingPageView: View {
    @State var loading: Bool = false
    var body: some View {
        ZStack {
            CustomBackgroundView()

            VStack {
                Blinking(isAnimating: $loading, count: 8, size: 15)

                Button(action: {
                    self.loading.toggle()
                }, label: {
                    Text("Toggle")
                        .foregroundColor(.lightGray)
                        .font(.resistMedium())
                })
                    
            }.frame(width: 120, height: 120, alignment: .center)
            
        }
    }
}

struct Blinking: View {
    @Binding var isAnimating: Bool
    let count: UInt
    let size: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<Int(count)) { index in
                item(forIndex: index, in: geometry.size)
                    .frame(width: geometry.size.width, height: geometry.size.height)

            }
        }
        .aspectRatio(contentMode: .fit)
    }

    private func item(forIndex index: Int, in geometrySize: CGSize) -> some View {
        let angle = 2 * CGFloat.pi / CGFloat(count) * CGFloat(index)
        let x = (geometrySize.width/2 - size/2) * cos(angle)
        let y = (geometrySize.height/2 - size/2) * sin(angle)
        return Circle()
            .frame(width: size, height: size)
            .foregroundColor(.lightGray)
            .scaleEffect(isAnimating ? 0.5 : 1)
            .opacity(isAnimating ? 0.25 : 1)
            .animation(
                Animation
                    .default
                    .repeatCount(isAnimating ? .max : 1, autoreverses: true)
                    .delay(Double(index) / Double(count) / 2)
            )
            .offset(x: x, y: y)
    }
}

struct LoadingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingPageView()
    }
}
