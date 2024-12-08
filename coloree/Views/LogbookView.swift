//
//  LogbookView.swift
//  coloree
//
//  Created by Victor Esther Qiu on 07/12/2024.
//

import SwiftUI

struct LogbookView: View {
    @ObservedObject var moodViewModel: MoodViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            // Squares layout: 2-2-1
            VStack(spacing: 20) {
                // Row 1
                if moodViewModel.moodCounts.count >= 2 {
                    HStack(spacing: 20) {
                        MoodSquare(
                            mood: moodViewModel.moodCounts[0].mood,
                            count: moodViewModel.moodCounts[0].count,
                            currentMood: moodViewModel.currentMood
                        )
                        MoodSquare(
                            mood: moodViewModel.moodCounts[1].mood,
                            count: moodViewModel.moodCounts[1].count,
                            currentMood: moodViewModel.currentMood
                        )
                    }
                }
                
                // Row 2
                if moodViewModel.moodCounts.count >= 4 {
                    HStack(spacing: 20) {
                        MoodSquare(
                            mood: moodViewModel.moodCounts[2].mood,
                            count: moodViewModel.moodCounts[2].count,
                            currentMood: moodViewModel.currentMood
                        )
                        MoodSquare(
                            mood: moodViewModel.moodCounts[3].mood,
                            count: moodViewModel.moodCounts[3].count,
                            currentMood: moodViewModel.currentMood
                        )
                    }
                }
                
                // Row 3 (single mood)
                if moodViewModel.moodCounts.count >= 5 {
                    HStack {
                        MoodSquare(
                            mood: moodViewModel.moodCounts[4].mood,
                            count: moodViewModel.moodCounts[4].count,
                            currentMood: moodViewModel.currentMood
                        )
                    }
                }
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal)
        .padding(.top, 20)
    }
    
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "heart.fill")
                    .font(.headline)
                    .foregroundColor(
                        moodViewModel.currentMood.foregroundColor == Color("Lavendar")
                        ? moodViewModel.currentMood.foregroundColor
                        : moodViewModel.currentMood.backgroundColor
                    )
                
                Text("\(moodViewModel.totalCount) entries")
                    .font(.headline)
                    .foregroundColor(
                        moodViewModel.currentMood.foregroundColor == Color("Lavendar")
                        ? moodViewModel.currentMood.foregroundColor
                        : moodViewModel.currentMood.backgroundColor
                    )
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        moodViewModel.currentMood.backgroundColor == Color("Wisteria")
                        ? moodViewModel.currentMood.backgroundColor
                        : moodViewModel.currentMood.foregroundColor
                    )
            )
            .padding(.horizontal)
        }
    }
}

struct MoodSquare: View {
    let mood: MoodType
    let count: Int
    let currentMood: MoodType
    
    @State private var flipped = false
    
    var body: some View {
        let flipAngle = flipped ? 180.0 : 0.0
        
        // Determine colors based on currently selected mood
        let isLavender = (currentMood.foregroundColor == Color("Lavendar"))
        
        // Front and back colors
        // If lavender, front = foregroundColor, icon = backgroundColor
        // else, front = backgroundColor, icon = foregroundColor
        let frontFill = isLavender ? currentMood.backgroundColor : currentMood.foregroundColor
        let frontIcon = isLavender ? currentMood.foregroundColor : currentMood.backgroundColor
        
        let backFill = isLavender ? currentMood.backgroundColor : currentMood.foregroundColor
        let backText = isLavender ? currentMood.foregroundColor : currentMood.backgroundColor
        
        ZStack {
            // Front
            RoundedRectangle(cornerRadius: 20)
                .fill(frontFill)
                .overlay(
                    Image(systemName: mood.iconName)
                        .foregroundColor(frontIcon)
                        .font(.largeTitle)
                )
                .opacity(flipped ? 0 : 1)
                .rotation3DEffect(
                    Angle(degrees: 0),
                    axis: (x: 0, y: 1, z: 0)
                )
            
            // Back
            RoundedRectangle(cornerRadius: 20)
                .fill(backFill)
                .overlay(
                    Text("\(count)")
                        .foregroundColor(backText)
                        .font(.largeTitle)
                        .bold()
                )
                .opacity(flipped ? 1 : 0)
                .rotation3DEffect(
                    Angle(degrees: 180),
                    axis: (x: 0, y: 1, z: 0)
                )
        }
        .frame(width: 150, height: 150)
        .rotation3DEffect(
            Angle(degrees: flipAngle),
            axis: (x: 0, y: 1, z: 0)
        )
        .animation(.easeInOut(duration: 0.6), value: flipped)
        .onTapGesture {
            flipped.toggle()
        }
    }
}
