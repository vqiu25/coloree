//
//  MoodTrackerView.swift
//  coloree
//
//  Created by Victor Esther Qiu on 07/12/2024.
//

import SwiftUI

struct MoodTrackerView: View {
    @ObservedObject var moodViewModel: MoodViewModel
    @State private var offset = CGSize.zero // Track the circle's offset
    @State private var showMoodBar = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                ZStack {
                    // Main circle
                    Circle()
                        .fill(moodViewModel.currentMood.foregroundColor)
                        .frame(width: 200, height: 200)
                    // Glow circle
                    Circle()
                        .fill(moodViewModel.currentMood.foregroundColor)
                        .frame(width: 210, height: 210)
                        .glow()
                }
                .offset(offset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            // Apply resistance to the vertical drag
                            offset = CGSize(width: value.translation.width / 2,
                                            height: value.translation.height / 2)
                        }
                        .onEnded { value in
                            let verticalDrag = value.translation.height
                            if verticalDrag > 80 {
                                // If user dragged down past threshold, show mood bar
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                    offset = .zero
                                    showMoodBar = true
                                }
                            } else {
                                // Otherwise return to center
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                    offset = .zero
                                }
                            }
                        }
                )
                
                Spacer()
            }
            
            // When the mood bar is shown, add a full-screen tap area behind it.
            if showMoodBar {
                // Full-screen background for tapping outside to dismiss
                Color.clear
                    .ignoresSafeArea()
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                            showMoodBar = false
                        }
                    }
                
                // Mood bar, positioned above the circle
                MoodBarView(moodViewModel: moodViewModel, onDismiss: {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                        showMoodBar = false
                    }
                })
                // Positioning:
                // The circle is roughly in the center. We'll place the bar a bit above it.
                // Adjust as needed for your layout.
                .offset(y: 180)
                .transition(.fromCircle)
            }
        }
    }
}

struct Glow: ViewModifier {
    @State private var throb = false

    func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: throb ? 50 : 40)
                .onAppear {
                    // Start the animation after the view has fully appeared
                    withAnimation(Animation.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
                        throb = true
                    }
                }
        }
    }
}

extension View {
    func glow() -> some View {
        modifier(Glow())
    }
}

extension AnyTransition {
    static var fromCircle: AnyTransition {
        let insertion = AnyTransition.scale(scale: 0.0, anchor: .bottom)
        let removal = AnyTransition.scale(scale: 0.0, anchor: .bottom)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

// A separate view for the mood bar
struct MoodBarView: View {
    @ObservedObject var moodViewModel: MoodViewModel
    var onDismiss: () -> Void

    var body: some View {
        RoundedRectangle(cornerRadius: 100)
            .fill(Color(moodViewModel.currentMood.backgroundColor == Color("Wisteria")
                        ? moodViewModel.currentMood.backgroundColor
                        : moodViewModel.currentMood.foregroundColor))
            .frame(height: 80)
            .overlay(
                HStack(spacing: 20) {
                    ForEach(MoodType.allCases, id: \.self) { mood in
                        Button(action: {
                            moodViewModel.addEntry(mood: mood)
                            onDismiss()
                        }) {
                            VStack {
                                Image(systemName: iconName(for: mood))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 24)
                                    .foregroundColor(moodViewModel.currentMood.foregroundColor == Color("Lavendar")
                                        ? moodViewModel.currentMood.foregroundColor
                                        : moodViewModel.currentMood.backgroundColor)
                                Text(mood.rawValue.capitalized)
                                    .font(.caption2)
                                    .foregroundColor(moodViewModel.currentMood.foregroundColor == Color("Lavendar")
                                        ? moodViewModel.currentMood.foregroundColor
                                        : moodViewModel.currentMood.backgroundColor)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
            )
            .padding(.horizontal, 30)
    }
    
    // A placeholder function to return an icon name based on mood
    func iconName(for mood: MoodType) -> String {
        switch mood {
        case .frustrated: return "exclamationmark.triangle.fill"
        case .broken: return "heart.slash.fill"
        case .ok: return "hand.thumbsup.fill"
        case .hopeful: return "sparkles"
        case .joyful: return "face.smiling.fill"
        }
    }
}
