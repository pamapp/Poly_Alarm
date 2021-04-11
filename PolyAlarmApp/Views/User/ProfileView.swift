//
//  ProfileView.swift
//  alarm
//
//  Created by Alina Potapova on 21.03.2021.
//

import SwiftUI

struct ProfileView: View {

    @State var moveMemoji: Bool
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.init(#colorLiteral(red: 0.02627239004, green: 0, blue: 0.1733231843, alpha: 1)), Color.init(#colorLiteral(red: 0.1083121225, green: 0.08548804373, blue: 0.3145544529, alpha: 1))]),
                startPoint: .top,
                endPoint: .bottom
            ).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("MY ACCOUNT")
                    .titleStyle()
                Spacer()
            }
            
            Image("memoji")
                .resizable()
                .frame(width: 284.0, height: 284.0)
                .padding(.top, 40)
                .offset(y: moveMemoji ? -142 : 0).animation(.easeInOut(duration: 1.0))
        }
    }
}

