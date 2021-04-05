//
//  AlarmView.swift
//  alarm
//
//  Created by Alina Potapova on 11.02.2021.
//
//

import SwiftUI

struct AlarmView: View {

    @StateObject var delegate = NotificationDelegate()
    
//    @State var notificationsOn = false
    
    @EnvironmentObject var alarmData: AlarmData
    
    @State private var showingEditView = false
   
    @State var date = Date()
    
    let alarm: Alarm
    
    let timeFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    
    var alarmIndex: Int {
        alarmData.alarms.firstIndex(where: { $0.id == alarm.id})!
    }
    
    
    var body: some View {
        ZStack {
            let toggle = Binding<Bool> (
                get: { self.alarmData.alarms[alarmIndex].isEnabled },
                set: { newValue in
                    self.alarmData.alarms[alarmIndex].isEnabled = newValue
                    createNotification(alarm: alarmData.alarms[alarmIndex])
                    UNUserNotificationCenter.current().delegate = delegate
                }
            )
            
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 300, height: 110, alignment: .center)
                .foregroundColor(Color.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).opacity(0.8))
                .overlay (
                    HStack(alignment: .center, spacing: 45) {
                        Text("\(self.alarm.date, formatter: self.timeFormat)")
                            .font(.resistMedium(25))
                            .foregroundColor(.darkBlue)
                            
                        Toggle(isOn: toggle) {}
                            .toggleStyle(SwitchToggleStyle(tint: .darkBlue))
                            .labelsHidden()
                            .padding(.leading, -10)
                            .alert(isPresented: $delegate.alert, content: {
                                Alert(title: Text("Message"), message: Text("Reply Button is pressed"), dismissButton: .destructive(Text("OK")))
                            })
                            
                        
                        Button {
                            self.showingEditView.toggle()

                        } label: {
                            Image(systemName: "gear")
                                .font(.system(size: 40))
                                .foregroundColor(.darkBlue)
                                .overlay (
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.darkBlue, lineWidth: 2)
                                )
                        }.sheet(isPresented: self.$showingEditView, content: {
                            AlarmEditView(
                                alarm: alarm,
                                date: alarmData.alarms[alarmIndex].date,
                                label: alarmData.alarms[alarmIndex].label,
                                ringtone: alarmData.alarms[alarmIndex].ringtone,
                                repeatDay: alarmData.alarms[alarmIndex].repeatDay,
                                isNotify: alarmData.alarms[alarmIndex].isNotify
                            )
                                .environmentObject(self.alarmData)
                                .preferredColorScheme(.dark)
                        })
                    }
                )
        }
    }
}
