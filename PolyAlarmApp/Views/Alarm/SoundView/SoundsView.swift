//
//  SoundsView.swift
//  alarm
//
//  Created by Alina Potapova on 30.03.2021.
//

import SwiftUI
import AVFoundation

struct SoundsLabelView: View {
    @Binding var ringtone: Ringtone
    @Binding var showingEditSoundView: Bool
    var body: some View {
        ZStack(alignment: .center) {
            HStack {
                Text("SOUND")
                    .simpleStyle()
                Spacer()
                
                Button (action: {
                    withAnimation {
                        self.showingEditSoundView.toggle()
                    }
                }, label: {
                    Text(ringtone.fullName.uppercased())
                        .underline()
                        .simpleStyle()
                })
            }
            .padding(.all, 5)
            .padding(.leading, 30)
            .padding(.trailing, 20)
        }
    }
}

struct SoundsView: View {
    @Binding var ringtone: Ringtone
    @Binding var showingEditSoundView: Bool
    
    @State var edittingRingtone: Ringtone
    @State var audioPlayer: AVAudioPlayer!
    @State var isContained: Bool = true
    
    var body: some View {
            VStack(alignment: .center, spacing: 30) {
                Text("SOUND SETTINGS")
                    .titleStyle()
                    .padding(.bottom)
                
                VStack(alignment: .center) {
                    HStack {
                        Text("RINGTONES")
                            .foregroundColor(.darkGray)
                            .font(.resistMedium())
                        Spacer()
                    }.padding(.leading).padding(.top)
                    
                    ForEach(0..<6) { index in
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 280, height: 40, alignment: .center)
                            .foregroundColor(self.edittingRingtone.contains(Ringtone(rawValue: getIndex(index: index))) ? .lightGray : .darkGray)
                            .overlay(
                                Text("\(Ringtone(rawValue: getIndex(index: index)).fullName)".uppercased())
                                    .font(.resistMedium(14))
                                    .foregroundColor(.darkBlue)
                            )
                            .onTapGesture(count: 1) {
                                self.toggle(getIndex(index: index))
                            }
                    }
                }
                
                HStack(alignment: .center, spacing: UIScreen.main.bounds.width / 10) {
                    
                    Button (action: {
                        self.cancel()
                    }, label: {
                        DefaultButtonStyle(buttonTitle: "CANCEL", buttonWidth: UIScreen.main.bounds.width / 3)
                    })
                    
                    Button (action: {
                        self.done()
                    }, label: {
                        DefaultButtonStyle(buttonTitle: "DONE", buttonWidth: UIScreen.main.bounds.width / 3)
                    })
                    
                }

            }.popUpStyle(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 1.5)
    }
    
    private func done() {
        ringtone = edittingRingtone
        self.showingEditSoundView.toggle()
    }
    
    private func cancel() {
        self.showingEditSoundView.toggle()
    }
    
    private func toggle(_ index: Int) {
        let song = Ringtone(rawValue: index)
        
        self.isContained = self.edittingRingtone.contains(song)
        self.isContained.toggle()
        
        if let path = Bundle.main.path(forResource: Ringtone(rawValue: index).fullName, ofType: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                if !isContained {
                    audioPlayer!.stop()
                } else {
                    audioPlayer!.play()
                }
            } catch {
                print("ERROR")
            }
        }
        
        if self.edittingRingtone.contains(song) {
            self.edittingRingtone.remove(song)
            if self.edittingRingtone.isEmpty {
                self.edittingRingtone.insert(.radar)
            }
        } else {
            self.edittingRingtone.remove(.all)
            self.edittingRingtone.insert(song)
        }
    }
}
