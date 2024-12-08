//
//  SettingsView.swift
//  coloree
//
//  Created by Victor Esther Qiu on 07/12/2024.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var moodViewModel: MoodViewModel
    @State private var notificationsEnabled: Bool = false
    
    var body: some View {
        List {
            Section {
                // Notification toggle
                Toggle(isOn: $notificationsEnabled) {
                    Label("Notifications", systemImage: "bell.fill")
                }
                .tint(
                    moodViewModel.currentMood.backgroundColor == Color("Wisteria")
                    ? moodViewModel.currentMood.foregroundColor
                    : moodViewModel.currentMood.backgroundColor
                )
                
                // Tip action
                Button {
                // Implement tip action
                } label: {
                    Label("Tip", systemImage: "gift.fill")
                }
                
                // Review on App Store
                Button {
                // Implement app store review action
                } label: {
                    Label("Review", systemImage: "star.fill")
                }
            }
            .foregroundColor(
                moodViewModel.currentMood.foregroundColor == Color("Lavendar")
                ? moodViewModel.currentMood.foregroundColor
                : moodViewModel.currentMood.backgroundColor
            )
            .listRowBackground(moodViewModel.currentMood.backgroundColor == Color("Wisteria")
                               ? moodViewModel.currentMood.backgroundColor
                               : moodViewModel.currentMood.foregroundColor)
        }
        .listStyle(.insetGrouped)
        .scrollDisabled(true)
        .scrollContentBackground(.hidden)
        .padding(.top, -50)
        
    }
}
