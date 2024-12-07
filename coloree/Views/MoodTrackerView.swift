//
//  MoodTrackerView.swift
//  coloree
//
//  Created by Victor Esther Qiu on 07/12/2024.
//

import SwiftUI

struct MoodTrackerView: View {
    @ObservedObject var moodViewModel: MoodViewModel
    @State private var showMoodSelection = false
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Circle()
                    .fill(moodViewModel.currentMood.foregroundColor)
                    .frame(width: 200, height: 200)
                    .glow()
                }
                .onLongPressGesture(minimumDuration: 0.5) {
                    showMoodSelection = true
                }
            Spacer()
        }
        .confirmationDialog("Select Mood", isPresented: $showMoodSelection) {
            ForEach(MoodType.allCases, id: \.self) { mood in
                Button(mood.rawValue.capitalized) {
                    moodViewModel.addEntry(mood: mood)
                }
            }
        }
    }
}

struct Glow: ViewModifier {
    @State private var throb = false

    func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: throb ? 20 : 15) // Animate between two blur values
                .animation(
                    Animation.easeInOut(duration: 5.0).repeatForever(autoreverses: true),
                    value: throb
                )
                .onAppear {
                    throb = true
                }
        }
    }
}

extension View {
    func glow() -> some View {
        modifier(Glow())
    }
}

