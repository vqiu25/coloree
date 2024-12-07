//
//  coloreeApp.swift
//  coloree
//
//  Created by Victor Esther Qiu on 07/12/2024.
//

import SwiftUI
import SwiftData

@main
struct coloreeApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: [MoodEntry.self])
    }
}
