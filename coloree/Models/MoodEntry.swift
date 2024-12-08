//
//  MoodEntry.swift
//  coloree
//
//  Created by Victor Esther Qiu on 07/12/2024.
//

import SwiftData
import Foundation
import SwiftUI

@Model
class MoodEntry {
    @Attribute(.unique) var id: UUID
    var timestamp: Date
    var mood: MoodType
    
    init(mood: MoodType) {
        self.id = UUID();
        self.timestamp = Date();
        self.mood = mood;
    }
}

enum MoodType: String, Codable, CaseIterable {
    case frustrated
    case broken
    case ok
    case hopeful
    case joyful
    
    var foregroundColor: Color {
        switch self {
        case .frustrated: return Color("Salmon")
        case .broken: return Color("Sky")
        case .ok: return Color("Lavendar")
        case .hopeful: return Color("Seafoam")
        case .joyful: return Color("Tangerine")
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .frustrated: return Color("Light Salmon")
        case .broken: return Color("Light Sky")
        case .ok: return Color("Wisteria")
        case .hopeful: return Color("Light Seafoam")
        case .joyful: return Color("Light Tangerine")
        }
    }
    
    var iconName: String {
        switch self {
        case .frustrated: return "exclamationmark.triangle.fill"
        case .broken: return "heart.slash.fill"
        case .ok: return "hand.thumbsup.fill"
        case .hopeful: return "sparkles"
        case .joyful: return "face.smiling.fill"
        }
    }
}
