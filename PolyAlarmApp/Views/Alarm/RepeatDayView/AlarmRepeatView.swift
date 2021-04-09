//
//  AlarmRepeatView.swift
//  alarm
//
//  Created by Alina Potapova on 20.03.2021.
//

import SwiftUI

struct AlarmRepeatView : View {
    @Binding var repeatDay: RepeatDay

    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                Text("REPEAT")
                    .simpleStyle()
                Spacer()
            }.padding(.leading, 30)
            
            VStack {
                HStack {
                    ForEach(0..<5) { index in
                        AlarmRepeatButtonView(
                            repeatDay: self.$repeatDay,
                            index: .constant(getIndex(index: index)),
                            isContained: self.isContained(getIndex(index: index))
                        )
                    }
                }
                HStack {
                    ForEach(5..<7) { index in
                        AlarmRepeatButtonView(
                            repeatDay: self.$repeatDay,
                            index: .constant(getIndex(index: index)),
                            isContained: self.isContained(getIndex(index: index))
                        )
                    }
                }
            }.padding(.top, -2)
            .padding(.bottom, 10)
        }
    }

    private func isContained(_ index: Int) -> Bool {
        let day = RepeatDay(rawValue: index)
        return self.repeatDay.contains(day)
    }
}
