//
//  TabViewCustom.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 09.04.2021.
//
import SwiftUI

struct TabBarView: View {
    @Binding var pages: [TabBarPage]
    @Binding var showingBottomSheet: Bool
    @State var selectedTab = ""
    
    init(pages: Binding<[TabBarPage]>, showingBottomSheet: Binding<Bool>) {
        UITabBar.appearance().isHidden = true
        self._pages = pages
        self._showingBottomSheet = showingBottomSheet
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                ForEach(pages) { item in
                    AnyView(_fromValue: item.page)
                        .tabItem{
                            EmptyView()
                        }.tag(item.tag)
                }
            }
            
            HStack {
                ForEach(pages) { item in
                    Button(action: {
                        self.selectedTab = item.tag
                        
                        if item.tag == "Profile" {
                            self.showingBottomSheet = true
                        } else {
                            self.showingBottomSheet = false
                        }
                    }) {
                        VStack {
                            Image(systemName: item.icon)
                                .foregroundColor(self.selectedTab == item.tag ? .darkBlue : .gray)
                                .font(Font.system(size: 28))
                                
                        }.padding(10)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, 5)
            .padding(.bottom, 20)
            .background(Color.white)
            .cornerRadius(showingBottomSheet ? 5: 15)
        }.edgesIgnoringSafeArea(.all)
    }
}

struct TabBarPage: Identifiable {
    var id = UUID()
    var page: Any
    var icon: String
    var tag: String
}
