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
            ZStack {
                Circle()
                    .fill(moodViewModel.currentMood.foregroundColor)
                    .frame(width: 200, height: 200)
                    .blur(radius: 300)
                MoodTrackerView(moodViewModel: moodViewModel)
            }
        case .book:
            VStack {
                Text("Logbook")
                    .font(.custom("Louize-MediumItalic", size: 45))
                    .fontWeight(.bold)
                    .padding(.top, 20)
                ZStack {
                    LogbookView(moodViewModel: moodViewModel)
                    Circle()
                        .fill(moodViewModel.currentMood.foregroundColor)
                        .frame(width: 200, height: 200)
                        .blur(radius: 300)
                }
                Spacer()
            }
        case .gearshape:
            VStack {
                Text("Settings")
                    .font(.custom("Louize-MediumItalic", size: 45))
                    .fontWeight(.bold)
                    .padding(.top, 20)
                ZStack {
                    SettingsView(moodViewModel: moodViewModel)
                    Circle()
                        .fill(moodViewModel.currentMood.foregroundColor)
                        .frame(width: 200, height: 200)
                        .blur(radius: 300)
                }
                Spacer()
            }
        }
    }
}
