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

    // A simple struct to hold counts per mood
    struct MoodCount {
        let mood: MoodType
        let count: Int
    }

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

    // Computed property for total count of entries
    var totalCount: Int {
        entries.count
    }

    // Computed property to get counts of each mood present in entries
    var moodCounts: [MoodCount] {
        MoodType.allCases.compactMap { mood in
            let count = entries.filter { $0.mood == mood }.count
            return count > 0 ? MoodCount(mood: mood, count: count) : nil
        }
    }
}
