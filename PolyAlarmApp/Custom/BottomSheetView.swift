//
//  BottomSheetView.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 08.04.2021.
//

import SwiftUI

fileprivate enum Constants {
    static let radius: CGFloat = 16
    static let indicatorSize: CGFloat = 20
    static let snapRatio: CGFloat = 0.25
    static let minHeightRatio: CGFloat = 0.075
}

struct BottomSheetView: View {
    @Binding var isOpen: Bool
    @State var dateWeek = Date()
    
    let maxHeight: CGFloat
    let minHeight: CGFloat

    @GestureState private var translation: CGFloat = 0

    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }

    private var indicator: some View {
        Image(systemName: isOpen ? "chevron.down" : "chevron.up")
            .foregroundColor(.darkBlue)
            .font(Font.system(size: Constants.indicatorSize, weight: .bold))
            .onTapGesture {
                self.isOpen.toggle()
            }
    }
    
    var weekDayFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
    
    func weekDayString(date: Date) -> String {
        let time = weekDayFormat.string(from: date)
        return time
    }
    
    var updateWeekDay: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in  self.dateWeek = Date() })
    }
        
    init(isOpen: Binding<Bool>, maxHeight: CGFloat) {
        self.minHeight = maxHeight * Constants.minHeightRatio
        self.maxHeight = maxHeight
        self._isOpen = isOpen
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                self.indicator
                    .padding(.top, 15)
                    .padding(.bottom, 5)
                Rectangle()
                    .fill(Color.white)
                    .overlay(
                        VStack(alignment: .center, spacing: 16) {
                            Text("HELLO!")
                                .font(.resistMedium())
                                .foregroundColor(.darkBlue)
                            
                            Text(
                                """
                                TODAY IS: \(weekDayString(date: dateWeek).uppercased())
                                YOU HAVE NUMBER OF LESSONS
                                FIRST ONE AT CLOCK
                                """
                            )
                                .onAppear(perform: { let _ = self.updateWeekDay })
                                .font(.resistMedium())
                                .foregroundColor(.darkBlue)
                                .multilineTextAlignment(.center)
                                .padding(.top, 5)
                            
                            Text("WISH YOU A GOOD DAY!")
                                .font(.resistMedium())
                                .foregroundColor(.darkBlue)
                            
                            Divider()
                                .background(Color.darkBlue)
                                .padding(.leading, 30)
                                .padding(.trailing, 30)
                        }
                    )
            }
//            .edgesIgnoringSafeArea(.all)
            .frame(width: geometry.size.width, height: self.maxHeight)
            .background(Color.white)
            .cornerRadius(15, corners: [.topLeft, .topRight])
            .frame(height: geometry.size.height - 75, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(.interactiveSpring(), value: isOpen)
            .animation(.interactiveSpring(), value: translation)
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                }
                .onEnded { value in
                    let snapDistance = self.maxHeight * Constants.snapRatio
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    self.isOpen = value.translation.height < 0
                }
            )
            .onTapGesture {
                self.isOpen.toggle()
            }
        }
    }
}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
