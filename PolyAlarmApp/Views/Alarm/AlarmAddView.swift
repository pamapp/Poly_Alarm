//
//  AlarmAddView.swift
//  alarm
//
//  Created by Alina Potapova on 18.03.2021.
//

import SwiftUI

struct AlarmAddView: View {
    @Environment(\.presentationMode) var isPresented
    @EnvironmentObject var alarmData: AlarmData
    
    @State private var showingEditLabelView = false
    @State private var showingEditSoundView: Bool = false
    
    @State var date: Date = Date()
    @State var label: String = "ALARM"
    @State var ringtone: Ringtone = [.radar]
    @State var repeatDay: RepeatDay = []
    @State var isEnabled: Bool = false
    @State var isNotify: Bool = true
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.gradientTop, .gradientBottom]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                    VStack {
                        Text("ADD ALARM")
                            .simpleStyle()
                            .padding()
                        Spacer()
                        
                        DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .datePickerStyle(WheelDatePickerStyle())
                            .scaleEffect(x: 1.3, y: 1.3)
                            .padding()
                            .padding(.bottom, 5)
                        
                        Divider()
                        
                        VStack {
                            AlarmRepeatView(repeatDay: $repeatDay)
                    
                            Divider()
                            
                            SoundLabelView(ringtone: $ringtone, showingEditSoundView: $showingEditSoundView)
                            
                            Divider()
                            
                            TitleLabelView(label: $label, showingEditLabelView: $showingEditLabelView)
                            
                            Divider()
                            
                            NotifyLabelView(isNotify: $isNotify)
                            
                            Divider()
                            
                            HStack(alignment: .center, spacing: UIScreen.main.bounds.width / 5) {
                                
                                Button (action: {
                                    self.cancel()
                                }, label: {
                                    DefaultButtonStyle(buttonTitle: "CANCEL", buttonWidth: UIScreen.main.bounds.width / 3)
                                })
                                
                                Button (action: {
                                    self.createAlarm()
                                }, label: {
                                    DefaultButtonStyle(buttonTitle: "SAVE", buttonWidth: UIScreen.main.bounds.width / 3)
                                })
                            }.padding(.top)
                        }
                        
                        Spacer()
                    }
                }
                .navigationBarHidden(true)
            }
                
            if self.showingEditLabelView {
                ZStack {
                    CustomBackgroundBlur(effect: UIBlurEffect(style: .regular))
                        .opacity(0.9)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation{
                                self.showingEditLabelView.toggle()
                            }
                        }
                    AlarmPopUpTextEditView(
                        data: $label,
                        showingEditLabelView: $showingEditLabelView,
                        edittingData: label,
                        settingsTitle: "LABEL SETTINGS",
                        textFieldTitle: "LABEL",
                        moreThanOneLine: false
                    )
                }
            }
            
            if self.showingEditSoundView {
                CustomBackgroundBlur(effect: UIBlurEffect(style: .regular))
                    .opacity(0.9)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation{
                            self.showingEditSoundView.toggle()
                        }
                    }
                SoundsView(
                    ringtone: $ringtone,
                    showingEditSoundView: $showingEditSoundView,
                    edittingRingtone: ringtone
                )
            }
            
        }
    }
    
    private func cancel() {
        self.isPresented.wrappedValue.dismiss()
    }
    
    private func createAlarm() {
        let newAlarm = Alarm (
            id: UUID(),
            date: date,
            label: label,
            ringtone: ringtone,
            repeatDay: repeatDay,
            isEnabled: false,
            isNotify: true
        )

        self.alarmData.alarms.append(newAlarm)
        self.isPresented.wrappedValue.dismiss()
    }
    
}

struct AlarmAddView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmAddView()
            .preferredColorScheme(.dark)
    }
}

