//
//  MoodViewModel.swift
//  coloree
//
//  Created by Victor Esther Qiu on 07/12/2024.
//

import SwiftData
import SwiftUI

@MainActor
class MoodViewModel: ObservableObject {
    @Published var currentMood: MoodType = .ok
    @Published var entries: [MoodEntry] = []
    
    var context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
        loadEntries()
    }
    
    func loadEntries() {
        let fetchDescriptor = FetchDescriptor<MoodEntry>(
            sortBy: [.init(\.timestamp, order: .reverse)]
        )
        if let fetchedEntries = try? context.fetch(fetchDescriptor) {
            self.entries = fetchedEntries
            self.currentMood = fetchedEntries.first?.mood ?? .ok
        }
    }
    
    func addEntry(mood: MoodType) {
        let newEntry = MoodEntry(mood: mood)
        context.insert(newEntry)
        try? context.save()
        loadEntries()
    }
}
