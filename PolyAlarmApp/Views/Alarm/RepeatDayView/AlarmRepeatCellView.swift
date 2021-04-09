//
//  AlarmRepeatButtonView.swift
//  alarm
//
//  Created by Alina Potapova on 20.03.2021.
//

import SwiftUI

struct AlarmRepeatButtonView : View {
    @Binding var repeatDay: RepeatDay
    @Binding var index: Int
    @State var isContained: Bool

    var body: some View {
        Button(action: {
            self.toggle(self.index)
        }, label: {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 60, height: 30, alignment: .center)
                .foregroundColor(isContained ? .lightGray : .darkGray)
                .overlay(
                    Text("\(RepeatDay(rawValue: index).fullName)")
                        .font(.resistMedium(14))
                        .foregroundColor(.darkBlue)
                )
        })
    }

    private func toggle(_ index: Int) {
        let day = RepeatDay(rawValue: index)
        
        self.isContained.toggle()
        
        if self.repeatDay.contains(day) {
            self.repeatDay.remove(day)
        } else {
            self.repeatDay.insert(day)
        }
    }
}
