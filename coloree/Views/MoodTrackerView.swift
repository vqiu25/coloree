//
//  MoodTrackerView.swift
//  coloree
//
//  Created by Victor Esther Qiu on 07/12/2024.
//

import SwiftUI

struct MoodTrackerView: View {
    
    @State private var isPulsing = true
    
    var body: some View {
        VStack {
            // Title Text
            HStack {
                Text("Colorée")
                    .font(.custom("Louize-MediumItalic", size: 50))
                    .font(.title)
                    .padding(.top, 40)
                Spacer()
            }
            .padding(.leading, 25)
            
            Spacer()
            
            // Mood Bubble
            ZStack {
                Circle()
                    .blur(radius: 200)
                    .padding(80)
                
                Circle()
                    .padding(80)
            }
            .padding(.bottom, 40)
            .onAppear {
                isPulsing = true
            }
            
            Spacer()
        }
    }
}

#Preview {
    MoodTrackerView()
}
