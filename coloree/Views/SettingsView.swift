//
//  SettingsView.swift
//  coloree
//
//  Created by Victor Esther Qiu on 07/12/2024.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var moodViewModel: MoodViewModel
    
    // Example state for notifications slider
    @State private var notificationLevel: Double = 0.5
    
    var body: some View {
        VStack {
            
        }
        .padding()
        .foregroundColor(moodViewModel.currentMood.foregroundColor)
        .background(moodViewModel.currentMood.backgroundColor.ignoresSafeArea())
    }
}
