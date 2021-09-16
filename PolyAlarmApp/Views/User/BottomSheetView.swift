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
    @EnvironmentObject var alarmData: AlarmData
    
    @EnvironmentObject var userData: UserData
    
    @Binding var isOpen: Bool
    
    @State var dateWeek = Date()
    
    @State var changeMale: Bool = false
    
    let maxHeight: CGFloat
    let minHeight: CGFloat

    let male: String = "male"
    let female: String = "female"
    
    @GestureState private var translation: CGFloat = 0

    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }
    
    private var offsetMemoji: CGFloat {
        isOpen ? 85 : maxHeight - minHeight
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
    
    var firstTimeFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    func firstTimeString(date: Date) -> String {
         let time = firstTimeFormat.string(from: date)
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
        VStack(alignment: .center) {
            Image(changeMale ? male : female)
                .resizable()
                .frame(width: 284.0, height: 284.0, alignment: .center)
                .offset(y: max(self.offsetMemoji + self.translation, 85))
                .onTapGesture {
                    self.changeMale.toggle()
                }
        }.padding(.bottom, UIScreen.main.bounds.height / 1.85)
        
        GeometryReader { geometry in
            VStack(spacing: 0) {
                self.indicator
                    .padding(.top, 15)
                    .padding(.bottom, 5)
                Rectangle()
                    .fill(Color.white)
                    .overlay(
                        VStack(alignment: .center, spacing: 16) {
                            Text("HELLO, \(userData.data.nickname)!")
                                .font(.resistMedium())
                                .foregroundColor(.darkBlue)
                            
                            Text(
                                """
                                TODAY IS: \(weekDayString(date: dateWeek).uppercased())
                                YOU HAVE \(alarmData.numOfAlarms())
                                \(alarmData.firstAlarmTime())
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
