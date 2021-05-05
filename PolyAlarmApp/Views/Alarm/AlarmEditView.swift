//
//  AlarmEditView.swift
//  alarm
//
//  Created by Alina Potapova on 25.03.2021.
//

import SwiftUI

struct AlarmEditView: View {

    @Environment(\.presentationMode) var isPresented
    @EnvironmentObject var alarmData: AlarmData
    
    let alarm: Alarm
    
    @State private var showingEditLabelView: Bool = false
    @State private var showingMakeSureLabelView: Bool = false
    @State private var showingEditSoundView: Bool = false
    @State private var saveChanges: Bool = false
    
    @State var dateEdit: Date
    @State var labelEdit: String
    @State var ringtoneEdit: Ringtone
    @State var repeatDayEdit: RepeatDay
    @State var isEnabledEdit: Bool
    @State var isNotifyEdit: Bool
    
    var deleteAction: (Alarm) -> Void
    
    @State private var sureText: String =
        """
        ARE YOU SURE THAT
        YOU WANT
        TO SAVE CHANGES?
        """

    var alarmIndex: Int {
        alarmData.alarms.firstIndex(where: { $0.id == alarm.id})!
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.gradientTop, .gradientBottom]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Text("ALARM SETTINGS")
                            .simpleStyle()
                            .padding()
                        
                        DatePicker("", selection: $dateEdit, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .datePickerStyle(WheelDatePickerStyle())
                            .scaleEffect(x: 1.3, y: 1.3)
                            .padding()
                            .padding(.bottom, 5)
                        
                        Divider()
                        
                        VStack {
                            AlarmRepeatView(repeatDay: $repeatDayEdit)
                    
                            Divider()
                            
                            SoundLabelView(ringtone: $ringtoneEdit, showingEditSoundView: $showingEditSoundView)
                            
                            Divider()
                    
                            TitleLabelView(label: $labelEdit, showingEditLabelView: $showingEditLabelView)
                
                            Divider()
                            
                            NotifyLabelView(isNotify: $isNotifyEdit)
                            
                            Divider()
                            
                            HStack(alignment: .center, spacing: UIScreen.main.bounds.width / 5) {
                                Button (action: {
                                    self.delete()
                                }, label: {
                                    DefaultButtonStyle(buttonTitle: "DELETE", buttonWidth: UIScreen.main.bounds.width / 3)
                                })

                                Button (action: {
                                    self.showingMakeSureLabelView.toggle()
                                }, label: {
                                    DefaultButtonStyle(buttonTitle: "DONE", buttonWidth: UIScreen.main.bounds.width / 3)
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
                        data: $labelEdit,
                        showingPopUpEditView: $showingEditLabelView,
                        edittingData: labelEdit,
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
                    ringtone: $ringtoneEdit,
                    showingEditSoundView: $showingEditSoundView,
                    edittingRingtone: ringtoneEdit
                )
            }
            
            if self.showingMakeSureLabelView {
                ZStack {
                    CustomBackgroundBlur(effect: UIBlurEffect(style: .regular))
                        .opacity(0.9)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation{
                                self.showingMakeSureLabelView.toggle()
                            }
                        }
                    
                    VStack(spacing: 30) {
                        Text(sureText)
                            .simpleStyle()
                            .multilineTextAlignment(.center)
                        
                        HStack(alignment: .center, spacing: UIScreen.main.bounds.width / 10) {
                            Button (action: {
                                self.isPresented.wrappedValue.dismiss()
                            }, label: {
                                DefaultButtonStyle(buttonTitle: "CANCEL", buttonWidth: UIScreen.main.bounds.width / 3)
                            })
                            
                            Button (action: {
                                save()
                            }, label: {
                                DefaultButtonStyle(buttonTitle: "SAVE", buttonWidth: UIScreen.main.bounds.width / 3)
                            })
                        }
                    }.popUpStyle(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 3.4)
                }
            }
            
        }
    }
    
    private func save() {
        alarmData.alarms[alarmIndex].date = dateEdit
        alarmData.alarms[alarmIndex].ringtone = ringtoneEdit
        alarmData.alarms[alarmIndex].repeatDay = repeatDayEdit
        alarmData.alarms[alarmIndex].label = labelEdit
        alarmData.alarms[alarmIndex].isEnabled = isEnabledEdit
        alarmData.alarms[alarmIndex].isNotify = isNotifyEdit
        
        self.isPresented.wrappedValue.dismiss()
    }

    
    private func delete() {
        deleteAction(alarm)
        self.isPresented.wrappedValue.dismiss()
    }
}
