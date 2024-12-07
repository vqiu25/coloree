//
//  MoodEntry.swift
//  coloree
//
//  Created by Victor Esther Qiu on 07/12/2024.
//

import SwiftData
import Foundation

@Model
class MoodEntry {
    @Attribute(.unique) var id: UUID
    var date: Date
    var mood: MoodType
    
    init(mood: MoodType) {
        self.id = UUID();
        self.date = Date();
        self.mood = mood;
    }
}

enum MoodType: String, Codable, CaseIterable {
    case frustrated
    case broken
    case ok
    case hopeful
    case joyful
}
