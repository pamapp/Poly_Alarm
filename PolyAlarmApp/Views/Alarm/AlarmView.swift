//
//  AlarmView.swift
//  alarm
//
//  Created by Alina Potapova on 11.02.2021.
//
//

import SwiftUI

struct AlarmView: View {

    @StateObject var delegate = Delegate()
    
    @EnvironmentObject var alarmData: AlarmData
    
    @State private var showingEditAlarmView = false
   
    @State var date = Date()
    
    var alarm: Alarm

    var alarmIndex: Int {
        alarmData.alarms.firstIndex(where: { $0.id == alarm.id})!
    }
    
    var body: some View {
        ZStack {
            let toggle = Binding<Bool> (
                get: { self.alarm.isEnabled },
                set: { newValue in
                    self.alarmData.alarms[alarmIndex].isEnabled = newValue
//                    if self.alarm.isEnabled {
                        createNotification(
                            alarm: alarm,
                            weekDays: alarm.repeatDay.repeatDaysIndexes
                        )
                        UNUserNotificationCenter.current().delegate = delegate
//                    }
                }
            )
            
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 300, height: 110, alignment: .center)
                .foregroundColor(alarm.isEnabled ? .lightGray : .darkGray)
                .overlay (
                    HStack(alignment: .center, spacing: 45) {
                        Text("\(self.alarm.timeFormat)")
                            .font(.resistMedium(25))
                            .foregroundColor(.darkBlue)
                
                        Toggle(isOn: toggle) {}
                            .toggleStyle(SwitchToggleStyle(tint: .darkBlue))
                            .labelsHidden()
                            .padding(.leading, -11)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(lineWidth: 1.5)
                                    .frame(width: 51, height: 31, alignment: .center)
                                    .foregroundColor(.darkBlue)
                                    .padding(.leading, -10)
                            )
                                                    
                        Button {
                            self.showingEditAlarmView.toggle()
                        } label: {
                            Image(systemName: "gear")
                                .font(.system(size: 40))
                                .foregroundColor(.darkBlue)
                                .overlay (
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.darkBlue, lineWidth: 2)
                                )
                        }.sheet(isPresented: self.$showingEditAlarmView, content: {
                            AlarmEditView(
                                alarm: alarm,
                                dateEdit: alarmData.alarms[alarmIndex].date,
                                labelEdit: alarmData.alarms[alarmIndex].label,
                                ringtoneEdit: alarmData.alarms[alarmIndex].ringtone,
                                repeatDayEdit: alarmData.alarms[alarmIndex].repeatDay,
                                isNotifyEdit: alarmData.alarms[alarmIndex].isNotify
                            )
                            .environmentObject(self.alarmData)
                            .preferredColorScheme(.dark)
                        })
                    }
                )
        }
    }
}
