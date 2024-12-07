//
//  ContentView.swift
//  coloree
//
//  Created by Victor Esther Qiu on 07/12/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        ZStack {
            // Background Colour
            Color("Wisteria")
                .edgesIgnoringSafeArea(.all)
            
            TabView {
                MoodTrackerView()
                    .tabItem { Image(systemName: "circle") }
                LogbookView()
                    .tabItem { Image(systemName: "text.book.closed.fill") }
                SettingsView()
                    .tabItem { Image(systemName: "gearshape") }
            }
        }
    }
}

#Preview {
    ContentView()
}
