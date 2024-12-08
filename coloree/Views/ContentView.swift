//
//  ContentView.swift
//  coloree
//
//  Created by Victor Esther Qiu on 07/12/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @ObservedObject var moodViewModel: MoodViewModel
    @State private var selectedTab: Tab = .circle
    
    var body: some View {
        ZStack {
            moodViewModel.currentMood.backgroundColor
                .ignoresSafeArea()
            
            Circle()
                .fill(moodViewModel.currentMood.foregroundColor)
                .frame(width: 200, height: 200)
                .blur(radius: 300)
            
            VStack(spacing: 0) {
                content(for: selectedTab, moodViewModel: moodViewModel)
                CustomTabBar(selectedTab: $selectedTab, moodViewModel: moodViewModel)
            }
        }

        .foregroundColor(moodViewModel.currentMood.foregroundColor)
    }
    
    @ViewBuilder
        private func content(for tab: Tab, moodViewModel: MoodViewModel) -> some View {
            switch tab {
            case .circle:
                // The MoodTrackerView itself will have no circle;
                // it’s already in the background now.
                MoodTrackerView(moodViewModel: moodViewModel)
                
            case .book:
                VStack(alignment: .leading) {
                    Text("Logbook")
                        .font(.largeTitle.weight(.bold))
                        .padding(.top, 35)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.bottom, 20)
                    
                    LogbookView(moodViewModel: moodViewModel)
                    Spacer()
                }
                
            case .gearshape:
                VStack(alignment: .leading) {
                    Text("Settings")
                        .font(.largeTitle.weight(.bold))
                        .padding(.top, 35)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.bottom, 30)
                    
                    SettingsView(moodViewModel: moodViewModel)
                    Spacer()
                }
            }
        }
}
