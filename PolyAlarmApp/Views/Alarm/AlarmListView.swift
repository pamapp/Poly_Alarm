//
//  AlarmListView.swift
//  alarm
//
//  Created by Alina Potapova on 19.03.2021.
//

import SwiftUI

struct AlarmListView : View {
    
    @EnvironmentObject var alarmData: AlarmData
    
    @State private var showingAddAlarmView = false
    
    @State var date = Date()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.gradientTop, .gradientBottom]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 50) {
                Text("ALARMS")
                    .titleStyle()

                VStack {
                    Text("\(timeString(date: date))")
                        .onAppear(perform: { let _ = self.updateTimer })
                        .foregroundColor(.white)
                        .font(.resistMedium(60))
                    Text("\(dayString(date: date))")
                        .onAppear(perform: { let _ = self.updateTimer })
                        .foregroundColor(.darkGray)
                        .font(.resistMedium())
                        .textCase(.uppercase)
                        .padding(.top, -35)
                }.padding(.top, -35)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .center, spacing: 50) {
                        ForEach(self.alarmData.alarms.indexed(), id: \.1.id) { index, _ in
                            AlarmView(alarm: self.alarmData.alarms[index])
                        }
                    }
                }
                
                Button (action: {
                    self.showingAddAlarmView.toggle()
                }, label: {
                    RoundedRectangle(cornerRadius: 15.0)
                        .stroke(Color.white, lineWidth: 1)
                        .frame(width: 300, height: 110, alignment: .center)
                        .overlay(
                            VStack {
                                Image(systemName: "alarm")
                                    .foregroundColor(.white)
                                    .font(.system(size: 25))
                                Text("ADD ALARM")
                                    .simpleStyle()
                            }
                    )
                }).padding(.bottom, 35)
                    .sheet(isPresented: self.$showingAddAlarmView, content: {
                        AlarmAddView()
                            .environmentObject(self.alarmData)
                            .preferredColorScheme(.dark)
                    })

                Spacer()
            }
        }
    }
    
    var timeFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    var dayFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM"
        return formatter
    }
    
    func timeString(date: Date) -> String {
         let time = timeFormat.string(from: date)
         return time
    }
    
    func dayString(date: Date) -> String {
         let time = dayFormat.string(from: date)
         return time
    }
    
    var updateTimer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in  self.date = Date() })
    }
}

